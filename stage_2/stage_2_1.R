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

redcapData_stage_1_1_revised <- read_csv2(paste0(exportDir, "/redcapData_stage_1_1_revised.csv"))

redcapData <- redcapData_stage_1_1_revised |> select(any_of(stage_2_vars_list))
rm(redcapData_stage_1_1_revised)

centriImer <- read_csv2(paste0(tablesDir, "/centri_imer.csv"))
centriIMERlookup <- setNames(centriImer$Centro_IMER, centriImer$Codice)


# IMPORT CEDAP DATA ----

cedapData <- read_csv2(paste0(cedapDir, "/", cedapFileName))
cedapData <- cedapData[, cedap_linked_vars]

cedapDataLinked <- data.frame(
  matrix(NA, 
         nrow = nrow(redcapData), 
         ncol = length(cedap_linked_vars))
)

colnames(cedapDataLinked) <- cedap_linked_vars
cedapDataLinked$metodi_PMA <- 0

for(i in 1:dim(redcapData)[1]){
  link_number <- pull(redcapData[i, "cedap_linked"])
  row <- cedapData[link_number,]
  if(dim(row)[1]>0){
    cedapDataLinked[i,] <- row  
  }
}

# TRANSCODE ----

redcapData$socm <- ifelse(
  !is.na(cedapDataLinked$CONDIZIONE_PROF_MADRE) &
    cedapDataLinked$CONDIZIONE_PROF_MADRE %in% c(4,6),
  8, 9
)

redcapData$socf <- ifelse(
  !is.na(cedapDataLinked$CONDIZIONE_PROF_PADRE) &
    cedapDataLinked$CONDIZIONE_PROF_PADRE %in% c(4,6),
  8, 9
)
redcapData$weight <- cedapDataLinked$PESO
redcapData$bmi <- round(cedapDataLinked$PESO_MADRE_PREGRAVIDICO/(cedapDataLinked$ALTEZZA_MADRE/100)^2,2)
redcapData$totpreg <- rowSums(
  cbind(
    cedapDataLinked$NUMERO_ABORTI_SPONTANEI,
    cedapDataLinked$NUMERO_IVG,
    cedapDataLinked$NUMERO_NATI_VIVI,
    cedapDataLinked$NUMERO_NATI_MORTI
  ),
  na.rm = TRUE
)

redcapData$amniocentesis <- cedapDataLinked$AMNIOCENTESI

redcapData$chorvilsam <- cedapDataLinked$VILLOCENTESI

redcapData$ultrason <- cedapDataLinked$ECOGRAFIA_OLTRE22SETTIMANE

redcapData$prog_paz_neo <- cedapDataLinked$prog_paz_neo

redcapData$prog_paz_m <- cedapDataLinked$prog_paz_m

redcapData$cod_pres <- redcapData$birthCenter

redcapData$mo_smoking <- cedapDataLinked$ABITUDINE_AL_FUMO

redcapData$mo_alcohol <- NA

redcapData$pre_sa <- cedapDataLinked$NUMERO_ABORTI_SPONTANEI

redcapData$pre_topfa <- cedapDataLinked$NUMERO_IVG

redcapData$pre_live <- cedapDataLinked$NUMERO_NATI_VIVI

redcapData$pre_still <- cedapDataLinked$NUMERO_NATI_MORTI

redcapData$assconcept <- recode(cedapDataLinked$metodi_PMA,
                                `1` = "1",
                                `2` = "2",
                                `3` = "4",
                                `4` = "3",
                                `5` = "5",
                                `6` = "10",
                                .default = "9",
                                .missing = "9") 


# SYNDROME

#tolgo il puntino
redcapData$syndrome.factor <- gsub(
  "\\.",
  "",
  redcapData$syndrome.factor
)

if("syndrome.factor" %in% names(redcapData)){
  
  res <- parse_pipe(redcapData$syndrome.factor)
  
  redcapData$syndrome <- res$code
  redcapData$sp_syndrome <- res$desc
}


# MALFO
for(i in 1:8){
  
  var_factor <- paste0("malfo", i, ".factor")
  var <- paste0("malfo", i)
  sp_var <- paste0("sp_malfo", i)
  
  detail_var <- paste0("malfo", i, "_desc_detail")
  
  if(var_factor %in% names(redcapData)){
    
    res <- parse_pipe(redcapData[[var_factor]])
    
    redcapData[[var]] <- res$code
    
    # descrizione originale
    desc_original <- res$desc
    
    # testo aggiuntivo
    detail_text <- redcapData[[detail_var]]
    
    detail_text <- trimws(as.character(detail_text))
    detail_text[is.na(detail_text)] <- ""
    
    # concatenazione con solo spazio
    redcapData[[sp_var]] <- ifelse(
      detail_text != "",
      paste(desc_original, detail_text),
      desc_original
    )
  }
}

redcapData$illbef1 <- ifelse(!is.na(redcapData$icd10illbef1), redcapData$icd10illbef1, redcapData$illbef1)

redcapData$illbef2 <- ifelse(!is.na(redcapData$icd10illbef2), redcapData$icd10illbef2, redcapData$illbef2)

redcapData$illdur1 <- ifelse(!is.na(redcapData$icd10illdur1), redcapData$icd10illdur1, redcapData$illdur1)

redcapData$illdur2 <- ifelse(!is.na(redcapData$icd10illdur2), redcapData$icd10illdur2, redcapData$illdur2)


# SYNDROME CONCATENAZIONE
syndrome_detail <- setNames(
  redcapData$syndrome_desc_detail,
  redcapData$record_id
)

detail_text <- syndrome_detail[as.character(redcapData$record_id)]

detail_text <- trimws(as.character(detail_text))
detail_text[is.na(detail_text)] <- ""

redcapData$sp_syndrome <- ifelse(
  detail_text != "",
  paste(redcapData$sp_syndrome, detail_text),
  redcapData$sp_syndrome
)

# OUTPUT ----

redcapData$data_source <- "EDC"
eurocatData <- redcapData[, eurocat_vars_list]

write_csv2(eurocatData, file = paste0(exportDir, "/redcapData_stage_2_1.csv"), na="")
