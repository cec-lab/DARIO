# STAGE_0_2

source(paste0(stage0Dir, "/selected_vars.R"))

redcapData <- redcapData[, selectedVarsStage_0_2]

write_csv2(redcapData, file = paste0(exportDir, "/redcapData_stage_0_2.csv"))
