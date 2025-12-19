#Clear existing data and graphics
rm(list=ls())
graphics.off()

# SOURCE CONFIGURATION FILE ----

source("/home/imer/works/DARIO/config.R")

# SET WORKING DIRECTORY ----

setwd(baseDir)

# DATA LOAD ----

redcapData_stege_1_1_revised <- read_csv2(paste0(exportDir, "/redcapData_stage_1_1.csv"))
View(redcapData_stege_1_1_revised)

redcapData <- redcapData_stege_1_1_revised[, stage_2_vars_list]
rm(redcapData_stege_1_1_revised)

# IMPORT CEDAP DATA ----

cedap_linked_vars <- c(
  "PROG_PAZ",
  "COD_STAB",
  "AMNIOCEN",
  "VILLICOR",
  "ECOGRAF",
  "PESO",
  "CFR_CRAN",
  "PESO_M",
  "ALTEZZA_M",
  "aborti",
  "ivg",         
  "nativivi",
  "natimor",
  "METODO",
  "TABACCO"
)

cedapData <- read_csv2(paste0(cedapDir, "/", cedapFileName), locale = locale(encoding = "WINDOWS-1252"))
cedapData <- cedapData[, cedap_linked_vars]

cedapDataLinked <- data.frame(matrix(NA, nrow = dim(redcapData)[1], ncol = dim(cedapData)[2]))
colnames(cedapDataLinked) <- cedap_linked_vars

for(i in 1:dim(redcapData)[1]){
  link_number <- pull(redcapData[i, "cedap_linked"])
  row <- cedapData[link_number,]
  if(dim(row)[1]>0){
    cedapDataLinked[i,] <- row  
  }
}

# TRANSCODE ----

cedapDataLinked$aborti <- ifelse(cedapDataLinked$aborti == "-", NA, cedapDataLinked$aborti)
cedapDataLinked$ivg <- ifelse(cedapDataLinked$ivg == "-", NA, cedapDataLinked$ivg)
cedapDataLinked$nativivi <- ifelse(cedapDataLinked$nativivi == "-", NA, cedapDataLinked$nativivi)
cedapDataLinked$natimor <- ifelse(cedapDataLinked$natimor == "-", NA, cedapDataLinked$natimor)

redcapData$weight <- cedapDataLinked$PESO
redcapData$bmi <- round(cedapDataLinked$PESO_M/(cedapDataLinked$ALTEZZA_M/100)^2,2)
#redcapData$totpreg <- (cedapDataLinked$aborti + cedapDataLinked$ivg + cedapDataLinked$nativivi + cedapDataLinked$natimor)
redcapData$totpreg <- rowSums(
  cbind(
    as.numeric(cedapDataLinked$aborti),
    as.numeric(cedapDataLinked$ivg),
    as.numeric(cedapDataLinked$nativivi),
    as.numeric(cedapDataLinked$natimor)
  ),
  na.rm = TRUE
)

redcapData$amniocentesis <- cedapDataLinked$AMNIOCEN

redcapData$chorvilsam <- cedapDataLinked$VILLICOR # VILLOCENTESI

redcapData$ultrason <- cedapDataLinked$ECOGRAF # ECOGRAFIA_OLTRE22SETTIMANE

redcapData$prog_paz_neo <- cedapDataLinked$PROG_PAZ # prog_paz_neo

redcapData$prog_paz_m <- NA # cedapDataLinked$prog_paz_m

redcapData$cod_pres <- cedapDataLinked$COD_STAB # COD_PRES

redcapData$mo_smoking <- cedapDataLinked$TABACCO # ABITUDINE_AL_FUMO

redcapData$mo_alcohol <- NA

redcapData$pre_sa <- cedapDataLinked$aborti # NUMERO_ABORTI_SPONTANEI

redcapData$pre_topfa <- cedapDataLinked$ivg # NUMERO_IVG

redcapData$pre_live <- cedapDataLinked$nativivi # NUMERO_NATI_VIVI

redcapData$pre_still <- cedapDataLinked$natimor # NUMERO_NATI_MORTI

redcapData$assconcept <- recode(cedapDataLinked$METODO, # metodi_PMA,
                                `1` = "1",
                                `2` = "2",
                                `3` = "4",
                                `4` = "3",
                                `5` = "5",
                                `6` = "10",
                                .default = "9") 


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

redcapData$birth_date <- ymd(redcapData$birth_date)
redcapData$birth_date <- str_replace_all(redcapData$birth_date, "-", "/")
redcapData$data_source <- "EDC"


# HARMONIZE DATASET ----

eurocatData <- redcapData[, eurocat_vars_list]

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

