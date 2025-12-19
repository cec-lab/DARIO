# STAGE0

# SOURCE CONFIGURATION FILE ----

source("/home/imer/works/DARIO/config.R")

# SET WORKING DIRECTORY ----

setwd(baseDir)

# DATA LOAD ----

redcapData <- data
rm(data)

print("Reading CedAP data..")
cedap <- read_csv2(paste0(cedapDir,"/",cedapFileName), locale = locale(encoding = "WINDOWS-1252"))
problems(cedap)

print("Reading birth center data..")
birthCenters <- read_csv2(paste0(tablesDir,"/centri_imer.csv"))

# FILTER BY COHORT YEAR ----

redcapData$cohort <- year(redcapData$birth_date)
redcapData <- redcapData |> filter(cohort==Year)

# PREPROCESS REDCAP DATA ----

# Assign birth centers

bc <- rep(NA, dim(redcapData)[1])

for(i in 1:dim(redcapData)[1]){
  m<-match(redcapData[i, "redcap_data_access_group"], birthCenters$Stabilimento)
  bc[i]<-unlist(birthCenters[m, "Codice"])
}

redcapData$birthCenter <- bc

# source(paste0(stage0Dir, "/01_label_redcap_data.R"))

# source(paste0(stage0Dir, "/02_process_ICD10_fields_redcap_data.R"))

# source(paste0(stage0Dir, "/03_process_ATC_code_fields_redcap_data.R"))

## NUMLOC generation ----

# postfix=1:dim(redcapData)[1]
# prefix=rep(Year, dim(redcapData)[1])
# lenPostfix=max(str_length(postfix))
# postfix_zero_padded=str_pad(postfix, width=lenPostfix, side="left", pad=0)
# numloc=str_c(prefix, postfix_zero_padded)
redcapData$numloc=0

## REDCAP DATE FORMATTING ----

# redcapData$birth_date=format(redcapData$birth_date, "%d/%m/%Y")
# redcapData$death_date=format(redcapData$death_date, "%d/%m/%Y")
# redcapData$datemo=format(redcapData$datemo, "%d/%m/%Y")
# redcapData$agefa=format(redcapData$agefa, "%d/%m/%Y")

# REDCAP SDO NUMBER FORMATTING ----

redcapData |> mutate(sl=str_length(sdo_number)) |> group_by(redcap_data_access_group, sl) |> count() |> write_csv2(file = paste0(stage0Dir, "/dag_sdo_length_before.csv"))

sdo_number_before <- redcapData |> pull(sdo_number)

sdo_number_updated <- str_sub(sdo_number_before, -6) |> str_remove("^0+")

redcapData$sdo_number_std <- sdo_number_updated

cedap_sdo_before <- cedap |> pull(SDO_NEO)

cedap_sdo_updated <- str_sub(cedap_sdo_before, -6) |> str_remove("^0+")

cedap$SDO_NEO_STD <- cedap_sdo_updated

# cedap$COD_PRES <- cedap$COD_PRES |> str_remove("^0+")

cedap$COD_STAB <- cedap$COD_STAB |> str_remove("^0+")

## RIMINI

# sdo_number_before <- redcapData |> filter(redcap_data_access_group=="rimini") |> pull(sdo_number_std)
# 
# sdo_number_updated <- str_sub(sdo_number_before, -5)
# 
# sdo_number_updated <- str_remove(sdo_number_updated, "^0+")
# 
# redcapData[which(redcapData$redcap_data_access_group=="rimini"), "sdo_number_std"]<-sdo_number_updated


# REDCAP DATA SOURCE ----

redcapData$data_source="EDC"

# STATS ----

redcapData |> mutate(sl=str_length(sdo_number)) |> group_by(redcap_data_access_group, sl) |> count() |> write_csv2(file = paste0(stage0Dir, "/dag_sdo_length_after.csv"))

allDagType <- redcapData |> group_by(redcap_data_access_group, type) |> count() |> write_csv2(file = paste0(stage0Dir, "/dag_type.csv"))

redcapData |> filter(type==4) |> count()

# cedap[(which(duplicated(cedap$prog_paz_neo)==T)),] |> write_csv2(file = paste0(stage0Dir, "/cedap_duplicati_prog_paz_neo.csv"))
# 
# cedap |> filter(COD_PRES=="080908") |> select(COD_PRES, SDO_NEO) |> write_csv2(file = paste0(stage0Dir, "/cedap_sorsola_cod_pres_sdo_v4.csv"))
#  
# cedap |> filter(COD_PRES=="080021") |> select(COD_PRES, SDO_NEO) |> write_csv2(file = paste0(stage0Dir, "/cedap_smaria_nuovare_cod_pres_sdo_v4.csv"))
#  
# cedap |> filter(COD_PRES=="080904") |> select(COD_PRES, SDO_NEO) |> write_csv2(file = paste0(stage0Dir, "/cedap_policlinicomo_cod_pres_sdo_v4.csv"))
#  
# cedap |> filter(COD_PRES=="080053") |> select(COD_PRES, SDO_NEO) |> write_csv2(file = paste0(stage0Dir, "/cedap_maggiore__bo_cod_pres_sdo_v4.csv"))
#  
# cedap |> filter(COD_PRES=="080095") |> select(COD_PRES, SDO_NEO) |> write_csv2(file = paste0(stage0Dir, "/cedap_rimini_cod_pres_sdo_v4.csv"))
#  
# cedap |> filter(COD_PRES=="080902") |> select(COD_PRES, SDO_NEO) |> write_csv2(file = paste0(stage0Dir, "/cedap_ospedale_parma_cod_pres_sdo_v4.csv"))

