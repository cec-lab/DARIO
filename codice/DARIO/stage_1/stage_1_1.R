# STAGE 1
# LINKAGE WITH CEDAP PLUS

source(paste0(baseDir, "/functions.R"))

# LINKAGE KEY ----

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

nonLinkedNoIvgDagSdoNumber <- redcapData_cedap_nonlinked |> filter(type!=4) |> select(redcap_data_access_group, sdo_number, sdo_number_std) |> write_csv2(file = paste0(stage1Dir, "/nonlinked_noivg_sdo_number.csv"))


# OUT ----

write_csv2(redcapData_cedap_linked, file=paste0(stage1Dir, "/redcapData_cedap_linked_tmp.csv"))

write_csv2(redcapData_cedap_nonlinked, file=paste0(stage1Dir, "/redcapData_cedap_nonlinked_tmp.csv"))

write_csv2(redcapData, file=paste0(exportDir, "/redcapData_stage_1_1.csv"))


