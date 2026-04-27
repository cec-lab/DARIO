#     DATA MANAGEMENT AND TABLE EXTRACTION FROM IMER DATASET
#
#     GNU GPLv3
#
#     Copyright (C) 2024  Marco Manfrini, PhD
#     University of Ferrara - Dept Moedical Sciences
#     Center for Clinical and Epidemiological Research
#
#     This program is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
#
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
#
#     You should have received a copy of the GNU General Public License
#     along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
#     mnfmrc@unife.it

rm(list = ls())

# PATH ----

#wd=paste0("H:/Drive condivisi/IMER/database/estrazioni_dati/2024_vancini")
wd=paste0("/Users/mmanfrini/Library/CloudStorage/GoogleDrive-mnfmrc@unife.it/Drive condivisi/IMER/database/estrazioni_dati/2024_vancini")
setwd(wd)

if (!file.exists("out")){
  dir.create(file.path(wd, "out"))
}

if (!file.exists("preprocess")){
  dir.create(file.path(wd, "preprocess"))
}

indir=paste0(wd, "/preprocess")
outdir=paste0(wd, "/out")
#imerLibDir="D:/codice/imerLib"
imerLibDir="/Users/mmanfrini/Code/imer/codice/imerLib/imerLib"
#rbiostatfunboxDir="D:/codice/rbiostatfunbox"
rbiostatfunboxDir="/Users/mmanfrini/Code/rbiostatfunbox/rbiostatfunbox"
#dbDir="H:/Drive condivisi/IMER/database"
dbDir="/Users/mmanfrini/Library/CloudStorage/GoogleDrive-mnfmrc@unife.it/Drive condivisi/IMER/database"
dbName="Imer1978-2022.csv"

# PACKAGES ----

library(data.table)
library(epiR)
library(tableone)
library(rms)
library(readxl)
library(dplyr)
library(ggplot2)
library(gt)

source(paste0(rbiostatfunboxDir,"/funbox.R"))
source(paste0(imerLibDir, "/imerLib.R"))
source(paste0(imerLibDir, "/configuration.R"))

# GLOBAL VARS  AND DATA STRUCTURES ----

varSel=T

mdreport="Report.estrazione.Rmd"

extType = "R" # R=residenza; Q=ICD10

# Anno inizio
SY = 2012

# Anno fine
EY = 2021

# ICD search range
ICDRange = c(193:200)

## Cleft lip with or without cleft palate

codes<-c("Q05")

centroImer<-c(1)

# Codice comune
comCodeRange = c(53)

# Codice provincia

proCodeRange = c(52)

## Comuni di Imola (32) e Riolo Terme (15)

pcodes<-c(37, 39)

ccodes<-c(32, 15)

# DATA IMPORT ----

Imer1978.2022 <- read.csv("~/Library/CloudStorage/GoogleDrive-mnfmrc@unife.it/Drive condivisi/IMER/database/Imer1978-2022.csv", sep=";")
ImerFilterdByYear.1 <- Imer1978.2022 %>%
  filter(Anno>=SY & Anno <=EY, Centro==centroImer[1])

ImerFilterdByYear.2 <- Imer1978.2022 %>%
  filter(Anno>=SY & Anno <=EY, Centro==centroImer[2])

ImerFilterdByYear<-rbind(ImerFilterdByYear.1, ImerFilterdByYear.2)


rm(Imer1978.2022)

# RECODING VARS WITH LABELS

ImerFilterdByYear$Sesso<-ifelse(ImerFilterdByYear$Sesso==1, "M", "F")
ImerFilterdByYear$DiagnosiPrenatale<-ifelse(ImerFilterdByYear$DiagnosiPrenatale==9, "NA", 
                                            ifelse(ImerFilterdByYear$DiagnosiPrenatale==0, "No", "Si"))

ImerFilterdByYear$TipoDiNascita<-ifelse(ImerFilterdByYear$TipoDiNascita==1, "Vivo",
                                        ifelse(ImerFilterdByYear$TipoDiNascita==2, "Morto",
                                               ifelse(ImerFilterdByYear$TipoDiNascita==3, "Deceduto dupo la nascita",
                                                      "IVG")))

# CASE SELECTION ----

selected<-findICDCases(codes = codes, data = as.data.frame(ImerFilterdByYear[, c(ICDRange)]))
selected.cases<-ImerFilterdByYear[selected[[1]],]
selected.cases$selectedICD<-selected[[2]][,2]

selected.cases[, c(ICDRange)]

perc.malf.tot=round(dim(selected.cases)[1]/dim(ImerFilterdByYear)[1]*100,2)
perc.malf.tot

# PLOT ----

df<-selected.cases %>% group_by(Anno) %>% count
maxy<-max(df$n)

# Basic barplot
p<-ggplot(data=df, aes(x=Anno, y=n)) +
  geom_bar(stat="identity", width=0.5, fill="grey30") + # Percent add <position="fill">  
  scale_x_continuous(breaks = c(SY:EY)) +
  scale_y_continuous(breaks = seq(0, maxy, 2)) +
  theme_minimal() +
  theme(axis.text.x = element_text(size = rel(0.5), angle = 90, vjust = 0.5, hjust=1),
        axis.text.y = element_text(size = rel(0.5)),
        #panel.grid.minor = element_blank(),
        panel.grid.major = element_blank()
  ) +
  xlab("Anno") +
  ylab("Casi (N)")
p

jpeg(filename=paste0(outdir, "/casiperanno.jpg"), width = 4, height = 4, units = "in", quality = 75, res = 300)
  p
dev.off()

# TABELLA COORTE ----

# TABELLA CHIAVE IMER DIAGNOSI PRENATALE CSV ----

dset.descr<-selected.cases[,c(
  "ChiaveIMER",
  "DiagnosiPrenatale",
  "TipoDiNascita",
  "Sesso"
)]

sel<-which(dset.descr$ChiaveIMER=="H")
dset.descr[sel, "ChiaveIMER"]<-"I"

fact<-colnames(dset.descr)[c(1, 2, 3, 4)]

tabImerKey<-imerKeyTable(dset.descr, fact = fact)

# COUNTS ICD10 ----

dc<-data.frame(ICD10=unlist(selected.cases[ICDRange]))
dc.counts<-dc %>% group_by(ICD10) %>% count()
dc.counts.byYear <- selected.cases |> group_by(Anno) |> count()

# OUTPUT FILES ----

# Var selection

selected.cases.varSelected<-selected.cases[, selectedVars]

write.csv2(selected.cases[, c(ICDRange)], file = paste0(outdir, "/icd10.selected.csv"), row.names = F)
write.csv2(dc.counts, file = paste0(outdir, "/icd10.counts.csv"), row.names = F)
write.csv2(dc.counts.byYear, file=paste0(outdir, "/casiperanno.csv"), row.names = F)
write.csv2(tabImerKey, file=paste0(outdir, "/descriptive.imerkey.csv"))

# if var selection
if(varSel==T){
  write.csv2(selected.cases.varSelected, file = paste0(outdir, "/selected.csv"), row.names = F)
} else {
  write.csv2(selected.cases, file = paste0(outdir, "/selected.csv"), row.names = F)
}

# WRITE REPORT

rmarkdown::render(paste0(wd, "/", mdreport), output_file = paste0(outdir, "/report.html"))

# SESSION ----

sessionInfo()
