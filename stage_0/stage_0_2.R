# STAGE_0_2

source(paste0(stage0Dir, "/selected_vars.R"))

redcapData <- redcapData |> select(any_of(selectedVarsStage_0_2))
redcapData$sdo_number <- as.character(redcapData$sdo_number)

write_csv2(redcapData, file = paste0(exportDir, "/redcapData_stage_0_2.csv"))
