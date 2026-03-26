# STAGE 1
# LINKAGE WITH CEDAP PLUS

baseDir=getwd()
source(paste0(baseDir,"/config.R"), echo = T)
source(paste0(baseDir,"/functions.R"), echo = T)
source(paste0(redcapDir, "/preprocess_edc.R"), echo = T)


# LINKAGE KEY ----
redcapData <- read_csv2(paste0(exportDir, "/redcapData_stage_0_1.csv"))
cedap <- read_csv2(paste0(cedapDir, "/cedap_plus_2023.csv"))

# REDCAP SDO NUMBER FORMATTING ----

redcapData |> mutate(sl=str_length(sdo_number)) |> group_by(redcap_data_access_group, sl) |> count() |> write_csv2(file = paste0(stage0Dir, "/dag_sdo_length_before.csv"))

sdo_number_before <- redcapData |> pull(sdo_number)

sdo_number_updated <- str_sub(sdo_number_before, -6) |> str_remove("^0+")

redcapData$sdo_number_std <- sdo_number_updated

cedap_sdo_before <- cedap |> pull(SDO_NEO)

cedap_sdo_updated <- str_sub(cedap_sdo_before, -6) |> str_remove("^0+")

cedap$SDO_NEO_STD <- cedap_sdo_updated

cedap$COD_STAB <- cedap$COD_STAB |> str_remove("^0+")


redcapData$sdo_number <- as.character(redcapData$sdo_number)

redcapData$linkageKey <- paste0(redcapData$birthCenter, redcapData$sdo_number_std)

cedap$linkageKey <- paste0(cedap$COD_STAB, cedap$SDO_NEO_STD)

# LOOK UP ----

linked = rep(0, dim(redcapData)[1])

for(i in 1:dim(redcapData)[1]){
  linked[i]<-linkBySdoNeo(redcapData[i, "linkageKey"], cedap$linkageKey)
}

redcapData$cedap_linked=linked

# REMOVE RECORDVALIDATION = 0

redcapData <- redcapData |> filter(valid_case==1)

redcapData_cedap_linked <- redcapData  |> filter(cedap_linked!=0) 

redcapData_cedap_nonlinked <- redcapData  |> filter(cedap_linked==0)


# STAT ----

allDag <- redcapData |> group_by(redcap_data_access_group, type) |> count() |> write_csv2(file = paste0(stage1Dir, "/all_dag.csv"))

nonLinkedDagType <- redcapData_cedap_nonlinked |> group_by(redcap_data_access_group, type) |> count() |> write_csv2(file = paste0(stage1Dir, "/nonlinked_dag_type.csv"))

nonLinkedNoIvgDagSdoNumber <- redcapData_cedap_nonlinked |> filter(type!=4) |> select(redcap_data_access_group, sdo_number) |> write_csv2(file = paste0(stage1Dir, "/nonlinked_noivg_sdo_number.csv"))


# OUT ----

write_csv2(redcapData_cedap_linked, file=paste0(stage1Dir, "/redcapData_cedap_linked_tmp.csv"))

write_csv2(redcapData_cedap_nonlinked, file=paste0(stage1Dir, "/redcapData_cedap_nonlinked_tmp.csv"))

write_csv2(redcapData, file=paste0(exportDir, "/redcapData_stage_1_1.csv"))

gitDir <- file.path(Sys.getenv("HOME"), "Desktop", "git_hub", "SARA", "export")
write_csv2(redcapData, file = file.path(gitDir, "redcapData_stage_1_1.csv"))


