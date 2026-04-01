# COSTRUZIONE DELLA TABELLA DEI DENOMINATORI

rm(list=ls())


# packages ----

library(tidyverse)
library(readr)

# Global variables ----

year=2020

# Path ----

wd=paste0("I:/Drive condivisi/IMER/database/", year, "/icbdsr")
setwd(wd)

# Dataset 2020 ----
cedap <- read_csv2("I:/Drive condivisi/IMER/database/Cedap/Cedap2020.csv")
imer <- read_csv2("I:/Drive condivisi/IMER/database/Imer1978-2022.csv") |> 
  filter(Anno==year)

View(cedap)
View(imer)

Denominators<-data.frame()

# DATA TABLE ----
# NATO VIVO VITALITA'  = 1 + 3 (se 3 verificare campo decesso = )
# NATO MORTO VITALITA' = 2


centre = 18
live = length(which(cedap$VITALITA==1 | cedap$VITALITA==3))
still = length(which(cedap$VITALITA==2))
topfa = length(which(imer$TipoDiNascita==4))
total = dim(cedap)[1]
notes = NA
obs_0_19  = length(which(cedap$ETA_M<20))
obs_20_24 = length(which(cedap$ETA_M>=20 & cedap$ETA_M<25))
obs_25_29 = length(which(cedap$ETA_M>=25 & cedap$ETA_M<30))
obs_30_34 = length(which(cedap$ETA_M>=30 & cedap$ETA_M<35))
obs_35_39 = length(which(cedap$ETA_M>=35 & cedap$ETA_M<40))
obs_40_44 = length(which(cedap$ETA_M>=40 & cedap$ETA_M<45))
obs_45 = length(which(cedap$ETA_M>=45))

row<-cbind(centre,
           year,
           live,
           still,
           topfa,
           total,
           notes,
           obs_0_19,
           obs_20_24,
           obs_25_29,
           obs_30_34,
           obs_35_39,
           obs_40_44,
           obs_45)

Denominators<-rbind(Denominators, row)

# WRITE DATASETS ----

write_csv2(Denominators, file = paste0(wd, "/denominators_icbdsr_", year, ".csv"))
