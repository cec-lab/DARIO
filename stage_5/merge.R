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

if(nrow(dup_sdo) > 0){
  
  cat(" DUPLICATI TROVATI IN SDO (prog_paz_neo):\n")
  print(dup_sdo)
  
  cat("\n DETTAGLIO RECORD DUPLICATI:\n")
  print(
    sdoData %>%
      filter(prog_paz_neo %in% dup_sdo$prog_paz_neo) %>%
      arrange(prog_paz_neo)
  )
}


# RISOLUZIONE DUPLICATI REDCAP ----

dup_edc <- redcapData %>%
  count(prog_paz_neo) %>%
  filter(n > 1)
redcapData <- resolve_redcap_duplicates(redcapData)

#check
redcapData %>%
  filter(!is.na(prog_paz_neo)) %>%
  filter(duplicated(prog_paz_neo) | duplicated(prog_paz_neo, fromLast = TRUE))


# REMOVE SDO ALREADY RECORDED IN REDCAP ----

common_ids <- intersect(sdoData$prog_paz_neo, redcapData$prog_paz_neo)

# subset duplicati tra sdo e redcap
redcap_common <- redcapData[redcapData$prog_paz_neo %in% common_ids, ]
sdo_common    <- sdoData[sdoData$prog_paz_neo %in% common_ids, ]

redcap_common <- redcap_common %>%
  mutate(across(everything(), as.character))

redcapData <- redcapData %>%
  mutate(across(everything(), as.character))


# funzione: Se stesso prog_paz_neo:guarda la cella in REDCap <- se è vuota (NA o “”) e in SDO c’è un valore <- prende quel valore da SDO e lo mette in REDCap
# NON tocca le celle già compilate in REDCap - lavora solo sui “buchi” - riga per riga (stesso paziente)


redcap_common <- fill_from_sdo(redcap_common, sdo_common)

# rimetti dentro
redcapData[redcapData$prog_paz_neo %in% common_ids, ] <- redcap_common

removeSDO <- which(sdoData$prog_paz_neo %in% redcapData$prog_paz_neo)

sdoRemovedData <- sdoData[sdoData$prog_paz_neo %in% redcapData$prog_paz_neo, ]
sdoMergeData   <- sdoData[!sdoData$prog_paz_neo %in% redcapData$prog_paz_neo, ]


# STANDARDIZZAZIONE STRUTTURA DATI ----


redcapData <- standardize_types(redcapData, vars_numeric)
sdoMergeData <- standardize_types(sdoMergeData, vars_numeric)


# TRANSCODIFICA SDO E REDCAP ----


sdoMergeData <- transcode_complete(sdoMergeData, eurocat_vars_list)
redcapData   <- transcode_complete(redcapData, eurocat_vars_list)

# HARMONIZE DATASET ----


# -------- DATE CLEANING --------

# Applico a ENTRAMBI funzione
for (v in date_vars) {
  redcapData[[v]]    <- clean_date(redcapData[[v]])
  sdoMergeData[[v]]  <- clean_date(sdoMergeData[[v]])
}

# -------- DATA SOURCE --------

redcapData$data_source <- "EDC"

sdoMergeData$amniocentesis <- 9
sdoMergeData$chorvilsam    <- 9
sdoMergeData$ultrason      <- 9
sdoMergeData$data_source   <- "SDO"

# -------- SPLIT CAMPI --------

sdoMergeData$gestlength <- str_split_i(sdoMergeData$gestlength, "\\|", 1)
sdoMergeData$weight     <- str_split_i(sdoMergeData$weight, "\\|", 1)

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


write_csv2(eurocatData, file = paste0(exportDir, "/eurocatData.csv"))

