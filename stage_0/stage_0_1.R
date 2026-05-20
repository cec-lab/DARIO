# STAGE0

# SOURCE CONFIGURATION FILE ----

baseDir=getwd()
source(paste0(baseDir,"/config.R"), echo = T)
source(paste0(baseDir,"/functions.R"), echo = T)
source(paste0(stage0Dir, "/selected_vars.R"))


# SET WORKING DIRECTORY ----

setwd(baseDir)

# DATA LOAD ----

redcapData <- read_csv2(paste0(exportDir, "/redcap_preprocess.csv"))
rm(data)

print("Reading CedAP data..")
cedap <- read_csv2(paste0(cedapDir,"/",cedapFileName), locale = locale(encoding = "WINDOWS-1252"))
problems(cedap)

print("Reading birth center data..")
birthCenters <- read_csv2(paste0(tablesDir,"/centri_imer.csv"))

# FILTER BY COHORT YEAR ----

redcapData$birth_date <- suppressWarnings(ymd(redcapData$birth_date))
redcapData$cohort <- year(redcapData$birth_date)
redcapData <- redcapData |> filter(cohort==Year)

# PREPROCESS REDCAP DATA ----

# Assign birth centers (cod_pres)

bc <- rep(NA, dim(redcapData)[1])

for(i in 1:dim(redcapData)[1]){
  m<-match(redcapData[i, "redcap_data_access_group"], birthCenters$Stabilimento)
  bc[i]<-unlist(birthCenters[m, "Codice"])
}

redcapData$birthCenter <- bc

# Assign birth centers (place)

ps <- rep(NA, dim(redcapData)[1])

for(i in 1:dim(redcapData)[1]){
  m<-match(redcapData[i, "redcap_data_access_group"], birthCenters$Stabilimento)
  ps[i]<-unlist(birthCenters[m, "Centro_IMER"])
}

redcapData$place <- ps


redcapData$numloc=0

## REDCAP DATE FORMATTING ----


# REDCAP DATA SOURCE ----

redcapData$data_source="EDC"

# STATS ----

redcapData |> mutate(sl=str_length(sdo_number)) |> group_by(redcap_data_access_group, sl) |> count() |> write_csv2(file = paste0(stage0Dir, "/dag_sdo_length_after.csv"))

allDagType <- redcapData |> group_by(redcap_data_access_group, type) |> count() |> write_csv2(file = paste0(stage0Dir, "/dag_type.csv"))

redcapData |> filter(type==4) |> count()


redcapData <- redcapData |> select(any_of(selectedVarsStage_0_2))
redcapData$sdo_number <- as.character(redcapData$sdo_number)

write_csv2(redcapData, file = paste0(exportDir, "/redcapData_stage_0_1.csv"), na="")

