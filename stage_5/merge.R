# Clear existing data and graphics
rm(list=ls())
graphics.off()

# packages

library(readxl)

# SOURCE CONFIGURATION FILE ----


baseDir = getwd()
source(paste0(baseDir,"/config.R"), echo = TRUE)
source(paste0(baseDir,"/functions.R"), echo = TRUE)

setwd(baseDir)


# DATA LOAD ----


redcapData <- read_csv2(paste0(exportDir, "/redcapData_stage_4_1.csv"))

sdoData <- read_csv2(
  paste0(sdoDir, "/", sdoFileNameMerge),
  col_types = cols(
    birth_date = col_character(),
    death_date = col_character(),
    datemo     = col_character()
  )
)

sdoData <- sdoData |> rename(data_source = source)
sdoData <- sdoData |> rename(prog_paz_neo = prog_paz)
sdoData$record_id <- as.character(sdoData$record_id)

# PLACE OF BIRTH ----
# SDO: cod_pres -> place

centriImer <- read_excel(paste0(tablesDir, "/Stabilimenti.xlsx"))
centriImer$cod_stab <- str_remove(centriImer$cod_stab, "^0+")
centriIMERlookup <- setNames(centriImer$CentroIMER, centriImer$cod_stab)
sdoData$place <- centriIMERlookup[as.character(sdoData$cod_pres)]
sdoData[which(is.na(sdoData$place)), "place"]<-999


# CHECK DUPLICATI SDO ----

dup_sdo <- sdoData %>%
  count(prog_paz_neo) %>%
  filter(n > 1)

dup_edc <- redcapData %>%
  count(prog_paz_neo) %>%
  filter(n > 1)

#write_csv2(dup_sdo....)
#write_csv2(dup_edc....)


# RISOLUZIONE DUPLICATI REDCAP ----


# Priorità a REDCap → togli da SDO quelli già presenti
sdoMergeData <- sdoData[!(sdoData$prog_paz_neo %in% redcapData$prog_paz_neo), ]


# -------- SPLIT CAMPI --------

sdoMergeData$gestlength <- str_split_i(sdoMergeData$gestlength, "\\|", 1)
sdoMergeData$weight     <- str_split_i(sdoMergeData$weight, "\\|", 1)


# HARMONIZE DATASET ----


# -------- DATE CLEANING --------

# Applico a ENTRAMBI funzione
#for (v in date_vars) {
#  redcapData[[v]]    <- clean_date(redcapData[[v]])
#  sdoMergeData[[v]]  <- clean_date(sdoMergeData[[v]])
#}

# ------STRUTTURA DATI ---------
redcapData <- standardize_types(redcapData, vars_numeric)
sdoMergeData <- standardize_types(sdoMergeData, vars_numeric)


# TRANSCODIFICA SDO E REDCAP ----


sdoMergeData <- transcode_complete(sdoMergeData, eurocat_vars_list)
redcapData   <- transcode_complete(redcapData, eurocat_vars_list)


# -------- DATA SOURCE --------

redcapData$data_source <- "EDC"

sdoMergeData$amniocentesis <- 9
sdoMergeData$chorvilsam    <- 9
sdoMergeData$ultrason      <- 9
sdoMergeData$data_source   <- "SDO"


# -------- ALLINEAMENTO COLONNE --------

sdoMergeData <- sdoMergeData[, eurocat_vars_list]


# MERGE ----


eurocatData <- rbind(redcapData, sdoMergeData)



# NUMLOC GENERATION ----


postfix <- 1:nrow(eurocatData)
prefix  <- rep(Year, nrow(eurocatData))

postfix_zero_padded <- str_pad(postfix, width = 4, side = "left", pad = 0)

eurocatData$numloc <- str_c(prefix, postfix_zero_padded)


#Date formato per DMS
#bambino
eurocatData$birth_date <- ymd(eurocatData$birth_date)
eurocatData$birth_date <- format(eurocatData$birth_date,"%Y/%m/%d" )

#mamma
idx_real_date <- !is.na(eurocatData$datemo) &
  eurocatData$datemo != "" &
  eurocatData$datemo != "XXXX/XX/XX"

eurocatData$datemo[idx_real_date] <- format(
  ymd(eurocatData$datemo[idx_real_date]),
  "%Y/%m/%d"
)

#data di morte
idx_real_date2 <- !is.na(eurocatData$death_date) &
  eurocatData$death_date != "" &
  eurocatData$death_date != "2222/22/22" &
  eurocatData$death_date != "3333/33/33"

eurocatData$death_date[idx_real_date2] <- format(
  ymd(eurocatData$death_date[idx_real_date2]),
  "%Y/%m/%d"
)

# OUTPUT ----


write_csv2(eurocatData, file = paste0(exportDir, "/eurocatData.csv"), na="")

