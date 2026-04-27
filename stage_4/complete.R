#Clear existing data and graphics
if(!exists("redcapData")){
  rm(list=ls())
  graphics.off()
}

# SOURCE CONFIGURATION FILE ----

baseDir=getwd()
source(paste0(baseDir,"/config.R"), echo = T)
source(paste0(baseDir,"/functions.R"), echo = T)

# SET WORKING DIRECTORY ----

setwd(baseDir)

# DATA LOAD ----

redcapData <- read_csv2(paste0(exportDir, "/redcapData_stage_3_1.csv"))

# FILL MISSING DATA ----

redcapData$weight[is.na(redcapData$weight)] <- 9999
redcapData$gestlength[is.na(redcapData$gestlength)] <- 99

# DATE (formato EUROCAT yyyy/mm/xx)
redcapData$birth_date <- as.character(redcapData$birth_date)
redcapData$datemo <- as.character(redcapData$datemo)
redcapData$death_date <- as.character(redcapData$death_date)


#MALFO
redcapData$malfo1[is.na(redcapData$malfo1)] <- ""
redcapData$malfo2[is.na(redcapData$malfo2)] <- ""
redcapData$malfo3[is.na(redcapData$malfo3)] <- ""
redcapData$malfo4[is.na(redcapData$malfo4)] <- ""
redcapData$malfo5[is.na(redcapData$malfo5)] <- ""
redcapData$malfo6[is.na(redcapData$malfo6)] <- ""
redcapData$malfo7[is.na(redcapData$malfo7)] <- ""
redcapData$malfo8[is.na(redcapData$malfo8)] <- ""

redcapData$nbrbaby[is.na(redcapData$nbrbaby)] <- 9
redcapData$sex[is.na(redcapData$sex)] <- 9
redcapData$type[is.na(redcapData$type)] <- 9
redcapData$survival[is.na(redcapData$survival)] <- 9
redcapData$totpreg <- dplyr::case_when(
  is.na(redcapData$totpreg) ~ "99",
  redcapData$totpreg == 0 ~ "00",
  redcapData$totpreg == 1 ~ "01",
  redcapData$totpreg == 2 ~ "02",
  redcapData$totpreg >= 3 ~ "03"
)
redcapData$whendisc[is.na(redcapData$whendisc)] <- 9
redcapData$agedisc[is.na(redcapData$agedisc)] <- 99
redcapData$condisc[is.na(redcapData$condisc)] <- 9
redcapData$karyo[is.na(redcapData$karyo)] <- 9
redcapData$surgery[is.na(redcapData$surgery)] <- 9
redcapData$pm[is.na(redcapData$pm)] <- 9
redcapData$presyn[is.na(redcapData$presyn)] <- 9
redcapData$matdiab[is.na(redcapData$matdiab)] <- 9

# TESTO
# SP_* → STRINGA VUOTA ""


sp_vars <- names(redcapData)[grepl("^sp_", names(redcapData))]

for(v in sp_vars){
  redcapData[[v]][is.na(redcapData[[v]])] <- ""
}


# PRENATAL MALFORMATIONS
redcapData$premal1[is.na(redcapData$premal1)] <- 9
redcapData$premal2[is.na(redcapData$premal2)] <- 9    
redcapData$premal3[is.na(redcapData$premal3)] <- 9    
redcapData$premal4[is.na(redcapData$premal4)] <- 9    
redcapData$premal5[is.na(redcapData$premal5)] <- 9    
redcapData$premal6[is.na(redcapData$premal6)] <- 9    
redcapData$premal7[is.na(redcapData$premal7)] <- 9    
redcapData$premal8[is.na(redcapData$premal8)] <- 9    

redcapData$socf[is.na(redcapData$socf)] <- 9    

# ICD (codice ICD → testo → "")
redcapData$illbef1[is.na(redcapData$illbef1)] <- ""    
redcapData$illbef2[is.na(redcapData$illbef2)] <- ""
redcapData$illdur1[is.na(redcapData$illdur1)] <- ""
redcapData$illdur2[is.na(redcapData$illdur2)] <- ""    

redcapData$sp_gentest[is.na(redcapData$sp_gentest)] <- ""    

# OMIM / ORPHA (codici → testo)
redcapData$omim[is.na(redcapData$omim)] <- ""    
redcapData$orpha[is.na(redcapData$orpha)] <- ""

redcapData$extra_er_resmo[is.na(redcapData$extra_er_resmo)] <- 9    
redcapData$occupmo[is.na(redcapData$occupmo)] <- 9999    
redcapData$folic_g14[is.na(redcapData$folic_g14)] <- 9    
redcapData$extra_drugs[is.na(redcapData$extra_drugs)] <- ""    
redcapData$firsttri[is.na(redcapData$firsttri)] <- 9        
redcapData$assconcept[is.na(redcapData$assconcept)] <- 9    
redcapData$agefa[is.na(redcapData$agefa)] <- 99    
redcapData$agemo[is.na(redcapData$agemo)] <- 99    

redcapData$firstpre[is.na(redcapData$firstpre)] <- 9

redcapData$migrant[is.na(redcapData$migrant)] <- 9 

# DRUGS
redcapData$drugs1[is.na(redcapData$drugs1)] <- "" 
redcapData$drugs2[is.na(redcapData$drugs2)] <- ""
redcapData$drugs3[is.na(redcapData$drugs3)] <- ""
redcapData$drugs4[is.na(redcapData$drugs4)] <- ""
redcapData$drugs5[is.na(redcapData$drugs5)] <- ""

# COVID
redcapData$inf_cov_test[is.na(redcapData$inf_cov_test)] <- 9
redcapData$imm_cov_test[is.na(redcapData$imm_cov_test)] <- 9
redcapData$oth_cov_test[is.na(redcapData$oth_cov_test)] <- 9    

redcapData$nbrmalf[is.na(redcapData$nbrmalf)] <- 9

# CODICI
redcapData$mocitizenship[is.na(redcapData$mocitizenship)] <- 999
redcapData$sp_karyo[is.na(redcapData$sp_karyo)] <- ""

# CONTINUE
redcapData$bmi[is.na(redcapData$bmi)] <- 99    
redcapData$mo_smoking[is.na(redcapData$mo_smoking)] <- 99
redcapData$mo_alcohol[is.na(redcapData$mo_alcohol)] <- 99


# TESTO / ID
redcapData$sdo_number[is.na(redcapData$sdo_number)] <- ""
redcapData$resmo[is.na(redcapData$resmo)] <- ""
redcapData$imer_key[is.na(redcapData$imer_key)] <- ""
redcapData$prog_paz_neo[is.na(redcapData$prog_paz_neo)] <- ""

# NOTE
redcapData$pm_notes[is.na(redcapData$pm_notes)] <- ""
redcapData$genrem[is.na(redcapData$genrem)] <- ""

# SYNDROME
redcapData$syndrome[is.na(redcapData$syndrome)] <- ""

# SIBLING ID
redcapData$sib1[is.na(redcapData$sib1)] <- ""
redcapData$sib2[is.na(redcapData$sib2)] <- ""
redcapData$sib3[is.na(redcapData$sib3)] <- ""

# CODICI (1 cifra → 9)
redcapData$cov_severity[is.na(redcapData$cov_severity)] <- 9
redcapData$consang[is.na(redcapData$consang)] <- 9
redcapData$sibanom[is.na(redcapData$sibanom)] <- 9
redcapData$moanom[is.na(redcapData$moanom)] <- 9
redcapData$faanom[is.na(redcapData$faanom)] <- 9
redcapData$matedu[is.na(redcapData$matedu)] <- 9
redcapData$socm[is.na(redcapData$socm)] <- 9
redcapData$amniocentesis[is.na(redcapData$amniocentesis)] <- 9
redcapData$chorvilsam[is.na(redcapData$chorvilsam)] <- 9
redcapData$ultrason[is.na(redcapData$ultrason)] <- 9
redcapData$pre_sa[is.na(redcapData$pre_sa)] <- 9
redcapData$pre_topfa[is.na(redcapData$pre_topfa)] <- 9
redcapData$pre_live[is.na(redcapData$pre_live)] <- 9
redcapData$pre_still[is.na(redcapData$pre_still)] <- 9

# NUMERICI (2 cifre → 99)
redcapData$start_cov[is.na(redcapData$start_cov)] <- 99



# OUT ----

write_csv2(redcapData, file = paste0(exportDir, "/redcapData_stage_4_1.csv"), na="")
