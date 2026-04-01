# COSTRUZIONE DELLA TABELLA DEI DENOMINATORI 
# 

# packages ----

library(lubridate)


# CEDAP 2021 ----
cedap <- read.csv("C:/Users/marco/Documents/IMER/data/CeDAP/2021/cedap.2021.csv", sep=";")
View(cedap)

Denominators<-data.frame()

# DATA TABLE ----
# NATO VIVO VITALITA'  = 1 + 3 (se 3 verificare campo decesso = )
# NATO MORTO VITALITA' = 2


centre = 18
year  = 2021
live = length(which(cedap$VITALITA==1 | cedap$VITALITA==3))
still = length(which(cedap$VITALITA==2))
total = dim(cedap)[1]
notes = NA
obs_0_19  = length(which(cedap$ETA_M<20))
obs_20_24 = length(which(cedap$ETA_M>=20 & cedap$ETA_M<25))
obs_25_29 = length(which(cedap$ETA_M>=25 & cedap$ETA_M<30))
obs_30_34 = length(which(cedap$ETA_M>=30 & cedap$ETA_M<35))
obs_35_39 = length(which(cedap$ETA_M>=35 & cedap$ETA_M<40))
obs_40_44 = length(which(cedap$ETA_M>=40 & cedap$ETA_M<45))
obs_45 = length(which(cedap$ETA_M==45))
obs_35 = length(which(cedap$ETA_M==35))
obs_40 = length(which(cedap$ETA_M==40))

pt_date<-dmy(cedap$dt_parto)
pt_date_month<-month(pt_date)
obs_jan = length(which(pt_date_month==1))
obs_feb = length(which(pt_date_month==2))      
obs_mar = length(which(pt_date_month==3))      
obs_apr = length(which(pt_date_month==4))      
obs_may = length(which(pt_date_month==5))
obs_jun = length(which(pt_date_month==6))
obs_jul = length(which(pt_date_month==7))       
obs_aug = length(which(pt_date_month==8))      
obs_sep = length(which(pt_date_month==9))      
obs_oct = length(which(pt_date_month==10))     
obs_nov = length(which(pt_date_month==11))     
obs_dec = length(which(pt_date_month==12))      
completedDate = "31/12/2022 00:00:00"

row<-cbind(centre,
           year,
           live,
           still,
           total,
           notes,
           obs_0_19,
           obs_20_24,
           obs_25_29,
           obs_30_34,
           obs_35_39,
           obs_40_44,
           obs_45,
           obs_35,
           obs_40,
           obs_jan,
           obs_feb,
           obs_mar,
           obs_apr,
           obs_may,
           obs_jun,
           obs_jul,
           obs_aug,
           obs_sep,
           obs_oct,
           obs_nov,
           obs_dec,
           completedDate)

Denominators<-rbind(Denominators, row)


# WRITE DATASETS ----

write.csv2(Denominators, file = paste0(getwd(), "/denominators_2021.csv"), row.names = F)
