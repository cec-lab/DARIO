

rm(list = ls())


# ============================================================
# CODING WARNING - CONTROLLO QUALITA' EUROCAT
# ============================================================

library(dplyr)
library(purrr)
library(readr)
library(rlang)

# ===============================
# DATA IMPORT
# ===============================

root <- "/Users/luca/Library/CloudStorage/GoogleDrive-cmmlcu@unife.it/Drive condivisi/IMER/documenti/missing_outliers_DMS"
cat("Root directory:", root, "\n")
list.files(root)

eurocatData <- read_delim("~/Google Drive/Drive condivisi/IMER/documenti/missing_outliers_DMS/eurocatData_merged.csv", 
                          delim = ";", escape_double = FALSE, trim_ws = TRUE)

DMS_clean   <- read_delim(paste0(root, "/DMS_export_2010_2023.csv"),
                          delim = ";", escape_double = FALSE, trim_ws = TRUE)

eurocatData_test_Luca <- read_csv2("~/Google Drive/Drive condivisi/IMER/database/qc/DARIO/indir/eurocatData_test_Luca2.csv",  col_types = cols(
  birth_date = col_character(),
  death_date = col_character(),
  datemo     = col_character()))

eurocatData_test_Luca <- eurocatData_test_Luca %>%
  rename(residmo = resmo)

# ============================================================
# 1️⃣ CARICAMENTO REGOLE
# ============================================================

CODING_QC_Eurocat <- read_csv2(
  "~/Google Drive/Drive condivisi/IMER/documenti/missing_outliers_DMS/CODING_QC_Eurocat.csv",
  locale = locale(encoding = "UTF-8")
)

CODING_QC_Eurocat <- CODING_QC_Eurocat %>% tibble::as_tibble()

# Se non esiste TestoWarning lo creiamo
if(!"TestoWarning" %in% names(CODING_QC_Eurocat)){
  CODING_QC_Eurocat$TestoWarning <- CODING_QC_Eurocat$REGOLA
}

# ============================================================
# 2️⃣ CONVERSIONE AUTOMATICA FACTOR NUMERICI
# ============================================================

vars_numeric <- c(
  "sex","nbrbaby","nbrmalf","type","civreg","survival",
  "agemo","bmi","totpreg","whendisc","condisc","agedisc",
  "firstpre","pm","presyn","premal1","premal2","premal3",
  "premal4","premal5","premal6","premal7","premal8"
)

vars_numeric <- intersect(vars_numeric, names(DMS_clean))

DMS_clean <- DMS_clean %>%
  mutate(across(
    all_of(vars_numeric),
    ~ suppressWarnings(as.numeric(as.character(.)))
  ))

# ============================================================
# 3️⃣ FUNZIONE TRADUZIONE REGOLA IN ITALIANO
# ============================================================

library(stringr)

traduci_regola <- function(regola){
  
  if(is.na(regola) || regola == "") return(NA_character_)
  
  testo <- regola
  
  # Pulizia doppie virgolette
  testo <- gsub('""', '"', testo, fixed = TRUE)
  
  # ===============================
  # grepl("^Q56", malfo1)
  # ===============================
  testo <- gsub(
    'grepl\\("\\^([A-Z0-9]+)",\\s*([a-zA-Z0-9_]+)\\)',
    '\\2 INIZIA CON \\1',
    testo
  )
  
  # ===============================
  # is.na
  # ===============================
  testo <- gsub("!is.na\\(([^)]+)\\)", "\\1 NON È NA", testo)
  testo <- gsub("is.na\\(([^)]+)\\)", "\\1 È NA", testo)
  
  # ===============================
  # %in% c(...)
  # ===============================
  testo <- gsub("%in% c\\(", " È ", testo)
  testo <- gsub("!= c\\(", " NON È ", testo)
  
  # sostituzione virgole SOLO dopo %in%
  testo <- gsub(",", " O ", testo)
  
  # rimuove c(
  testo <- gsub("c\\(", "", testo)
  
  # ===============================
  # Negazione parentesi
  # ===============================
  testo <- gsub("!\\(", "NON (", testo)
  
  # ===============================
  # Logici
  # ===============================
  testo <- gsub("\\&", " E ", testo)
  testo <- gsub("\\|", " OPPURE ", testo)
  
  # ===============================
  # Confronti
  # ===============================
  testo <- gsub("==", " È ", testo)
  testo <- gsub("!=", " NON È ", testo)
  testo <- gsub(">=", " MAGGIORE O UGUALE A ", testo)
  testo <- gsub("<=", " MINORE O UGUALE A ", testo)
  testo <- gsub(">", " MAGGIORE DI ", testo)
  testo <- gsub("<", " MINORE DI ", testo)
  
  testo <- gsub("\\)", "", testo)
  testo <- gsub("\\s+", " ", testo)
  testo <- trimws(testo)
  
  return(testo)
}
# ============================================================
# 4️⃣ FUNZIONE CHE APPLICA UNA REGOLA
# ============================================================

valuta_regola <- function(regola, messaggio, dataset){
  
  if(is.na(regola) || regola == "") return(NULL)
  
  regola_trad <- traduci_regola(regola)
  
  viol <- tryCatch({
    dataset %>%
      filter(!!parse_expr(regola)) %>%
      select(data_source, numloc)
  }, error = function(e){
    message("Errore nella regola:")
    message(regola)
    message("Motivo: ", e$message)
    return(NULL)
  })
  
  if(is.null(viol) || nrow(viol) == 0) return(NULL)
  
  viol %>%
    mutate(
      warning = messaggio,
      regola_tradotta = regola_trad
    ) %>%
    select(data_source, numloc, warning, regola_tradotta)
}
# ============================================================
# 5️⃣ APPLICAZIONE DI TUTTE LE REGOLE (SCEGLIERE IL DATASET)
# ============================================================

warnings_list <- purrr::map2(
  CODING_QC_Eurocat$REGOLA,
  CODING_QC_Eurocat$TestoWarning,
  ~valuta_regola(.x, .y, eurocatData_test_Luca)                       #CAMBIARE DATASET
)


warnings_df <- bind_rows(warnings_list)

# ============================================================
# 6️⃣ FREQUENZE WARNING (ORDINE DECRESCENTE)
# ============================================================

warnings_freq <- warnings_df %>%
  count(warning, regola_tradotta, data_source) %>%
  tidyr::pivot_wider(
    names_from = data_source,
    values_from = n,
    values_fill = 0
  ) %>%
  mutate(
    totale = rowSums(across(where(is.numeric)))
  ) %>%
  arrange(desc(totale))

# ============================================================
# 7️⃣ RAGGRUPPAMENTO PER NUMLOC
# ============================================================

warnings_grouped <- warnings_df %>%
  group_by(data_source, numloc) %>%
  summarise(
    warning = paste(warning, collapse = " | "),
    regola_tradotta = paste(regola_tradotta, collapse = " | "),
    .groups = "drop"
  )

# ============================================================
# 8️⃣ CREAZIONE CARTELLA OUTPUT
# ============================================================

output_dir <- "~/Google Drive/Drive condivisi/IMER/database/qc/DARIO/outdir"


# ============================================================
# 9️⃣ SALVATAGGIO CSV
# ============================================================

write_excel_csv2(
  warnings_df,
  file.path(output_dir, "warnings_df_eurocatData_test_Luca2.csv")
)

write_excel_csv2(
  warnings_freq,
  file.path(output_dir, "warnings_frequenze_eurocatData_test_Luca2.csv")
)

write_excel_csv2(
  warnings_grouped,
  file.path(output_dir, "warnings_raggruppati_per_numloc_eurocatData_test_Luca2.csv")
)

cat("✔ File salvati in:", output_dir)