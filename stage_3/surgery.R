#Clear existing data and graphics
rm(list=ls())
graphics.off()

# SOURCE CONFIGURATION FILE ----

baseDir=getwd()
source(paste0(baseDir,"/config.R"), echo = T)
source(paste0(baseDir,"/functions.R"), echo = T)

# SET WORKING DIRECTORY ----

setwd(baseDir)

# DATA LOAD ----

redcapData <- read_csv2(paste0(exportDir, "/redcapData_stage_2_1.csv"))

sdoData <- read_csv2(file.path(sdoDir, sdoFileName))

sdoData$PROG_PAZ <- as.character(sdoData$PROG_PAZ)

# LINKAGE SURGERY ----

for(i in 1:dim(redcapData)[1]){
  rn <- grep(redcapData[i, "prog_paz_neo"], sdoData$PROG_PAZ)
  print(rn)
   if(length(rn)>0){
     validSurgType <- str_detect(sdoData[rn, "validation_type"], pattern = "2")
     print(validSurgType)
     print(paste("i", i))
     if(validSurgType == T) {
       print("surgery ok")
       redcapData[i, "surgery"] = 1
     }
   }
}

# OUT ----

write_csv2(redcapData, file = paste0(exportDir, "/redcapData_stage_3_1.csv"))

