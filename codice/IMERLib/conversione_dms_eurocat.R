
rm(list=ls())


# ================ Packages ================

library(dplyr)
library(tidyr)
library(readxl)
library(stringr)
library(purrr)


#================ Path ================


source("/Users/luca/Library/CloudStorage/GoogleDrive-cmmlcu@unife.it/Drive condivisi/IMER/documenti/report/2025/codice/imerLib/imerLib.R")
source("/Users/luca/Library/CloudStorage/GoogleDrive-cmmlcu@unife.it/Drive condivisi/IMER/documenti/report/2025/codice/rbiostatfunbox/funbox.R")
wd <- "/Users/luca/Library/CloudStorage/GoogleDrive-cmmlcu@unife.it/Drive condivisi/IMER/documenti/report/2025/tabelle_eurocat"
path_cedap <- "~/Library/CloudStorage/GoogleDrive-cmmlcu@unife.it/Drive condivisi/IMER/database/Cedap/"
setwd(wd)


#================ 0) Caricamento popolazioni CEDAP ================

Cedap_2010_2023 <- read_csv2(paste0(wd,"/Cedap_2010_2023.csv"))
dms <- read_excel("~/Google Drive/Drive condivisi/IMER/documenti/report/2025/dms_export_2019_2023.xlsx")
cedap_popolazione_anno <- read_delim("~/Google Drive/Drive condivisi/IMER/database/Cedap/cedap.popolazione.anno.csv", 
                                     delim = ";", escape_double = FALSE, trim_ws = TRUE)
cedap_popolazione_anno <- select(cedap_popolazione_anno, year, birth_eurocat)


#================ 1) ANOMALIE EUROCAT → colonne 163:267 ================

anom_cols <- colnames(dms)[163:267]


#================ 2) Popolazione da CEDAP ================

popolazione <- cedap_popolazione_anno %>%
  rename(Anno = year, Popolazione = birth_eurocat)


#================ 3) Preparazione dati DMS per conteggi ================

dms2 <- dms %>%
  mutate(
    Anno = `Year of birth`,
    LB = ifelse(`Type of birth` == 1, 1, 0),
    FD = ifelse(`Type of birth` == 2, 1, 0),
    IVGx = ifelse(`Type of birth` == 4, 1, 0)   # rinominato a IVGx per evitare conflitti
  )


#================ 4) Ricostruzione dataset EUROCAT ================

dms_dataset <- map_dfr(anom_cols, function(a) {
  dms2 %>%
    group_by(Anno) %>%
    summarise(
      Registro = "Emilia Romagna",
      Anomalia = a,
      Popolazione = NA,
      `Nati vivi` = sum(LB * .data[[a]], na.rm=TRUE),
      `Nati morti` = sum(FD * .data[[a]], na.rm=TRUE),
      IVG = sum(IVGx * .data[[a]], na.rm=TRUE),
      Totali = sum(.data[[a]] == 1, na.rm=TRUE),
      .groups="drop"
    )
})


#================ 5) Aggiunta della popolazione corretta ================

dms_dataset <- dms_dataset %>%
  left_join(popolazione, by="Anno") %>%
  mutate(Popolazione = Popolazione.y) %>%
  select(-Popolazione.x, -Popolazione.y)


#================ 6) Calcolo PREVALENZE ================

dms_dataset <- dms_dataset %>%
  mutate(
    Prev = round(Totali / Popolazione * 10000, 2),
    PrevLV = round(`Nati vivi` / Popolazione * 10000, 2),
    PrevFD = round(`Nati morti` / Popolazione * 10000, 2),
    PrevIVG = round(IVG / Popolazione * 10000, 2)
  )


#================ 7) Calcolo proporzioni (95% CI) corrette ================

dms_dataset <- dms_dataset %>%
  mutate(
    `LB Proportion (95% CI)` = sprintf(
      "%.2f (%.2f - %.2f)",
      `Nati vivi` / Totali * 100,  # proporzione % su Totali
      pmax(0, (`Nati vivi` / Totali - 1.96 * sqrt((`Nati vivi` / Totali) * (1 - `Nati vivi` / Totali) / Totali)) * 100),
      (`Nati vivi` / Totali + 1.96 * sqrt((`Nati vivi` / Totali) * (1 - `Nati vivi` / Totali) / Totali)) * 100
    ),
    
    `FD Proportion (95% CI)` = sprintf(
      "%.2f (%.2f - %.2f)",
      `Nati morti` / Totali * 100,  # proporzione % su Totali
      pmax(0, (`Nati morti` / Totali - 1.96 * sqrt((`Nati morti` / Totali) * (1 - `Nati morti` / Totali) / Totali)) * 100),
      (`Nati morti` / Totali + 1.96 * sqrt((`Nati morti` / Totali) * (1 - `Nati morti` / Totali) / Totali)) * 100
    ),
    
    `TOPFA Proportion (95% CI)` = sprintf(
      "%.2f (%.2f - %.2f)",
      IVG / Totali * 100,  # proporzione % su Totali
      pmax(0, (IVG / Totali - 1.96 * sqrt((IVG / Totali) * (1 - IVG / Totali) / Totali)) * 100),
      (IVG / Totali + 1.96 * sqrt((IVG / Totali) * (1 - IVG / Totali) / Totali)) * 100
    )
  )


#================ 8) Rinomina colonne come richiesto ================

colnames(dms_dataset) <- c(
  "Years",                     # Anno
  "Registry",                   # Registro
  "Anomaly",                    # Anomalia
  "LB N",                       # Nati vivi
  "FD N",                       # Nati morti
  "TOPFA N",                    # IVG
  "Total N",                     # Totali
  "Population",                 # Popolazione
  "Total Prevalence (95% CI)",  # Prev
  "LB Prevalence (95% CI)",     # PrevLV
  "FD Prevalence (95% CI)",     # PrevFD
  "TOPFA Prevalence (95% CI)",  # PrevIVG
  "LB Proportion (95% CI)",     # LB Proportion
  "FD Proportion (95% CI)",     # FD Proportion
  "TOPFA Proportion (95% CI)"   # TOPFA Proportion
)
write_csv2(dms_dataset, paste0(wd, "/dms_dataset_report.csv"))
