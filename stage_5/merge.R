# Clear existing data and graphics
rm(list=ls())
graphics.off()

# SOURCE CONFIGURATION FILE ----


baseDir = getwd()
source(paste0(baseDir,"/config.R"), echo = TRUE)
source(paste0(baseDir,"/functions.R"), echo = TRUE)

setwd(baseDir)


# DATA LOAD ----


redcapData <- read_csv2(paste0(exportDir, "/redcapData_stage_4_1.csv"))

sdoData <- read_csv2(
  paste0(gitDir, "/", sdoFileNameMerge),
  col_types = cols(
    birth_date = col_character(),
    death_date = col_character(),
    datemo     = col_character()
  )
)

sdoData <- sdoData |> rename(data_source = source)
sdoData <- sdoData |> rename(prog_paz_neo = prog_paz)
sdoData$record_id <- as.character(sdoData$record_id)

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



# Rimuovi duplicati interni
redcapData <- redcapData[!is.na(redcapData$prog_paz_neo), ]
sdoData    <- sdoData[!is.na(sdoData$prog_paz_neo), ]

# Priorità a REDCap → togli da SDO quelli già presenti
sdoMergeData <- sdoData[!(sdoData$prog_paz_neo %in% redcapData$prog_paz_neo), ]


# -------- SPLIT CAMPI --------

sdoMergeData$gestlength <- str_split_i(sdoMergeData$gestlength, "\\|", 1)
sdoMergeData$weight     <- str_split_i(sdoMergeData$weight, "\\|", 1)


# HARMONIZE DATASET ----


# -------- DATE CLEANING --------

# Applico a ENTRAMBI funzione
for (v in date_vars) {
  redcapData[[v]]    <- clean_date(redcapData[[v]])
  sdoMergeData[[v]]  <- clean_date(sdoMergeData[[v]])
}

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


# OUTPUT ----


write_csv2(eurocatData, file = paste0(exportDir, "/eurocatData.csv"), na="")

