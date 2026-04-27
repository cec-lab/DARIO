#Clear existing data and graphics
rm(list=ls())
graphics.off()

# SOURCE CONFIGURATION FILE ----

source("/home/imer/works/DARIO/config.R")

# SET WORKING DIRECTORY ----

setwd(baseDir)

# DATA LOAD ----

redcapData <- read_csv2(paste0(exportDir, "/redcapData_stage_4_1.csv"))

sdoData <- read_csv2(paste0(sdoDirMerge, "/", sdoFileNameMerge))

sdoData <- sdoData |> rename(data_source = source)
sdoData <- sdoData |> rename(prog_paz_neo = prog_paz)
sdoData$record_id <- as.character(sdoData$record_id)


# REMOVE SDO ALREADY RECORDED IN REDCAP ----

removeSDO <- which(sdoData$prog_paz_neo %in% redcapData$prog_paz_neo)

sdoRemovedData <- sdoData[removeSDO,]

sdoMergeData <- sdoData[-removeSDO,]


# HARMONIZE SDO DATASET ----

redcapData$birth_date <- ymd(redcapData$birth_date)
redcapData$birth_date <- str_replace_all(redcapData$birth_date, "-", "/")
redcapData$data_source <- "EDC"

sdoMergeData$birth_date <- str_replace_all(sdoMergeData$birth_date, "-", "/")
sdoMergeData$death_date <- str_replace_all(sdoMergeData$death_date, "-", "/")
sdoMergeData$datemo <- str_replace_all(sdoMergeData$datemo, "-", "/")
sdoMergeData$pm_notes <- ""
sdoMergeData$sp_illbef1 <- ""
sdoMergeData$sp_illbef2 <- ""
sdoMergeData$sp_illdur1 <- ""
sdoMergeData$sp_illdur2 <- ""
sdoMergeData$birthCenter <- ""
sdoMergeData$amniocentesis <- 9
sdoMergeData$chorvilsam <- 9
sdoMergeData$ultrason <- 9
sdoMergeData$data_source <- "SDO"
sdoMergeData$gestlength <- str_split_i(sdoMergeData$gestlength, "\\|", 1)
sdoMergeData$weight <- str_split_i(sdoMergeData$weight, "\\|", 1)

sdoMergeData <- sdoMergeData[, eurocat_vars_list]

ordered_cols <- c(eurocat_vars_list)
sdoMergeData <- sdoMergeData[, ordered_cols]

eurocatData <- rbind(redcapData, sdoMergeData)

eurocatData$premal1[redcapData$premal1 == 3] <- 1
eurocatData$premal2[redcapData$premal2 == 3] <- 1
eurocatData$premal3[redcapData$premal3 == 3] <- 1
eurocatData$premal4[redcapData$premal4 == 3] <- 1
eurocatData$premal5[redcapData$premal5 == 3] <- 1
eurocatData$premal6[redcapData$premal6 == 3] <- 1
eurocatData$premal7[redcapData$premal7 == 3] <- 1
eurocatData$premal8[redcapData$premal8 == 3] <- 1

eurocatData$presyn[redcapData$presyn == 3] <- 1

eurocatData$type[eurocatData$survival == 1] <- 1

## NUMLOC generation ----

postfix=1:dim(eurocatData)[1]
prefix=rep(Year, dim(eurocatData)[1])
lenPostfix=4 #max(str_length(postfix))
postfix_zero_padded=str_pad(postfix, width=lenPostfix, side="left", pad=0)
numloc=str_c(prefix, postfix_zero_padded)
eurocatData$numloc=numloc

# OUT ----

write_csv2(eurocatData, file = paste0(exportDir, "/eurocatData.csv"))
