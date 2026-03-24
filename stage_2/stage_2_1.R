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

cedapDataLinked <- data.frame(matrix(NA, nrow = dim(redcapData)[1], ncol = dim(cedapData)[2]))
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

redcapData$weight <- cedapDataLinked$PESO
redcapData$bmi <- round(cedapDataLinked$PESO_MADRE_PREGRAVIDICO/(cedapDataLinked$ALTEZZA_MADRE/100)^2,2)
redcapData$totpreg <- (cedapDataLinked$NUMERO_ABORTI_SPONTANEI +
                          cedapDataLinked$NUMERO_IVG +
                          cedapDataLinked$NUMERO_NATI_VIVI +
                          cedapDataLinked$NUMERO_NATI_MORTI)

redcapData$amniocentesis <- cedapDataLinked$AMNIOCENTESI

redcapData$chorvilsam <- cedapDataLinked$VILLOCENTESI

redcapData$ultrason <- cedapDataLinked$ECOGRAFIA_OLTRE22SETTIMANE

redcapData$prog_paz_neo <- cedapDataLinked$prog_paz_neo

redcapData$prog_paz_m <- cedapDataLinked$prog_paz_m

redcapData$cod_pres <- redcapData$centre

redcapData$place <- centriIMERlookup[as.character(redcapData$centre)]

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


redcapData$syndrome.factor <- as.character(redcapData$syndrome)
redcapData$sp_syndrome <- str_split_i(redcapData$syndrome.factor, "\\|", 3)
redcapData$sp_syndrome <- ifelse(!is.na(redcapData$syndrome_desc_detail), 
                                 paste(redcapData$sp_syndrome, redcapData$syndrome_desc_detail), redcapData$sp_syndrome)


# MALFO 1
tmp <- redcapData$malfo1
redcapData$malfo1 <- str_replace(str_split_i(tmp, "\\|", 2), "\\.", "")
redcapData$sp_malfo1 <- str_split_i(tmp, "\\|", 3)
redcapData$sp_malfo1 <- ifelse(!is.na(redcapData$malfo1_desc_detail),
                               paste(redcapData$sp_malfo1, redcapData$malfo1_desc_detail),
                               redcapData$sp_malfo1)

# MALFO 2
tmp <- redcapData$malfo2
redcapData$malfo2 <- str_replace(str_split_i(tmp, "\\|", 2), "\\.", "")
redcapData$sp_malfo2 <- str_split_i(tmp, "\\|", 3)
redcapData$sp_malfo2 <- ifelse(!is.na(redcapData$malfo2_desc_detail),
                               paste(redcapData$sp_malfo2, redcapData$malfo2_desc_detail),
                               redcapData$sp_malfo2)

# MALFO 3
tmp <- redcapData$malfo3
redcapData$malfo3 <- str_replace(str_split_i(tmp, "\\|", 2), "\\.", "")
redcapData$sp_malfo3 <- str_split_i(tmp, "\\|", 3)
redcapData$sp_malfo3 <- ifelse(!is.na(redcapData$malfo3_desc_detail),
                               paste(redcapData$sp_malfo3, redcapData$malfo3_desc_detail),
                               redcapData$sp_malfo3)

# MALFO 4
tmp <- redcapData$malfo4
redcapData$malfo4 <- str_replace(str_split_i(tmp, "\\|", 2), "\\.", "")
redcapData$sp_malfo4 <- str_split_i(tmp, "\\|", 3)
redcapData$sp_malfo4 <- ifelse(!is.na(redcapData$malfo4_desc_detail),
                               paste(redcapData$sp_malfo4, redcapData$malfo4_desc_detail),
                               redcapData$sp_malfo4)

# MALFO 5
tmp <- redcapData$malfo5
redcapData$malfo5 <- str_replace(str_split_i(tmp, "\\|", 2), "\\.", "")
redcapData$sp_malfo5 <- str_split_i(tmp, "\\|", 3)
redcapData$sp_malfo5 <- ifelse(!is.na(redcapData$malfo5_desc_detail),
                               paste(redcapData$sp_malfo5, redcapData$malfo5_desc_detail),
                               redcapData$sp_malfo5)

# MALFO 6
tmp <- redcapData$malfo6
redcapData$malfo6 <- str_replace(str_split_i(tmp, "\\|", 2), "\\.", "")
redcapData$sp_malfo6 <- str_split_i(tmp, "\\|", 3)
redcapData$sp_malfo6 <- ifelse(!is.na(redcapData$malfo6_desc_detail),
                               paste(redcapData$sp_malfo6, redcapData$malfo6_desc_detail),
                               redcapData$sp_malfo6)

# MALFO 7
tmp <- redcapData$malfo7
redcapData$malfo7 <- str_replace(str_split_i(tmp, "\\|", 2), "\\.", "")
redcapData$sp_malfo7 <- str_split_i(tmp, "\\|", 3)
redcapData$sp_malfo7 <- ifelse(!is.na(redcapData$malfo7_desc_detail),
                               paste(redcapData$sp_malfo7, redcapData$malfo7_desc_detail),
                               redcapData$sp_malfo7)

# MALFO 8
tmp <- redcapData$malfo8
redcapData$malfo8 <- str_replace(str_split_i(tmp, "\\|", 2), "\\.", "")
redcapData$sp_malfo8 <- str_split_i(tmp, "\\|", 3)
redcapData$sp_malfo8 <- ifelse(!is.na(redcapData$malfo8_desc_detail),
                               paste(redcapData$sp_malfo8, redcapData$malfo8_desc_detail),
                               redcapData$sp_malfo8)

redcapData$illbef1 <- ifelse(!is.na(redcapData$icd10illbef1), redcapData$icd10illbef1, redcapData$illbef1)

redcapData$illbef2 <- ifelse(!is.na(redcapData$icd10illbef2), redcapData$icd10illbef2, redcapData$illbef2)

redcapData$illdur1 <- ifelse(!is.na(redcapData$icd10illdur1), redcapData$icd10illdur1, redcapData$illdur1)

redcapData$illdur2 <- ifelse(!is.na(redcapData$icd10illdur2), redcapData$icd10illdur2, redcapData$illdur2)


# OUTPUT ----

redcapData$data_source <- "EDC"
eurocatData <- redcapData[, eurocat_vars_list]

write_csv2(eurocatData, file = paste0(exportDir, "/redcapData_stage_2_1.csv"))
