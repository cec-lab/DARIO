

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
baseDir= getwd()
source(paste0(baseDir,"/config.R"))
source(paste0(baseDir,"/functions.R"))


eurocatData_test_Luca <- read_csv2(paste0(exportDir, "/eurocatData.csv"))
eurocatData_test_Luca   <- transcode_complete(eurocatData_test_Luca, eurocat_vars_list)
colSums(is.na(eurocatData_test_Luca))

eurocatData_test_Luca <- eurocatData_test_Luca %>%
  rename(residmo = resmo)

# ============================================================
# 1️⃣ CARICAMENTO WARNINGS
# ============================================================

source(paste0(baseDir,"/tables/regole_qc.R"))

# ============================================================
# 2️⃣ CONVERSIONE AUTOMATICA FACTOR NUMERICI
# ============================================================

vars_numeric <- c(
  "sex","nbrbaby","nbrmalf","type","civreg","survival",
  "agemo","bmi","totpreg","whendisc","condisc","agedisc",
  "firstpre","pm","presyn","premal1","premal2","premal3",
  "premal4","premal5","premal6","premal7","premal8"
)

vars_numeric <- intersect(vars_numeric, names(eurocatData_test_Luca))
eurocatData_test_Luca <- eurocatData_test_Luca %>%
  mutate(across(all_of(vars_numeric), as.numeric))

# ============================================================
# 3️⃣ FUNZIONE TRADUZIONE REGOLA IN ITALIANO
# ============================================================

library(stringr)

traduci_regola <- function(regola){
  
  if(is.na(regola) || regola == "") return(NA_character_)
  
  testo <- regola
  
  # Pulizia
  testo <- gsub('""', '"', testo, fixed = TRUE)
  
  # ===============================
  # MISSING (pattern completo)
  # ===============================
  
  # (is.na(x) | x == "")
  testo <- gsub(
    "\\(is.na\\(([^)]+)\\) \\| \\1 == ''\\)",
    "\\1 È VUOTO",
    testo
  )
  
  # !(is.na(x) | x == "")
  testo <- gsub(
    "!\\(is.na\\(([^)]+)\\) \\| \\1 == ''\\)",
    "\\1 È COMPILATO",
    testo
  )
  
  # ===============================
  # grepl
  # ===============================
  testo <- gsub(
    'grepl\\("\\^([A-Z0-9]+)",\\s*([a-zA-Z0-9_]+)\\)',
    '\\2 INIZIA CON \\1',
    testo
  )
  
  # ===============================
  # is.na residui
  # ===============================
  testo <- gsub("!is.na\\(([^)]+)\\)", "\\1 È VALORIZZATO", testo)
  testo <- gsub("is.na\\(([^)]+)\\)", "\\1 È NA", testo)
  
  # ===============================
  # %in%
  # ===============================
  testo <- gsub("%in% c\\(", " È TRA ", testo)
  testo <- gsub("c\\(", "", testo)
  testo <- gsub(",", " O ", testo)
  
  # ===============================
  # Negazione
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
  
  # ===============================
  # Pulizia finale
  # ===============================
  testo <- gsub("\\)", "", testo)
  testo <- gsub("\\s+", " ", testo)
  testo <- trimws(testo)
  
  return(testo)
}

# ============================================================
# 4️⃣ FUNZIONE CHE APPLICA UNA REGOLA
# ============================================================

valuta_regola <- function(regola, dataset){
  
  if(is.na(regola) || regola == "") return(NULL)
  
  viol <- tryCatch({
    dataset %>%
      filter(!!parse_expr(regola)) %>%
      mutate(
        warning = regola,
        regola_tradotta = traduci_regola(regola)
      ) %>%
      select(data_source, numloc, warning, regola_tradotta)
    
  }, error = function(e){
    message("❌ ERRORE REGOLA:")
    message(regola)
    message("Motivo: ", e$message)
    return(NULL)
  })
  
  if(is.null(viol) || nrow(viol) == 0) return(NULL)
  
  return(viol)
}
# ============================================================
# 5️⃣ APPLICAZIONE DI TUTTE LE REGOLE (SCEGLIERE IL DATASET)
# ============================================================
# ============================================================
# DEBUG VALIDAZIONE REGOLE
# ============================================================

check_regole <- function(regole){
  
  for(i in seq_along(regole)){
    
    res <- try(parse_expr(regole[i]), silent = TRUE)
    
    if(inherits(res, "try-error")){
      cat("\n❌ ERRORE REGOLA:", i, "\n")
      cat(regole[i], "\n")
    }
  }
}

check_regole(regole)

warnings_list <- purrr::map(
  regole,
  ~valuta_regola(.x, eurocatData_test_Luca)
)


warnings_df <- bind_rows(warnings_list)

if(nrow(warnings_df) == 0){
  cat("✔ Nessun warning trovato\n")
} 

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

output_dir <- exportDir


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