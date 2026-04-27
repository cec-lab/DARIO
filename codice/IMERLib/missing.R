# PRE-PROCESSING v4

# Functions ---------------------------------------------
source("/Users/mmanfrini/Analisi/template/codice/funbox.v2.R")

# PATH ----

setwd("/Users/mmanfrini/Library/CloudStorage/GoogleDrive-mnfmrc@unife.it/Drive condivisi/IMER/database/missing")
wd<-getwd()
indir=paste0(wd, "/preprocess")
outdir=paste0(wd,"/preprocess")

# GLOBAL VARS ----

RAW=T
DOIMP=T

# DATA IMPORT ----

Imer1978.2021 <- read.csv("~/Library/CloudStorage/GoogleDrive-mnfmrc@unife.it/Drive condivisi/IMER/database/Imer1978-2021.csv", sep=";")

dset <- Imer1978.2021 %>%
  filter(Anno>2008)

rm(Imer1978.2021)

# QC PLOTS RAW ----

vis_dat_wrapper(dset)

pdf(file=paste0(outdir, "/boxplot.pdf"), height = 4, width = 4)
for(i in 1:length(numericList)){
  if(sum(dset[, numericList[i]], na.rm = T)>0){
    boxplot(dset[, numericList[i]], main=colnames(dset)[numericList[i]], cex.main=0.5)
  }
}
dev.off()

pdf(file=paste0(outdir, "/qq.pdf"), height = 4, width = 4)
for(i in 1:length(numericList)){
  if(sum(dset[, numericList[i]], na.rm = T)>0){
    qqnorm(scale(dset[, numericList[i]]), main=colnames(dset)[numericList[i]], cex.main=0.5)
    qqline(scale(dset[, numericList[i]]), col = "steelblue", lwd = 2)
  }
}
dev.off()

pdf(file=paste0(outdir, "/barplot.pdf"), height = 6, width = 4)
for(i in 1:length(factorList)){
  tab<-table(dset[,factorList[i]])
  par(mar=c(10,1,1,1))
  barplot(tab, names.arg = substr(names(tab), start=1, stop=10), las=2, main=colnames(dset)[factorList[i]], cex.main=0.5, cex.names = 0.5)
}
dev.off()

pdf(file=paste0(outdir, "/integers.pdf"), height = 6, width = 4)
for(i in 1:length(integerList)){
  tab<-table(dset[,integerList[i]])
  par(mar=c(10,1,1,1))
  barplot(tab, names.arg = substr(names(tab), start=1, stop=10), las=2, main=colnames(dset)[integerList[i]], cex.main=0.5, cex.names = 0.5)
}
dev.off()

nm<-nmiss(dset)
nm$vars<-as.factor(rownames(nm))
pdf(file=paste0(outdir, "/missing.pdf"), height = 0.3*dim(nm)[1], width = 20)

nm %>%
  arrange(desc(pm)) %>%
  mutate(vars = factor(vars, unique(vars))) %>%
  ggplot() +
  aes(x=vars, y=pm) +
  geom_segment( aes(x=vars, xend=vars, y=0, yend=pm), color="skyblue") +
  geom_point( color="blue", size=2, alpha=0.6) +
  #geom_text(aes(label = round(pm),2), hjust = 1, size = 3) +
  theme_light() +
  coord_flip() +
  scale_y_continuous(
    "Missing ratio",
    sec.axis = sec_axis(~ ., name = "Missing ratio")
  )+
  theme(
    panel.grid.major.y = element_blank(),
    panel.border = element_blank(),
    axis.ticks.y = element_blank()
  )

dev.off()

# MISSING ANALYSIS ----

require("missCompare")
library(missCompare)


nm.miss <- nm %>%
  filter(pm>=0.05)

write_csv2(nm.miss, file=paste0(outdir, "/missing.5.pc.csv"))

nm.miss <- nm %>%
  filter(pm>=0.1)

write_csv2(nm.miss, file=paste0(outdir, "/missing.10.pc.csv"))

nm.miss <- nm %>%
  filter(pm>=0.25)

write_csv2(nm.miss, file=paste0(outdir, "/missing.25.pc.csv"))

nm.miss <- nm %>%
  filter(pm>=0.5)

write_csv2(nm.miss, file=paste0(outdir, "/missing.50.pc.csv"))

nm.miss <- nm %>%
  filter(pm>=0.75)

write_csv2(nm.miss, file=paste0(outdir, "/missing.75.pc.csv"))

nm.miss <- nm %>%
  filter(pm>=0.90)

write_csv2(nm.miss, file=paste0(outdir, "/missing.90.pc.csv"))


jpeg(file=paste0(outdir, "/missing.5.jpeg"), height = 8, width = 4, units = "in", res = 300)

nm %>%
  filter(pm>=0.05) %>%
  ggplot(aes(x=reorder(vars, -pm), y=pm)) + 
  geom_bar(stat = "identity", width=0.5) +
  xlab("Variable") +
  ylab("MIssing fraction") +
  theme(axis.text.y=element_text(size = 6)) +
  coord_flip()

dev.off()

