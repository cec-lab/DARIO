#Clear existing data and graphics
rm(list=ls())
graphics.off()

# SOURCE CONFIGURATION FILE ----

source("/home/imer/works/DARIO/config.R")

# SET WORKING DIRECTORY ----

setwd(baseDir)

# DATA LOAD ----

redcapData <- read_csv2(paste0(exportDir, "/redcapData_stage_3_1.csv"))

# FILL MISSING DATA ----

redcapData$weight[is.na(redcapData$weight)] <- 9999
redcapData$gestlength[is.na(redcapData$gestlength)] <- 99
redcapData$datemo[is.na(redcapData$datemo)] <- "xxxx-xx-xx" # SISTEMARE: AL TIPO DATA NON SI PUO ASSEGNARE UNA STRINGA NEL FORMATO NON STANDARD 
redcapData$nbrbaby[is.na(redcapData$nbrbaby)] <- 9
redcapData$sex[is.na(redcapData$sex)] <- 9
redcapData$type[is.na(redcapData$type)] <- 9
redcapData$survival[is.na(redcapData$survival)] <- 9
redcapData$totpreg[is.na(redcapData$totpreg)] <- 99
redcapData$whendisc[is.na(redcapData$whendisc)] <- 9
redcapData$agedisc[is.na(redcapData$agedisc)] <- 99
redcapData$condisc[is.na(redcapData$condisc)] <- 9
redcapData$karyo[is.na(redcapData$karyo)] <- 9
redcapData$surgery[is.na(redcapData$surgery)] <- 9
redcapData$pm[is.na(redcapData$pm)] <- 9
redcapData$presyn[is.na(redcapData$presyn)] <- 9
redcapData$matdiab[is.na(redcapData$matdiab)] <- 9
redcapData$sp_drugs[is.na(redcapData$sp_drugs)] <- ""
redcapData$sp_drugs_2[is.na(redcapData$sp_drugs_2)] <- ""
redcapData$sp_drugs_3[is.na(redcapData$sp_drugs_3)] <- ""
redcapData$sp_drugs_4[is.na(redcapData$sp_drugs_4)] <- ""
redcapData$sp_drugs_5[is.na(redcapData$sp_drugs_5)] <- ""
redcapData$syndrome[is.na(redcapData$syndrome)] <- ""
redcapData$premal1[is.na(redcapData$premal1)] <- 9
redcapData$premal2[is.na(redcapData$premal2)] <- 9    
redcapData$premal3[is.na(redcapData$premal3)] <- 9    
redcapData$premal4[is.na(redcapData$premal4)] <- 9    
redcapData$premal5[is.na(redcapData$premal5)] <- 9    
redcapData$premal6[is.na(redcapData$premal6)] <- 9    
redcapData$premal7[is.na(redcapData$premal7)] <- 9    
redcapData$premal8[is.na(redcapData$premal8)] <- 9    
redcapData$socf[is.na(redcapData$socf)] <- 9    
redcapData$illbef1[is.na(redcapData$illbef1)] <- 9    
redcapData$illbef2[is.na(redcapData$illbef2)] <- 9
redcapData$illdur1[is.na(redcapData$illdur1)] <- 9
redcapData$illdur2[is.na(redcapData$illdur2)] <- 9    
redcapData$sp_gentest[is.na(redcapData$sp_gentest)] <- ""    
redcapData$omim[is.na(redcapData$omim)] <- 9    
redcapData$orpha[is.na(redcapData$orpha)] <- 9
redcapData$extra_er_resmo[is.na(redcapData$extra_er_resmo)] <- 9    
redcapData$occupmo[is.na(redcapData$occupmo)] <- 9999    
redcapData$folic_g14[is.na(redcapData$folic_g14)] <- 9    
redcapData$extra_drugs[is.na(redcapData$extra_drugs)] <- ""    
redcapData$firsttri[is.na(redcapData$firsttri)] <- 9        
redcapData$assconcept[is.na(redcapData$assconcept)] <- 9    
redcapData$agefa[is.na(redcapData$agefa)] <- 99    
redcapData$agemo[is.na(redcapData$agemo)] <- 99    
redcapData$firstpre[is.na(redcapData$firstpre)] <- 99 
redcapData$sp_firstpre[is.na(redcapData$sp_firstpre)] <- ""
redcapData$migrant[is.na(redcapData$migrant)] <- 9 
redcapData$sp_syndrome[is.na(redcapData$sp_syndrome)] <- "" 
redcapData$drugs1[is.na(redcapData$drugs1)] <- "" 
redcapData$drugs2[is.na(redcapData$drugs2)] <- ""
redcapData$drugs3[is.na(redcapData$drugs3)] <- ""
redcapData$drugs4[is.na(redcapData$drugs4)] <- ""
redcapData$drugs5[is.na(redcapData$drugs5)] <- ""
redcapData$inf_cov_test[is.na(redcapData$inf_cov_test)] <- 9
redcapData$imm_cov_test[is.na(redcapData$imm_cov_test)] <- 9
redcapData$oth_cov_test[is.na(redcapData$oth_cov_test)] <- 9    
redcapData$nbrmalf[is.na(redcapData$nbrmalf)] <- 9
redcapData$death_date[is.na(redcapData$death_date)] <- 222222
redcapData$mocitizenship[is.na(redcapData$mocitizenship)] <- 999
redcapData$sp_karyo[is.na(redcapData$sp_karyo)] <- ""
redcapData$bmi[is.na(redcapData$bmi)] <- 99    
redcapData$mo_smoking[is.na(redcapData$mo_smoking)] <- 99
redcapData$mo_alcohol[is.na(redcapData$mo_alcohol)] <- 99


# OUT ----

write_csv2(redcapData, file = paste0(exportDir, "/redcapData_stage_4_1.csv"))
