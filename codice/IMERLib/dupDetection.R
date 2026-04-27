#     DUPLICATES RECORDS DETECTION IN IMER DATASET
#
#     Variables used for linkage: centro imer, data nascita probando, data nascita madre,
#     sesso probando, peso probando
#
#     GNU GPLv3
#
#     Copyright (C) 2024  Marco Manfrini, PhD
#     University of Ferrara - Dept Medical Sciences
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

wd=paste0("I:/Drive condivisi/IMER/database")
#wd=paste0("/Users/mmanfrini/Library/CloudStorage/GoogleDrive-mnfmrc@unife.it/Drive condivisi/IMER/database")
setwd(wd)

if (!file.exists("qc")){
  dir.create(file.path(wd, "qc"))
}

indir=wd
outdir=paste0(wd, "/qc")
imerLibDir="C:/Users/marco/Documents/Code/R/imerLib"
#imerLibDir="/Users/mmanfrini/Code/imer/codice/imerLib/imerLib"
rbiostatfunboxDir="C:/Users/marco/Documents/Code/R/rbiostatfunbox"
#rbiostatfunboxDir="/Users/mmanfrini/Code/rbiostatfunbox/rbiostatfunbox"
dbDir="I:/Drive condivisi/IMER/database"
#dbDir="/Users/mmanfrini/Library/CloudStorage/GoogleDrive-mnfmrc@unife.it/Drive condivisi/IMER/database"
cedapDir="I:/Drive condivisi/IMER/database/Cedap"
#cedapDir="/Users/mmanfrini/Library/CloudStorage/GoogleDrive-mnfmrc@unife.it/Drive condivisi/IMER/database/Cedap"

# PACKAGES ----


library(readxl)
library(dplyr)
library(stringr)
library(lubridate)
library(readr)
source(paste0(rbiostatfunboxDir,"/funbox.R"))
source(paste0(imerLibDir, "/imerLib.R"))
source(paste0(imerLibDir, "/configuration.R"))

# GLOBAL VARS  AND DATA STRUCTURES ----

imerKey=NULL

# DATA IMPORT ----

Imer1978.2022 <- read_csv2(paste0(indir, "/imer1978-2022.csv"))
View(Imer1978.2022)

# DUP KEY ----

## KEY

ImerCompletCasesImerKey<-Imer1978.2022[which(!is.na(Imer1978.2022$Anno)
                                             &  !is.na(Imer1978.2022$Centro) 
                                             &  !is.na(Imer1978.2022$DataNascProb) 
                                             &  !is.na(Imer1978.2022$DataNascMadre) 
                                             &   !is.na(Imer1978.2022$Sesso) 
                                             ),] # &   !is.na(Imer1978.2022$PesoNeonato)

ImerNotCompletCasesImerKey<-Imer1978.2022[which(is.na(Imer1978.2022$Anno)
                                                 |  is.na(Imer1978.2022$Centro) 
                                                 |  is.na(Imer1978.2022$DataNascProb) 
                                                 |  is.na(Imer1978.2022$DataNascMadre) 
                                                 |  is.na(Imer1978.2022$Sesso) 
                                              ),] # &   !is.na(Imer1978.2022$PesoNeonato)


imerKey=paste0(
  ImerCompletCasesImerKey$Anno,
  ImerCompletCasesImerKey$Centro,
  dmy(ImerCompletCasesImerKey$DataNascProb),
  dmy(ImerCompletCasesImerKey$DataNascMadre),
  ImerCompletCasesImerKey$Sesso #,
  # ImerCompletCasesImerKey$PesoNeonato
)



ImerCompletCasesImerKey$imerKey=imerKey

ImerCompletCasesImerKey$record_ID<-seq(1:dim(ImerCompletCasesImerKey)[1])

## DUPLICATE RECORDS DETECTION

dup<-which(duplicated(imerKey)==T)

dupRecords<-ImerCompletCasesImerKey[dup,]

table(dupRecords$Anno)

for(i in 1:dim(dupRecords)[1]){
  sel<-grep(dupRecords[i, "imerKey"], ImerCompletCasesImerKey$imerKey)
  print(sel)
  dupRecords[i, "Duplicate_rows"]<-paste0(sel, collapse = " ")
}

View(dupRecords)

dupKeys<-dupRecords[, c("Anno",
                        "Centro",
                        "DataNascProb",
                        "DataNascMadre",
                        "Sesso",
                        "PesoNeonato",
                        "imerKey",
                        "record_ID",
                        "Numero",
                        "Duplicate_rows")]

View(dupKeys)

# WRITE OUTPUT ----

write.csv2(dupRecords, file=paste0(outdir, "/duplicati.csv"), row.names = F)
write.csv2(dupKeys, file=paste0(outdir, "/duplicati_chiavi.csv"), row.names = F)
write.csv2(ImerCompletCasesImerKey, file=paste0(outdir, "/ImerCompletCasesImerKey.csv"), row.names = F)
write.csv2(ImerNotCompletCasesImerKey, file=paste0(outdir, "/ImerNotCompletCasesImerKey.csv"), row.names = F)

