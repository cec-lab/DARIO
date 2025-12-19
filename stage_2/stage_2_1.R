#Clear existing data and graphics
rm(list=ls())
graphics.off()

# SOURCE CONFIGURATION FILE ----

source("/home/imer/works/DARIO/config.R")

source("/home/imer/works/DARIO/functions.R")

# SET WORKING DIRECTORY ----

setwd(baseDir)

# DATA LOAD ----

redcapData_stege_1_1_revised <- read_csv2(paste0(exportDir, "/redcapData_stege_1_1_revised_b.csv"))
View(redcapData_stege_1_1_revised)

redcapData <- redcapData_stege_1_1_revised[, stage_2_vars_list]
rm(redcapData_stege_1_1_revised)

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

redcapData$cod_pres <- redcapData$birthCenter

redcapData$place <- centriIMERlookup[as.character(redcapData$birthCenter)]

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


redcapData$syndrome <- str_replace(str_split_i(redcapData$syndrome.factor, "\\|", 2), "\\.", "")
redcapData$sp_syndrome <- str_split_i(redcapData$syndrome.factor, "\\|", 3)
redcapData$sp_syndrome <- ifelse(!is.na(redcapData$syndrome_desc_detail), 
                                 paste(redcapData$sp_syndrome, redcapData$syndrome_desc_detail), redcapData$sp_syndrome)

redcapData$malfo1 <- str_replace(str_split_i(redcapData$malfo1.factor, "\\|", 2), "\\.", "")
redcapData$sp_malfo1 <- str_split_i(redcapData$malfo1.factor, "\\|", 3)
redcapData$sp_malfo1 <- ifelse(!is.na(redcapData$malfo1_desc_detail), 
                                 paste(redcapData$sp_malfo1, redcapData$malfo1_desc_detail), redcapData$sp_malfo1)

redcapData$malfo2 <- str_replace(str_split_i(redcapData$malfo2.factor, "\\|", 2), "\\.", "")
redcapData$sp_malfo2 <- str_split_i(redcapData$malfo2.factor, "\\|", 3)
redcapData$sp_malfo2 <- ifelse(!is.na(redcapData$malfo2_desc_detail), 
                               paste(redcapData$sp_malfo2, redcapData$malfo2_desc_detail), redcapData$sp_malfo2)

redcapData$malfo3 <- str_replace(str_split_i(redcapData$malfo3.factor, "\\|", 2), "\\.", "")
redcapData$sp_malfo3 <- str_split_i(redcapData$malfo3.factor, "\\|", 3)
redcapData$sp_malfo3 <- ifelse(!is.na(redcapData$malfo3_desc_detail), 
                               paste(redcapData$sp_malfo3, redcapData$malfo3_desc_detail), redcapData$sp_malfo3)

redcapData$malfo4 <- str_replace(str_split_i(redcapData$malfo4.factor, "\\|", 2), "\\.", "")
redcapData$sp_malfo4 <- str_split_i(redcapData$malfo4.factor, "\\|", 3)
redcapData$sp_malfo4 <- ifelse(!is.na(redcapData$malfo4_desc_detail), 
                               paste(redcapData$sp_malfo4, redcapData$malfo4_desc_detail), redcapData$sp_malfo4)

redcapData$malfo5 <- str_replace(str_split_i(redcapData$malfo5.factor, "\\|", 2), "\\.", "")
redcapData$sp_malfo5 <- str_split_i(redcapData$malfo5.factor, "\\|", 3)
redcapData$sp_malfo5 <- ifelse(!is.na(redcapData$malfo5_desc_detail), 
                               paste(redcapData$sp_malfo5, redcapData$malfo5_desc_detail), redcapData$sp_malfo5)

redcapData$malfo6 <- str_replace(str_split_i(redcapData$malfo6.factor, "\\|", 2), "\\.", "")
redcapData$sp_malfo6 <- str_split_i(redcapData$malfo6.factor, "\\|", 3)
redcapData$sp_malfo6 <- ifelse(!is.na(redcapData$malfo6_desc_detail), 
                               paste(redcapData$sp_malfo6, redcapData$malfo6_desc_detail), redcapData$sp_malfo6)

redcapData$malfo7 <- str_replace(str_split_i(redcapData$malfo7.factor, "\\|", 2), "\\.", "")
redcapData$sp_malfo7 <- str_split_i(redcapData$malfo7.factor, "\\|", 3)
redcapData$sp_malfo7 <- ifelse(!is.na(redcapData$malfo7_desc_detail), 
                               paste(redcapData$sp_malfo7, redcapData$malfo7_desc_detail), redcapData$sp_malfo7)

redcapData$malfo8 <- str_replace(str_split_i(redcapData$malfo8.factor, "\\|", 2), "\\.", "")
redcapData$sp_malfo8 <- str_split_i(redcapData$malfo8.factor, "\\|", 3)
redcapData$sp_malfo8 <- ifelse(!is.na(redcapData$malfo8_desc_detail), 
                               paste(redcapData$sp_malfo8, redcapData$malfo8_desc_detail), redcapData$sp_malfo8)


redcapData$illbef1 <- ifelse(!is.na(redcapData$icd10illbef1), redcapData$icd10illbef1, redcapData$illbef1)

redcapData$illbef2 <- ifelse(!is.na(redcapData$icd10illbef2), redcapData$icd10illbef2, redcapData$illbef2)

redcapData$illdur1 <- ifelse(!is.na(redcapData$icd10illdur1), redcapData$icd10illdur1, redcapData$illdur1)

redcapData$illdur2 <- ifelse(!is.na(redcapData$icd10illdur2), redcapData$icd10illdur2, redcapData$illdur2)


# OUTPUT ----

eurocatData <- redcapData[, eurocat_vars_list]

write_csv2(eurocatData, file = paste0(exportDir, "/redcapData_stage_2_1.csv"))
