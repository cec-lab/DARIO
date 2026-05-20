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


for(i in 1:nrow(redcapData)){
  
  current_prog <- redcapData$prog_paz_neo[i]
  
  # salta gli NA
  if(is.na(current_prog)) next
  
  # match esatto
  rn <- which(sdoData$PROG_PAZ == current_prog)
  
  if(length(rn) > 0){
    
    validSurgType <- str_detect(
      sdoData$validation_type[rn],
      pattern = "1"
    )
    
    if(any(validSurgType)){
      
      redcapData$surgery[i] <- 1
      
    }
  }
}


# OUT ----

write_csv2(redcapData, file = paste0(exportDir, "/redcapData_stage_3_1.csv"), na="")

