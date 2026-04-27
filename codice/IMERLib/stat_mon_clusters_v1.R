# CASES EXTRACTION FROM IMER DATASET
# 2023 June 22
# Marco Manfrini Ph.D.
# University of Ferrara - Dept Moedical Sciences
# Center for Clinical and Epidemiological Research
# IMER Registry - Emilia Romagna Registry of Birth Defects

# PACKAGES ----

#library(data.table)
#library(epiR)
#library(tableone)
#library(rms)
#library(readxl)

library(dplyr)

library(ggplot2)

source("/Users/mmanfrini/Analisi/template/codice/funbox.v2.R")

# FUNCTIONS ----

findICDCases<-function(codes, data){
  selected<- NULL
  for(c in 1:dim(data)[2]){
    for(code in codes){
      selected<-c(selected, grep(paste0("^",code), data[,c]))
    }
  }
  return(selected)
}

birthByMonth<-function(){}

birthByYear<-function(dset){
  dset %>% group_by(Anno) %>%
    summarize(Anno, count)
}

# GLOBAL VARS DATA STRUCTURES ----



# SET WORKING DIR ----

wd="/Users/mmanfrini/Library/CloudStorage/GoogleDrive-mnfmrc@unife.it/Drive condivisi/IMER/Eurocat/Statistical.Monitoring.Investigations/2023"

setwd(wd)
indir=paste0(wd, "/preprocess")
outdir=paste0(wd, "/out")


# DATA IMPORT ----

localNumber.hrhs<-read.csv(paste0(wd, "/hypoplastic.right.heart.csv"), sep=";")

localNumber.ura<-read.csv(paste0(wd, "/unilateral.renal.agenesis.csv"), sep=";")

localNumber.la<-read.csv(paste0(wd, "/laterality.anomalies.csv"), sep=";")

Imer1978.2021 <- read.csv("~/Library/CloudStorage/GoogleDrive-mnfmrc@unife.it/Drive condivisi/IMER/database/Imer1978-2021.csv", sep=";")
Imer2017.2021 <- Imer1978.2021 %>%
  filter(Anno>2016)

rm(Imer1978.2021)

# ADD NUMLOC TO IMER DATASET

Imer2017.2021$numloc<-paste0(Imer2017.2021$Numero, substring(Imer2017.2021$Anno,nchar(Imer2017.2021$Anno)-2+1))

# EXTRACT CASES BY NUMLOC

dset.hrhs<-filter(Imer2017.2021, numloc %in% localNumber.hrhs$Local.number)

dset.ura<-filter(Imer2017.2021, numloc %in% localNumber.ura$Local.number)

dset.la<-filter(Imer2017.2021, numloc %in% localNumber.la$Local.number)

# PLOT HRHS HRHS----

df<-dset.hrhs %>% group_by(Anno) %>% count


# Basic barplot
p<-ggplot(data=df, aes(x=Anno, y=n)) +
  geom_bar(stat="identity", width=0.2, fill="steelblue", color="steelblue") +
  scale_x_continuous(breaks = df$Anno) +
  scale_y_continuous(breaks = c(1,2,3,4,5,6,7,8,9)) +
  theme_light() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size = 10),
        panel.grid.minor = element_blank())+
  xlab("Anno") +
  ylab("Casi (N)")
p


# PLOT HRHS URA ----

df<-dset.ura %>% group_by(Anno) %>% count


# Basic barplot
p<-ggplot(data=df, aes(x=Anno, y=n)) +
  geom_bar(stat="identity", width=0.2, fill="steelblue", color="steelblue") +
  scale_x_continuous(breaks = df$Anno) +
  scale_y_continuous(breaks = c(1,2,3,4,5,6,7,8,9)) +
  theme_light() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size = 10),
        panel.grid.minor = element_blank())+
  xlab("Anno") +
  ylab("Casi (N)")
p


# PLOT HRHS LA ----

df<-dset.la %>% group_by(Anno) %>% count


# Basic barplot
p<-ggplot(data=df, aes(x=Anno, y=n)) +
  geom_bar(stat="identity", width=0.2, fill="steelblue", color="steelblue") +
  scale_x_continuous(breaks = df$Anno) +
  scale_y_continuous(breaks = c(1,2,3,4,5,6,7,8,9)) +
  theme_light() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1, size = 10),
        panel.grid.minor = element_blank())+
  xlab("Anno") +
  ylab("Casi (N)")
p


# TABELLA CHIAVE IMER DIAGNOSI PRENATALE HRHS ----
dset.descr<-dset.hrhs[,c(
  "ChiaveIMER",
  "DiagnosiPrenatale",
  "TipoDiNascita",
  "Sesso"
)]

sel<-which(dset.descr$ChiaveIMER=="H")
dset.descr[sel, "ChiaveIMER"]<-"I"

fact<-colnames(dset.descr)[c(1, 2, 3, 4)]

# Comparison chiave imer
tab<-CreateTableOne(vars = colnames(dset.descr),
                    factorVars = fact,
                    data = dset.descr,
                    strata = colnames(dset.descr)[1],
                    test = TRUE,
                    includeNA = FALSE)
tabMat <- print(tab, quote = FALSE, noSpaces = TRUE, printToggle = TRUE) #exact = fact
write.csv2(tabMat, file=paste0(outdir,"/descriptive.chiave.imer.diag.pren.hrhs.csv"))

# Overall
tab<-CreateTableOne(vars = colnames(dset.descr),
                    factorVars = fact,
                    data = dset.descr,
                    test = FALSE,
                    includeNA = FALSE)
tabMat <- print(tab, quote = FALSE, noSpaces = TRUE, printToggle = TRUE, exact = fact, nonnormal=nnorm)
write.csv2(tabMat, file=paste0(outdir, "/descriptive.imer.diag.pren.Anno.overall.hrhs.csv"))

# TABELLA CHIAVE IMER DIAGNOSI PRENATALE URA ----
dset.descr<-dset.ura[,c(
  "ChiaveIMER",
  "DiagnosiPrenatale",
  "TipoDiNascita",
  "Sesso"
)]

sel<-which(dset.descr$ChiaveIMER=="H")
dset.descr[sel, "ChiaveIMER"]<-"I"

fact<-colnames(dset.descr)[c(1, 2, 3, 4)]

# Comparison chiave imer
tab<-CreateTableOne(vars = colnames(dset.descr),
                    factorVars = fact,
                    data = dset.descr,
                    strata = colnames(dset.descr)[1],
                    test = TRUE,
                    includeNA = FALSE)
tabMat <- print(tab, quote = FALSE, noSpaces = TRUE, printToggle = TRUE) #exact = fact
write.csv2(tabMat, file=paste0(outdir,"/descriptive.chiave.imer.diag.pren.ura.csv"))

# Overall
tab<-CreateTableOne(vars = colnames(dset.descr),
                    factorVars = fact,
                    data = dset.descr,
                    test = FALSE,
                    includeNA = FALSE)
tabMat <- print(tab, quote = FALSE, noSpaces = TRUE, printToggle = TRUE, exact = fact, nonnormal=nnorm)
write.csv2(tabMat, file=paste0(outdir, "/descriptive.imer.diag.pren.Anno.overall.ura.csv"))

# TABELLA CHIAVE IMER DIAGNOSI PRENATALE LA ----
dset.descr<-dset.la[,c(
  "ChiaveIMER",
  "DiagnosiPrenatale",
  "TipoDiNascita",
  "Sesso"
)]

sel<-which(dset.descr$ChiaveIMER=="H")
dset.descr[sel, "ChiaveIMER"]<-"I"

fact<-colnames(dset.descr)[c(1, 2, 3, 4)]

# Comparison chiave imer
tab<-CreateTableOne(vars = colnames(dset.descr),
                    factorVars = fact,
                    data = dset.descr,
                    strata = colnames(dset.descr)[1],
                    test = TRUE,
                    includeNA = FALSE)
tabMat <- print(tab, quote = FALSE, noSpaces = TRUE, printToggle = TRUE) #exact = fact
write.csv2(tabMat, file=paste0(outdir,"/descriptive.chiave.imer.diag.pren.la.csv"))

# Overall
tab<-CreateTableOne(vars = colnames(dset.descr),
                    factorVars = fact,
                    data = dset.descr,
                    test = FALSE,
                    includeNA = FALSE)
tabMat <- print(tab, quote = FALSE, noSpaces = TRUE, printToggle = TRUE, exact = fact, nonnormal=nnorm)
write.csv2(tabMat, file=paste0(outdir, "/descriptive.imer.diag.pren.Anno.overall.la.csv"))

# TABELLA ESPOSIZIONE HRHS  ----
dset.descr<-dset.hrhs[,c(
  "Anno",
  "Centro",
  "CodiceComune",
  "ILOmadre",
  "AlcoolMadre",
  "FumoMadre",
  "AlcoolInGravidanza",
  "FumoInGravidanza",
  "DrogheMadre",
  "RadiazioniMadre",
  "PesoNeonato",
  "LunghezzaNeonato",
  "CirconferenzaCranica",
  "CirconferenzaToracica",
  "EtaMadre"
)]


fact<-colnames(dset.descr)[c(1:10, 15)]

# Comparison chiave imer
tab<-CreateTableOne(vars = colnames(dset.descr),
                    factorVars = fact,
                    data = dset.descr,
                    strata = colnames(dset.descr)[1],
                    test = TRUE,
                    includeNA = FALSE)
tabMat <- print(tab, quote = FALSE, noSpaces = TRUE, printToggle = TRUE) #exact = fact
write.csv2(tabMat, file=paste0(outdir,"/descriptive.esposizione.hrhs.csv"))

# Overall
tab<-CreateTableOne(vars = colnames(dset.descr),
                    factorVars = fact,
                    data = dset.descr,
                    test = FALSE,
                    includeNA = FALSE)
tabMat <- print(tab, quote = FALSE, noSpaces = TRUE, printToggle = TRUE, exact = fact)
write.csv2(tabMat, file=paste0(outdir, "/descriptive.esposizionel.hrhs.csv"))

# TABELLA ESPOSIZIONE URA  ----
dset.descr<-dset.ura[,c(
  "Anno",
  "Centro",
  "CodiceComune",
  "ILOmadre",
  "AlcoolMadre",
  "FumoMadre",
  "AlcoolInGravidanza",
  "FumoInGravidanza",
  "DrogheMadre",
  "RadiazioniMadre",
  "PesoNeonato",
  "LunghezzaNeonato",
  "CirconferenzaCranica",
  "CirconferenzaToracica",
  "EtaMadre"
)]


fact<-colnames(dset.descr)[c(1:10, 15)]

# Comparison chiave imer
tab<-CreateTableOne(vars = colnames(dset.descr),
                    factorVars = fact,
                    data = dset.descr,
                    strata = colnames(dset.descr)[1],
                    test = TRUE,
                    includeNA = FALSE)
tabMat <- print(tab, quote = FALSE, noSpaces = TRUE, printToggle = TRUE) #exact = fact
write.csv2(tabMat, file=paste0(outdir,"/descriptive.esposizione.ura.csv"))

# Overall
tab<-CreateTableOne(vars = colnames(dset.descr),
                    factorVars = fact,
                    data = dset.descr,
                    test = FALSE,
                    includeNA = FALSE)
tabMat <- print(tab, quote = FALSE, noSpaces = TRUE, printToggle = TRUE, exact = fact)
write.csv2(tabMat, file=paste0(outdir, "/descriptive.esposizionel.ura.csv"))

# TABELLA ESPOSIZIONE LA  ----
dset.descr<-dset.la[,c(
  "Anno",
  "Centro",
  "CodiceComune",
  "ILOmadre",
  "AlcoolMadre",
  "FumoMadre",
  "AlcoolInGravidanza",
  "FumoInGravidanza",
  "DrogheMadre",
  "RadiazioniMadre",
  "PesoNeonato",
  "LunghezzaNeonato",
  "CirconferenzaCranica",
  "CirconferenzaToracica",
  "EtaMadre"
)]

fact<-colnames(dset.descr)[c(1:10, 15)]

# Comparison chiave imer
tab<-CreateTableOne(vars = colnames(dset.descr),
                    factorVars = fact,
                    data = dset.descr,
                    strata = colnames(dset.descr)[1],
                    test = TRUE,
                    includeNA = FALSE)
tabMat <- print(tab, quote = FALSE, noSpaces = TRUE, printToggle = TRUE) #exact = fact
write.csv2(tabMat, file=paste0(outdir,"/descriptive.esposizione.la.csv"))

# Overall
tab<-CreateTableOne(vars = colnames(dset.descr),
                    factorVars = fact,
                    data = dset.descr,
                    test = FALSE,
                    includeNA = FALSE)
tabMat <- print(tab, quote = FALSE, noSpaces = TRUE, printToggle = TRUE, exact = fact)
write.csv2(tabMat, file=paste0(outdir, "/descriptive.esposizionel.la.csv"))

# COUNTS ICD10 ----

dc<-data.frame(ICD10=unlist(dset.hrhs[193:200]))
dc.counts.hrhs<-dc %>% group_by(ICD10) %>% count

dc<-data.frame(ICD10=unlist(dset.ura[193:200]))
dc.counts.ura<-dc %>% group_by(ICD10) %>% count

dc<-data.frame(ICD10=unlist(dset.la[193:200]))
dc.counts.la<-dc %>% group_by(ICD10) %>% count

# OUTPUT FILES ----

write.csv2(dc.counts.hrhs, file = paste0(outdir, "/counts.hrhs.csv"), row.names = F)
write.csv2(dc.counts.ura, file = paste0(outdir, "/counts.ura.csv"), row.names = F)
write.csv2(dc.counts.la, file = paste0(outdir, "/counts.la.csv"), row.names = F)
write.csv2(dset.hrhs, file = paste0(outdir, "/hrhs.cases.csv"), row.names = F)
write.csv2(dset.ura, file = paste0(outdir, "/ura.cases.csv"), row.names = F)
write.csv2(dset.la, file = paste0(outdir, "/la.cases.csv"), row.names = F)

# SESSION ----

sessionInfo()
