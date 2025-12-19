# Version 0.0.1

#Clear existing data and graphics
rm(list=ls())
graphics.off()

# SOURCE CONFIGURATION FILE ----

source("/home/imer/works/DARIO/config.R")

# SET WORKING DIRECTORY ----

setwd(baseDir)

# SOURCE CUSTOM FUNCTIONS FILE ----

# LOG FILE OPEN ----

# sink(con, append=TRUE)
# sink(con, append=TRUE, type="message")

# PREPROCESS EDC DATASET ----

print("Preprocessing EDC data..")
print("Preprocess EDC START")
source(paste0(redcapDir, "/preprocess_edc.R"), echo = T)
print("Preprocess EDC END")
print("Preprocessing EDC data finshed.")


# DATA IMPORT ----

print("Starting data import..")
print("STAGE 0 START")
source(paste0(stage0Dir, "/stage_0_1.R"), echo = T)
source(paste0(stage0Dir, "/stage_0_2.R"), echo = T)
print("STAGE 0 END")
print("Data import finshed.")


# LINKAGE CEDAP ----

print("Linkage CedAP")
print("STAGE 1 START")
source(paste0(stage1Dir, "/stage_1_1.R"), echo = T)
print("STAGE 1 END")

# TRANSCODE ----

print("Linkage CedAP")
print("STAGE 2 START")
source(paste0(stage2Dir, "/stage_2_1.R"), echo = T)
print("STAGE 2 END")

# SURGERY ----

print("Surgery")
print("STAGE 3 START")
source(paste0(stage3Dir, "/surgery.R"), echo = T)
print("STAGE 3 END")

# COMPLETE ----

print("Complete dataset")
print("STAGE 4 START")
source(paste0(stage4Dir, "/complete.R"), echo = T)
print("STAGE 4 END")

# MERGE ----

print("Merge EDC SDO")
print("STAGE 5 START")
source(paste0(stage5Dir, "/merge.R"), echo = T)
print("STAGE 5 END")

# LOG FILE CLOSE ----

# sink()
# sink(type="message")








