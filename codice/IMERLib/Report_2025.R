

rm(list=ls())

#================ LIBRERIE ================

library(data.table)
library(epiR)
library(ggplot2)
library(tableone)
library(rms)
library(readxl)
library(dplyr)
library(readr)
library(openxlsx)
library(lubridate)

#================ FUNZIONI ================

#source("/Users/luca/Library/CloudStorage/GoogleDrive-cmmlcu@unife.it/Drive condivisi/IMER/documenti/report/2025/codice/imerLib/imerLib.R")
#source("/Users/luca/Library/CloudStorage/GoogleDrive-cmmlcu@unife.it/Drive condivisi/IMER/documenti/report/2025/codice/rbiostatfunbox/funbox.R")
source("G:/Drive condivisi/IMER/documenti/report/2025/codice/imerLib/imerLib.R")
source("G:/Drive condivisi/IMER/documenti/report/2025/codice/rbiostatfunbox/funbox.R")

sanitize_filename <- function(x){
  x <- gsub("[/\\:*?\"<>|]", "_", x)
  x <- gsub("\\s+", "_", x)
  x <- gsub("[()]", "", x)
  x <- gsub("__+", "_", x)
  trimws(x)
}

smrCalc <- function(tmp, tmp_c, index){
  oo <- as.numeric(tmp["Totali", index])
  etn <- if("Totali" %in% rownames(tmp_c) && index <= ncol(tmp_c)) as.numeric(tmp_c["Totali", index]) else 0
  ep  <- if("Popolazione" %in% rownames(tmp_c) && index <= ncol(tmp_c)) as.numeric(tmp_c["Popolazione", index]) else 0
  otn <- as.numeric(tmp["Popolazione", index])
  
  ee <- if(!is.na(ep) && ep>0) etn/ep*otn else 0
  mm <- ifelse(oo <= 5, "mid.p", "vandenbroucke")
  
  if(!is.na(oo) && oo > 0){
    esmr <- epi.smr(o=oo, e=ee ,method = mm, conf.level = 0.95)
    return(paste0(round(esmr$est,2), " (", round(esmr$lower,2), " - ", round(esmr$upper,2), ")"))
  } else {
    return("0")
  }
}

getPPoints <- function(tmp, group, index){
  tt <- as.numeric(tmp["Totali", index])
  pp <- as.numeric(tmp["Popolazione", index])
  PrevTot <- round(tt/pp*10000, 2)
  conf.ll <- round((1.96/2 - sqrt(tt + 0.02))^2/pp*10000,2)
  conf.ul <- round((1.96/2 + sqrt(tt + 0.96))^2/pp*10000,2)
  data.frame(Anno=tmp["Anno", index],
             PrevTot=PrevTot,
             Pll=conf.ll,
             Pul=conf.ul,
             group=group)
}

makePlot <- function(pPoints, anom){
  file <- paste0(sanitize_filename(anom), ".jpg")
  path <- file.path(plotDir, file)
  cat("Plot →", path, "\n")
  jpeg(path, width=8, height=4, units="in", res=300)
  print(
    ggplot(pPoints, aes(x=Anno, y=PrevTot, group=group)) +
      geom_line(aes(color=group)) +
      geom_point(shape=21, size=2, aes(color=group, fill=group)) +
      geom_ribbon(aes(ymin=Pll, ymax=Pul, fill=group), alpha=0.1) +
      xlab("Anno") + ylab("Prevalenza totale (x10000)")
  )
  dev.off()
}

write_sanitized_csv <- function(data, dir, filename){
  path <- file.path(dir, sanitize_filename(filename))
  write.csv2(data, path, row.names=FALSE)
}

fill_down <- function(df, col){
  last = ""
  for(i in 1:nrow(df)){
    if(df[i,col] != "") last <- df[i,col]
    else df[i,col] <- last
  }
  df
}

#================ PATH ================

#wd <- "/Users/luca/Library/CloudStorage/GoogleDrive-cmmlcu@unife.it/Drive condivisi/IMER/documenti/report/2025/tabelle_eurocat"
#path_cedap <- "~/Library/CloudStorage/GoogleDrive-cmmlcu@unife.it/Drive condivisi/IMER/database/Cedap/"
wd <- "G:/Drive condivisi/IMER/documenti/report/2025/tabelle_eurocat"
path_cedap <- "G:/Drive condivisi/IMER/database/Cedap/"
setwd(wd)

dirs <- c("anomaly_groups", "other_syndrome", "genetic_anomalies", "selected_anomalies", "plot")
#for(d in dirs){ dir.create(file.path(wd, d), showWarnings = FALSE, recursive = TRUE) }

anomalyGroupsDir <- file.path(wd,"anomaly_groups")
otherSyndromeGroupsDir <- file.path(wd,"other_syndrome")
geneticAnomaliesDir <- file.path(wd,"genetic_anomalies")
selectedAnomaliesDir <- file.path(wd,"selected_anomalies")
plotDir <- file.path(wd,"plot")

#================ DATA IMPORT ================

dataset_combined <- read.csv2(paste0(wd, "/dataset_2019_2023_combined_exc_gen_con.csv"), check.names = FALSE, stringsAsFactors = FALSE, encoding = "UTF-8")
dataset <- read.csv2(paste0(wd, "/dataset_2019_2023_exc_gen.csv"), check.names = FALSE, stringsAsFactors = FALSE, encoding = "UTF-8")

Cedap_2010_2023 <- read_csv2(paste0(wd,"/Cedap_2010_2023.csv"), guess_max = Inf)
Cedap_2019_2023 <- Cedap_2010_2023 %>% filter(anno >= 2019 & anno <= 2023)

#================ RIPULISCI NOMI COLONNE ================

names(dataset) <- trimws(names(dataset))
names(dataset_combined) <- trimws(names(dataset_combined))

#================ RINOMINA COLONNE ================

dataset <- dataset %>%
  dplyr::rename(
    Anno = Years,
    Registro = Registry,
    Anomalia = Anomaly,
    `Nati vivi` = `LB N`,
    `Nati morti` = `FD N`,
    IVG = `TOPFA N`,
    Totali = `Total N`,
    Popolazione = Population,
    Prev = `Total Prevalence (95% CI)`,
    PrevLV = `LB Prevalence (95% CI)`,
    PrevFD = `FD Prevalence (95% CI)`,
    PrevIVG = `TOPFA Prevalence (95% CI)`
  ) %>%
  dplyr::select(Anno, Registro, Anomalia, Popolazione,
                `Nati vivi`, `Nati morti`, IVG, Totali,
                Prev, PrevLV, PrevFD, PrevIVG)

dataset_combined <- dataset_combined %>%
  dplyr::rename(
    Anno = Years,
    Registro = Registry,
    Anomalia = Anomaly,
    `Nati vivi` = `LB N`,
    `Nati morti` = `FD N`,
    IVG = `TOPFA N`,
    Totali = `Total N`,
    Popolazione = Population,
    Prev = `Total Prevalence (95% CI)`,
    PrevLV = `LB Prevalence (95% CI)`,
    PrevFD = `FD Prevalence (95% CI)`,
    PrevIVG = `TOPFA Prevalence (95% CI)`
  ) %>%
  dplyr::select(Anno, Registro, Anomalia, Popolazione,
                `Nati vivi`, `Nati morti`, IVG, Totali,
                Prev, PrevLV, PrevFD, PrevIVG)

#================ FILTRA RIGHE NON UTILI ================

dataset <- dataset %>% filter(!grepl("Source|Copyright|=", Registro))
dataset_combined <- dataset_combined %>% filter(!grepl("Total registries", Anomalia, ignore.case = TRUE))
dataset_combined$Anomalia <- gsub(
  "Ano-rectal atresia orand stenosis",
  "Ano-rectal atresia or stenosis",
  dataset_combined$Anomalia,
  fixed = TRUE
)

#================ FILL DOWN ================

dataset <- fill_down(dataset, 1)
dataset <- fill_down(dataset, 2)
dataset_combined <- fill_down(dataset_combined, 1)
dataset_combined <- fill_down(dataset_combined, 2)


#================ ANOMALY GROUPS ================

rgs <- unique(dataset$Registro)
l <- unique(dataset$Anomalia)

# Gruppi di anomalie
ags <- l[c(3, 70, 47, 43, 32, 83, 74, 48, 1, 28, 51, 61)]
oass <- l[c(37, 89, 35, 103, 77, 20, 88, 84, 102, 60, 93, 101, 67, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114)]
ga <- l[c(90, 41, 75, 45, 99, 97)]
ssa <- l[!(l %in% c(ags, oass, ga))]
ssa <- ssa[ssa != "Genetic disorders" & ssa != "Triploidy and polyploidy"]

colRegistry <- which(names(dataset) == "Registro")
colAnomaly <- which(names(dataset) == "Anomalia")
colNames <- intersect(names(dataset)[1:12], names(dataset_combined)[1:12])

#================ 1️⃣ AGS ================

total.prev <- data.frame()
for(k in ags){
  pPoints <- data.frame()
  esmr <- vector()
  tmp <- t(dataset[dataset[, colRegistry]==rgs[1] & dataset[, colAnomaly]==k, 1:12])
  tmp_c <- t(dataset_combined[dataset_combined[, colAnomaly]==k, 1:12])
  if(dim(tmp)[2] > 0){
    rownames(tmp) <- colNames
    rownames(tmp_c) <- colNames
    for(j in 1:dim(tmp)[2]){
      esmr <- c(esmr, smrCalc(tmp, tmp_c, j))
      pPoints <- rbind(pPoints, getPPoints(tmp, "IMER", j))
    }
    for(j in 1:dim(tmp_c)[2]){
      pPoints <- rbind(pPoints, getPPoints(tmp_c, "EUROCAT", j))
    }
    makePlot(pPoints, k)
    tmp <- rbind(tmp, esmr)
    rownames(tmp)[13] <- "SMR"
    tabname <- paste0(sanitize_filename(rgs[1]), "_", sanitize_filename(k))
    tabname_c <- paste0("Total_registries_", sanitize_filename(k), "_cmb")
    tpop.local <- sum(as.numeric(tmp["Popolazione",]))
    tcases.local <- sum(as.numeric(tmp["Totali",]))
    tprev.local <- round(tcases.local/tpop.local*10000,2)
    tprev.local.conf.ll <- round((1.96/2 - sqrt(tcases.local + 0.02))^2/tpop.local*10000,2)
    tprev.local.conf.ul <- round((1.96/2 + sqrt(tcases.local + 0.96))^2/tpop.local*10000,2)
    trow <- data.frame(Anomaly=tabname, Population=tpop.local, Cases=tcases.local,
                       Prevalence=tprev.local, Lower=tprev.local.conf.ll, Upper=tprev.local.conf.ul)
    total.prev <- rbind(total.prev, trow)
    write_sanitized_csv(tmp, anomalyGroupsDir, paste0(tabname, ".csv"))
    write_sanitized_csv(tmp_c, anomalyGroupsDir, paste0(tabname_c, ".csv"))
  }
}
write.csv2(total.prev, paste0(anomalyGroupsDir, "/total.prev.csv"), row.names = FALSE)

#================ 2️⃣ OASS ================

total.prev <- data.frame()
for(k in oass){
  pPoints <- data.frame()
  esmr <- vector()
  tmp <- t(dataset[dataset[, colRegistry]==rgs[1] & dataset[, colAnomaly]==k, 1:12])
  tmp_c <- t(dataset_combined[dataset_combined[, colAnomaly]==k, 1:12])
  if(dim(tmp)[2] > 0){
    rownames(tmp) <- colNames
    rownames(tmp_c) <- colNames
    for(j in 1:dim(tmp)[2]){
      esmr <- c(esmr, smrCalc(tmp, tmp_c, j))
      pPoints <- rbind(pPoints, getPPoints(tmp, "IMER", j))
    }
    for(j in 1:dim(tmp_c)[2]){
      pPoints <- rbind(pPoints, getPPoints(tmp_c, "EUROCAT", j))
    }
    makePlot(pPoints, k)
    tmp <- rbind(tmp, esmr)
    rownames(tmp)[13] <- "SMR"
    tabname <- paste0(sanitize_filename(rgs[1]), "_", sanitize_filename(k))
    tabname_c <- paste0("Total_registries_", sanitize_filename(k), "_cmb")
    tpop.local <- sum(as.numeric(tmp["Popolazione",]))
    tcases.local <- sum(as.numeric(tmp["Totali",]))
    tprev.local <- round(tcases.local/tpop.local*10000,2)
    tprev.local.conf.ll <- round((1.96/2 - sqrt(tcases.local + 0.02))^2/tpop.local*10000,2)
    tprev.local.conf.ul <- round((1.96/2 + sqrt(tcases.local + 0.96))^2/tpop.local*10000,2)
    trow <- data.frame(Anomaly=tabname, Population=tpop.local, Cases=tcases.local,
                       Prevalence=tprev.local, Lower=tprev.local.conf.ll, Upper=tprev.local.conf.ul)
    total.prev <- rbind(total.prev, trow)
    write_sanitized_csv(tmp, otherSyndromeGroupsDir, paste0(tabname, ".csv"))
    write_sanitized_csv(tmp_c, otherSyndromeGroupsDir, paste0(tabname_c, ".csv"))
  }
}
write.csv2(total.prev, paste0(otherSyndromeGroupsDir, "/total.prev.csv"), row.names = FALSE)

#================ 3️⃣ SSA – Selected Syndromes/Anomalies ================

total.prev <- data.frame()

for(k in ssa) {
  
  pPoints <- data.frame()
  esmr <- vector()
  
  tmp   <- t(dataset[dataset[, colRegistry] == rgs[1] & dataset[, colAnomaly] == k, 1:12])
  tmp_c <- t(dataset_combined[dataset_combined[, colAnomaly] == k, 1:12])
  
  if(ncol(tmp) == 0) {
    message("⚠ Nessun dato IMER per l’anomalia: ", k, " – salto")
    next
  }
  
  if(ncol(tmp_c) == 0) {
    message("⚠ Nessun dato EUROCAT per l’anomalia: ", k, " – salto")
    next
  }
  
  rownames(tmp)   <- colNames
  rownames(tmp_c) <- colNames
  for(j in 1:ncol(tmp)) {
    esmr <- c(esmr, smrCalc(tmp, tmp_c, j))
    pPoints <- rbind(pPoints, getPPoints(tmp, "IMER", j))
  }
  
  for(j in 1:ncol(tmp_c)) {
    pPoints <- rbind(pPoints, getPPoints(tmp_c, "EUROCAT", j))
  }
  
  makePlot(pPoints, k)
  
  tmp <- rbind(tmp, esmr)
  rownames(tmp)[nrow(tmp)] <- "SMR"
  
  tabname   <- paste0(sanitize_filename(rgs[1]), "_", sanitize_filename(k))
  tabname_c <- paste0("Total_registries_", sanitize_filename(k), "_cmb")
  
  tpop.local          <- sum(as.numeric(tmp["Popolazione", ]))
  tcases.local        <- sum(as.numeric(tmp["Totali", ]))
  tprev.local         <- round(tcases.local / tpop.local * 10000, 2)
  tprev.local.conf.ll <- round((1.96/2 - sqrt(tcases.local + 0.02))^2 / tpop.local * 10000, 2)
  tprev.local.conf.ul <- round((1.96/2 + sqrt(tcases.local + 0.96))^2 / tpop.local * 10000, 2)
  
  trow <- data.frame(
    Anomaly   = tabname,
    Population = tpop.local,
    Cases      = tcases.local,
    Prevalence = tprev.local,
    Lower      = tprev.local.conf.ll,
    Upper      = tprev.local.conf.ul
  )
  
  total.prev <- rbind(total.prev, trow)
  
  write_sanitized_csv(tmp, selectedAnomaliesDir, paste0(tabname, ".csv"))
  write_sanitized_csv(tmp_c, selectedAnomaliesDir, paste0(tabname_c, ".csv"))
}
write.csv2(total.prev, paste0(selectedAnomaliesDir, "/total.prev.csv"), row.names = FALSE)

#================ 4️⃣ GA ================

total.prev <- data.frame()
for(k in ga){
  pPoints <- data.frame()
  esmr <- vector()
  tmp <- t(dataset[dataset[, colRegistry]==rgs[1] & dataset[, colAnomaly]==k, 1:12])
  tmp_c <- t(dataset_combined[dataset_combined[, colAnomalia]==k, 1:12])
  if(dim(tmp)[2] > 0){
    rownames(tmp) <- colNames
    rownames(tmp_c) <- colNames
    for(j in 1:dim(tmp)[2]){
      esmr <- c(esmr, smrCalc(tmp, tmp_c, j))
      pPoints <- rbind(pPoints, getPPoints(tmp, "IMER", j))
    }
    for(j in 1:dim(tmp_c)[2]){
      pPoints <- rbind(pPoints, getPPoints(tmp_c, "EUROCAT", j))
    }
    makePlot(pPoints, k)
    tmp <- rbind(tmp, esmr)
    rownames(tmp)[13] <- "SMR"
    tabname <- paste0(sanitize_filename(rgs[1]), "_", sanitize_filename(k))
    tabname_c <- paste0("Total_registries_", sanitize_filename(k), "_cmb")
    tpop.local <- sum(as.numeric(tmp["Popolazione",]))
    tcases.local <- sum(as.numeric(tmp["Totali",]))
    tprev.local <- round(tcases.local/tpop.local*10000,2)
    tprev.local.conf.ll <- round((1.96/2 - sqrt(tcases.local + 0.02))^2/tpop.local*10000,2)
    tprev.local.conf.ul <- round((1.96/2 + sqrt(tcases.local + 0.96))^2/tpop.local*10000,2)
    trow <- data.frame(Anomaly=tabname, Population=tpop.local, Cases=tcases.local,
                       Prevalence=tprev.local, Lower=tprev.local.conf.ll, Upper=tprev.local.conf.ul)
    total.prev <- rbind(total.prev, trow)
    write_sanitized_csv(tmp, geneticAnomaliesDir, paste0(tabname, ".csv"))
    write_sanitized_csv(tmp_c, geneticAnomaliesDir, paste0(tabname_c, ".csv"))
  }
}
write.csv2(total.prev, paste0(geneticAnomaliesDir, "/total.prev.csv"), row.names = FALSE)







#================ 5️⃣ ALL ANOMALIES (NON GENETIC) ================

library(dplyr)
library(stringr)

anom <- "All anomalies"
total.prev <- data.frame()

# Trova automaticamente il registro corrispondente in dataset_exc
matched_registry <- dataset_exc$Registry[str_detect(dataset_exc$Registry, fixed(rgs[1], ignore_case = TRUE))][1]

# Filtra dataset locale e combinato
dataset_local_tmp <- dataset_exc %>% filter(Registry == matched_registry, str_trim(Anomaly) == str_trim(anom))
dataset_c_tmp <- dataset_combined_exc %>% filter(str_trim(Anomaly) == str_trim(anom))

# Crea tmp_df per IMER
tmp_df <- dataset_local_tmp %>%
  group_by(Years) %>%
  summarise(
    Registro = first(rgs[1]),
    Anomalia = first(anom),
    Anno = first(Years),
    Popolazione = sum(Population, na.rm = TRUE),
    `Nati vivi` = sum(`LB N`, na.rm = TRUE),
    `Nati morti` = sum(`FD N`, na.rm = TRUE),
    IVG = sum(`TOPFA N`, na.rm = TRUE),
    Totali = sum(`Total N`, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  mutate(
    Prev = round(Totali / Popolazione * 10000, 2),
    PrevLV = round(`Nati vivi` / Popolazione * 10000, 2),
    PrevFD = round(`Nati morti` / Popolazione * 10000, 2),
    PrevIVG = round(IVG / Popolazione * 10000, 2)
  ) %>%
  select(all_of(colNames))

tmp <- t(tmp_df)
rownames(tmp) <- colNames

# Crea tmp_c_df per EUROCAT
tmp_c_df <- dataset_c_tmp %>%
  group_by(Years) %>%
  summarise(
    Registro = "Total registries",
    Anomalia = first(Anomaly),
    Anno = first(Years),
    Popolazione = sum(Population, na.rm = TRUE),
    `Nati vivi` = sum(`LB N`, na.rm = TRUE),
    `Nati morti` = sum(`FD N`, na.rm = TRUE),
    IVG = sum(`TOPFA N`, na.rm = TRUE),
    Totali = sum(`Total N`, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  mutate(
    Prev = round(Totali / Popolazione * 10000, 2),
    PrevLV = round(`Nati vivi` / Popolazione * 10000, 2),
    PrevFD = round(`Nati morti` / Popolazione * 10000, 2),
    PrevIVG = round(IVG / Popolazione * 10000, 2)
  ) %>%
  select(all_of(colNames))

tmp_c <- t(tmp_c_df)
rownames(tmp_c) <- colNames

# Calcolo SMR e punti
pPoints <- data.frame()
esmr <- vector()
for(j in 1:ncol(tmp)){
  esmr <- c(esmr, smrCalc(tmp, tmp_c, j))
  pPoints <- rbind(pPoints, getPPoints(tmp, "IMER", j))
}
for(j in 1:ncol(tmp_c)){
  pPoints <- rbind(pPoints, getPPoints(tmp_c, "EUROCAT", j))
}

makePlot(pPoints, anom)
tmp <- rbind(tmp, esmr)
rownames(tmp)[13] <- "SMR"

# Prevalenze totali
tabname <- paste0(rgs[1], "_", anom)
tabname_c <- paste0("Total registries_", anom, "_cmb")
tpop.local <- sum(as.numeric(tmp["Popolazione", ]))
tcases.local <- sum(as.numeric(tmp["Totali", ]))
tprev.local <- round(tcases.local / tpop.local * 10000, 2)
tprev.local.conf.ll <- round((1.96 / 2 - sqrt(tcases.local + 0.02))^2 / tpop.local * 10000, 2)
tprev.local.conf.ul <- round((1.96 / 2 + sqrt(tcases.local + 0.96))^2 / tpop.local * 10000, 2)

trow <- data.frame(
  Anomaly = tabname,
  Population = tpop.local,
  Cases = tcases.local,
  Prevalence = tprev.local,
  Lower = tprev.local.conf.ll,
  Upper = tprev.local.conf.ul
)
total.prev <- rbind(total.prev, trow)

# Salvataggio CSV
write.csv2(tmp, paste0(selectedAnomaliesDir, "/", tabname, ".csv"))
write.csv2(tmp_c, paste0(selectedAnomaliesDir, "/", tabname_c, ".csv"))
write.csv2(total.prev, paste0(selectedAnomaliesDir, "/total.prev.csv"), row.names = FALSE)

#================ TABELLE SOCIODEMOGRAFICHE MADRI ================

library(lubridate)

Cedap_2019_2023$eta_m <- round(interval(Cedap_2019_2023$dt_nas_m, Cedap_2019_2023$dt_parto)/years(1),0)

Elenco_codici <- read_delim("G:/Drive condivisi/IMER/database/Elenco-codici-e-denominazioni-unita-territoriali-estere/Elenco-codici-e-denominazioni-al-31_12_2021.csv", 
                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

codici_area <- setNames(Elenco_codici$`Denominazione Area (IT)`, Elenco_codici$`Codice ISTAT`)
codici_area["100"] <- "Italia"
Cedap_2019_2023$cittadinanza_m_area <- codici_area[as.character(Cedap_2019_2023$cittadinanza_m)]
Cedap_2019_2023$bmi <- round(Cedap_2019_2023$peso_madre_pregravidico/(Cedap_2019_2023$altezza_madre/100)^2, 2)
Cedap_2019_2023$stato_civile_madre <- factor(Cedap_2019_2023$stato_civile_madre, 
                                             labels=c("Nubile", "Coniugata", "Separata", "Divorziata", "Vedova", "Non dichiarato"))

Cedap_2019_2023$titolo_di_studio_madre_recoded <- ifelse(Cedap_2019_2023$titolo_di_studio_madre == 0, 5, Cedap_2019_2023$titolo_di_studio_madre)

Cedap_2019_2023$titolo_di_studio_madre_recoded <- factor(Cedap_2019_2023$titolo_di_studio_madre_recoded,
                                                         labels = c("Laurea", "Diploma universitario", "Diploma media superiore", 
                                                                    "Diploma media inferiore", "Licenza elementare o nessun titolo"))

Cedap_2019_2023$fumo_decoded <- ifelse(Cedap_2019_2023$abitudine_al_fumo == 1, 1 , 
                                       ifelse(Cedap_2019_2023$abitudine_al_fumo == 2, 2, 
                                              ifelse(Cedap_2019_2023$abitudine_al_fumo == 11, 3,
                                                     ifelse(Cedap_2019_2023$abitudine_al_fumo == 12, 4, 5))))

Cedap_2019_2023$fumo_decoded <- factor(Cedap_2019_2023$fumo_decoded, labels = c("Si", "No", "Smesso prima della gravidanza",
                                                                                "Smesso a inizio gravidanza", "Continuato a fumare in gravidanza"))

Cedap_2019_2023$concepimenti_precedenti_recoded <- ifelse(Cedap_2019_2023$concepimenti_precedenti > 1, 2, 1)
Cedap_2019_2023$concepimenti_precedenti_recoded <- factor(Cedap_2019_2023$concepimenti_precedenti_recoded, labels = c("No", "Si"))

Cedap_2019_2023$metodi_pma_recoded <- ifelse(Cedap_2019_2023$metodi_pma %in% c(1,3,4,5), 2, 1)
Cedap_2019_2023$metodi_pma_recoded <- factor(Cedap_2019_2023$metodi_pma_recoded, labels = c("No", "Si"))

vars_mamma <- c("eta_m",
                "stato_civile_madre",
                "cittadinanza_m_area",
                "titolo_di_studio_madre_recoded",
                "bmi",
                "fumo_decoded",
                "concepimenti_precedenti_recoded", 
                "metodi_pma_recoded")

nnorm <- c("eta_m", "bmi")

tab_M_sociodemog <- CreateTableOne(vars=vars_mamma, strata = "anno", data=Cedap_2019_2023, factorVars=c("stato_civile_madre",
                                                                                                        "cittadinanza_m_area",
                                                                                                        "titolo_di_studio_madre",
                                                                                                        "fumo_decoded",
                                                                                                        "concepimenti_precedenti_recoded",
                                                                                                        "metodi_pma_recoded"
))
tab_M_df <- as.data.frame(print(tab_M_sociodemog, quote=FALSE, noSpaces=TRUE, nonnormal = nnorm))
tab_M_df <- cbind(Variable=rownames(tab_M_df), tab_M_df); rownames(tab_M_df) <- NULL
write_csv2(tab_M_df, paste0(wd,"/tab_M_sociodemog.csv"))

tab_M_sociodemog <- CreateTableOne(vars=vars_mamma, data=Cedap_2019_2023, factorVars=c("stato_civile_madre",
                                                                                       "cittadinanza_m_area",
                                                                                       "titolo_di_studio_madre",
                                                                                       "fumo_decoded",
                                                                                       "concepimenti_precedenti_recoded",
                                                                                       "metodi_pma_recoded"
))
tab_M_df <- as.data.frame(print(tab_M_sociodemog, quote=FALSE, noSpaces=TRUE, nonnormal = nnorm))
tab_M_df <- cbind(Variable=rownames(tab_M_df), tab_M_df); rownames(tab_M_df) <- NULL
write_csv2(tab_M_df, paste0(wd,"/tab_M_sociodemog_overall.csv"))

#================ TABELLE SOCIODEMOGRAFICHE NEONATI ================

dms_data <- read_csv("G:/Drive condivisi/IMER/documenti/report/2025/dms_2019_2023.csv", guess_max = Inf)

# Cedap_2019_2023 <- Cedap_2019_2023 %>% mutate(
#   sesso = case_when(nati_maschi==1 ~ "M", nati_femmine==1 ~ "F", TRUE ~ NA_character_),
#   sesso=factor(sesso, levels=c("M","F")),
#   genere_del_parto = case_when(genere_del_parto==1 ~ "Semplice",
#                                genere_del_parto==2 ~ "Plurimo", TRUE ~ NA_character_),
#   genere_del_parto=factor(genere_del_parto, levels=c("Semplice","Plurimo"))
# )

dms_data$sex_factor <- factor(dms_data$sex, labels = c("Femmina", "Maschio", "Indeterminato", "Non noto"))

dms_data$type_recoded_factor <- factor(dms_data$type, labels = c("Nato vivo", "Nato morto", "IVG"))

dms_data$matedu_recoded <- dms_data$matedu
dms_data[which(dms_data$matedu_recoded == 0), "matedu_recoded"] <- 9

dms_data$matedu_factor <- factor(dms_data$matedu_recoded, labels = c("Licenza elementare o media inferiore",
                                                             "Licenza media superiore",
                                                             "Università",
                                                             "Non noto"))

dms_data$assconcept_recoded <- ifelse(dms_data$assconcept == 0, 1, 
                                      ifelse(dms_data$assconcept == 9, 9, 2))

dms_data$assconcept_factor <- factor(dms_data$assconcept_recoded, labels = c("No",
                                                              "Si",
                                                              "Non noto"))

dms_data$matdiab_factor <- factor(dms_data$matdiab, labels = c("Tipo 1",
                                                               "Tipo 2",
                                                               "MODY",
                                                               "Non specificato",
                                                               "Insulino resistenza",
                                                               "No",
                                                               "Non noto"))

dms_data$folic_g14_factor <- factor(dms_data$folic_g14, labels = c("Pre e post concepimento",
                                                            "Post concepimento",
                                                            "No",
                                                            "Si, non specificato",
                                                            "Non noto"))

dms_data$firsttri_factor <- factor(dms_data$firsttri, labels = c("Si",
                                                                 "No",
                                                                 "Si, non specificato",
                                                                 "Non noto"))

dms_data$consang_factor <- factor(dms_data$consang,labels = c("No", 
                                                             "Si",
                                                             "Non noto"))

dms_data$totpreg_recoded <- ifelse(dms_data$totpreg == 99, NA, dms_data$totpreg)
dms_data$totpreg_recoded <- ifelse(dms_data$totpreg_recoded == 0, NA, dms_data$totpreg_recoded)
dms_data$totpreg_recoded <- ifelse(dms_data$totpreg_recoded == 1, 1, 2)

dms_data$totpreg_factor <- factor(dms_data$totpreg_recoded, labels = c("Una",
                                                                        "Più di una"))
dms_data[which(dms_data$weight == 9999), "weight"] <- NA

dms_data[which(dms_data$bmi == 99), "bmi"] <- NA

vars_neonato <- c("agemo",
                  "sex_factor", 
                  "type_recoded_factor", 
                  "totpreg_factor", 
                  "weight", 
                  "gestlength", 
                  "bmi", 
                  "matdiab_factor", 
                  "folic_g14_factor", 
                  "firsttri_factor", 
                  "assconcept_factor", 
                  "consang_factor", 
                  "matedu_factor",
                  "mocitizenship")

factorVars_neonato <- c("sex_factor",
                        "type_recoded_factor",
                        "totpreg_factor",
                        "matdiab_factor", 
                        "folic_g14_factor", 
                        "firsttri_factor", 
                        "assconcept_factor", 
                        "consang_factor", 
                        "matedu_factor",
                        "mocitizenship"
                        )

nnorm <- c("bmi", "gestlength", "agemo", "weight")

tab_N_sociodemog <- CreateTableOne(vars=vars_neonato, data=dms_data, strata = "byear", factorVars=factorVars_neonato)
tab_N_df <- as.data.frame(print(tab_N_sociodemog, quote=FALSE, noSpaces=TRUE, , nonnormal = nnorm))
tab_N_df <- cbind(Variable=rownames(tab_N_df), tab_N_df); rownames(tab_N_df) <- NULL
write_csv2(tab_N_df, paste0(wd,"/tab_N_sociodemog.csv"))

tab_N_sociodemog <- CreateTableOne(vars=vars_neonato, data=dms_data, factorVars=factorVars_neonato)
tab_N_df <- as.data.frame(print(tab_N_sociodemog, quote=FALSE, noSpaces=TRUE, , nonnormal = nnorm))
tab_N_df <- cbind(Variable=rownames(tab_N_df), tab_N_df); rownames(tab_N_df) <- NULL
write_csv2(tab_N_df, paste0(wd,"/tab_N_sociodemog_overall.csv"))


# PRENATALE GENETICHE ----

dms_data_pg <- dms_data[which(dms_data$mult_malf == "G"), ]

dms_data_pg$whendisc_factor <- factor(dms_data_pg$whendisc, labels =c("At birth",
                                                                      "Less than 1 week",
                                                                      "1-4 weeks",
                                                                      "1-12 months",
                                                                      "Prenatal diagnosis in live fetus",
                                                                      "Postnatal diagnosis, age not known"
))

vars_pg <- c("agemo",
          "gestlength", 
          "whendisc_factor")

factorVars_pg <- c("whendisc_factor")

nnorm <- c("gestlength", "agemo")

tab_N_sociodemog <- CreateTableOne(vars=vars_pg, data=dms_data_pg, strata = "byear", factorVars=factorVars_pg)
tab_N_df <- as.data.frame(print(tab_N_sociodemog, quote=FALSE, noSpaces=TRUE, , nonnormal = nnorm))
tab_N_df <- cbind(Variable=rownames(tab_N_df), tab_N_df); rownames(tab_N_df) <- NULL
write_csv2(tab_N_df, paste0(wd,"/tab_PG_sociodemog.csv"))

tab_N_sociodemog <- CreateTableOne(vars=vars_pg, data=dms_data_pg, factorVars=factorVars_pg)
tab_N_df <- as.data.frame(print(tab_N_sociodemog, quote=FALSE, noSpaces=TRUE, , nonnormal = nnorm))
tab_N_df <- cbind(Variable=rownames(tab_N_df), tab_N_df); rownames(tab_N_df) <- NULL
write_csv2(tab_N_df, paste0(wd,"/tab_PG_sociodemog_overall.csv"))



