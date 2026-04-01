#' ---
#' title: "CHD, CHD severe, DIV"
#' author: "Marco Manfrini, Ph.D."
#' date: "Settembre 08, 2022"
#' ---
 
#+ echo = FALSE
 
# ESTRAZIONE DATI CHD DAL REGISTRO IMER

source("/Users/mmanfrini/Analisi/template/codice/funbox.v2.R")

library(zoo)

library(trendsegmentR)

# FUNCTIONS

findICD9Cases<-function(codes, data){
  selected<- NULL
  for(c in 1:dim(data)[2]){
    for(code in codes){
      selected<-c(selected, grep(paste0("^",code), data[,c]))
    }
  }
  # apply(data,
  #       MARGIN = 2,
  #       FUN = function(x, codes, selected){
  #         for (code in codes){
  #           selected<-c(selected, grep(code, x))
  #         }
  #       },
  #       codes,
  #       selected
  #     )
  return(selected)
}

# PATH ----

wd<-"/Users/mmanfrini/Analisi/ballardini/clearinghouse.2022"
setwd(wd)
indir=paste0(wd, "/preprocess")
outdir=paste0(wd,"/out")

## GLOBAL VARS ----

RAW=F


# LOAD IMER DATA ----

## LOAD DATASET ----

if(RAW==F){
  dset.ana <- read.csv2(paste0(indir,"/imerdb.csv"),
                        stringsAsFactors=FALSE) #, na.strings = ""
}

## LOAD POPULATION DATA ----

if(RAW==F){
  dset.pop <- read.csv2(paste0(indir,"/cedap.agg.csv"),
                        stringsAsFactors=FALSE) #, na.strings = ""
}

# ESTRAZIIONE ----

## CHD Sindormi + isolate ----

codes=c("745", "746", "7470", "7471", "7472", "7473", "7474")

sel<-unique(findICD9Cases(codes = codes, dset.ana[, c(15:22)]))

dset.ana$CHD<-rep(0, dim(dset.ana)[1])

dset.ana[sel, "CHD"]<-1

## CHD SEVERE Sindromi + isolate ----

codes.s=c("74500", "74510", "7452", "7453", "7456", "74600", "7461", "7462", "7463", "7467", "7471", "74742")

sel.s<-unique(findICD9Cases(codes = codes.s, dset.ana[, c(15:22)]))

dset.ana$CHDS<-rep(0, dim(dset.ana)[1])

dset.ana[sel.s, "CHDS"]<-1

## DIV Sindromi + isolate  ----

# ICD10 
# codes.s=c("Q21.0")
# 
# sel.s<-unique(findICD9Cases(codes = codes.s, dset.ana[, c(193:200)]))

codes.d=c("7454")

sel.d<-unique(findICD9Cases(codes = codes.d, dset.ana[, c(15:22)]))

dset.ana$DIV<-rep(0, dim(dset.ana)[1])

dset.ana[sel.d, "DIV"]<-1

## DESCRITTIVA CHD CHIAVE IMER ----

# rms

dset.descr<-dset.ana[which(dset.ana$Anno>1999), c(1, 8, 15, 23, 90, 218, 219, 220)]

ddist<-datadist(dset.descr)
options(datadist=ddist)

tab1<-summary(ChiaveIMER ~ ., method = 'rev', overall = T, test = T, data = dset.descr)
tab1.printed<-print(tab1, prtest = c('P'), npct = c('numerator'), prmsd = TRUE, digits = 2, prType = "latex")
write.csv2(tab1.printed, file=paste0(outdir, "/descriptive.chd.chiaveimer.2000.2019.csv"))

# chd chiave imer

pt.chd<-prop.table(table(dset.descr$CHD, dset.descr$ChiaveIMER), margin = 1)
pt.chds<-prop.table(table(dset.descr$CHDS, dset.descr$ChiaveIMER), margin = 1)
pt.div<-prop.table(table(dset.descr$DIV, dset.descr$ChiaveIMER), margin = 1)

pt<-round(rbind(pt.chd[2,], pt.chds[2,], pt.div[2,])*100, 2)

rownames(pt)<-c("CHD", "CHDS", "DIV")
pt

sindrome<-data.frame(prop.table(table(dset.descr$Sindrome))*100)
colnames(sindrome)<-c("ICD9", "Freq_perc")

# TipoDiNascita
# 1 = nato vivo
# 2 = nato nato morto
# 3 = aborti spontanei
# 4 = topfa

topfa<-prop.table(table(dset.descr$CHDS, dset.descr$TipoDiNascita),1)*100

write.csv2(pt, file = paste0(outdir, "/pt.csv"), row.names = F)
write.csv2(sindrome, file = paste0(outdir, "/sindrome.csv"), row.names = F)
write.csv2(topfa, file = paste0(outdir, "/topfa.csv"), row.names = F)

## PROPS PER YEAR ----

years<-sort(unique(dset.ana$Anno))
prev.table<-data.frame()
for( year in years){
  num.chd<-table(dset.ana[which(dset.ana$Anno==year), "CHD"])[2]
  denom.chd<-dset.pop[which(dset.pop$year==year), "birth_merged"]
  if(!is.na(denom.chd)){
    prev.chd.1000<-num.chd/denom.chd*1000
  } else {
    prev.chd.1000<-NA
  }
  prev.chd.1000 
  
  
  num.chds<-table(dset.ana[which(dset.ana$Anno==year), "CHDS"])[2]
  denom.chds<-dset.pop[which(dset.pop$year==year), "birth_merged"]
  if(!is.na(denom.chds)){
    prev.chds.1000<-num.chds/denom.chds*1000
  } else {
    prev.chds.1000<-NA
  }
  prev.chds.1000
  
  num.div<-table(dset.ana[which(dset.ana$Anno==year), "DIV"])[2]
  denom.div<-dset.pop[which(dset.pop$year==year), "birth_merged"]
  if(!is.na(denom.chds)){
    prev.div.1000<-num.div/denom.div*1000
  } else {
    prev.div.1000<-NA
  }
  prev.div.1000
  
  table.row<-cbind(year, num.chd, prev.chd.1000, num.chds, prev.chds.1000, num.div, prev.div.1000)
  prev.table<-rbind(prev.table, table.row)
}

colnames(prev.table)<-c("Year", "TOT.CHD", "CHD", "TOT.CHDS", "CHDS", "TOT.DIV", "DIV")
prev.table

## PROPS RELATIVE TOTAL AND PER YEAR CHD CHDS ----

dset.plot.chd.chds<-data.frame()

dset.tables<-dset.ana[which(dset.ana$CHD==1 & dset.ana$Anno>1999), ]
t.chd.chds<-data.frame(prop.table(table(dset.tables$CHD, dset.tables$CHDS))*100)
colnames(t.chd.chds)<-c("CHD", "CHDS", "Frequency(%)")
t.chd.chds

for(year in unique(dset.tables$Anno)){
  dset.tables.y<-dset.ana[which(dset.ana$CHD==1 & dset.ana$Anno==year), ]
  t.chd.chds.y<-data.frame(prop.table(table(dset.tables.y$CHD, dset.tables.y$CHDS))*100)
  colnames(t.chd.chds.y)<-c("CHD", "CHDS", "Frequency(%)")
  print(year)
  print(t.chd.chds.y)
  dset.plot.chd.chds<-rbind(
    dset.plot.chd.chds,
    cbind(rep(year, 2), t.chd.chds.y[,2:3])
  )
}

colnames(dset.plot.chd.chds)<-c("year", "group", "pfreq")

## PROPS RELATIVE PER YEAR CHD DIV ----

dset.plot.chd.div<-data.frame()

dset.tables<-dset.ana[which(dset.ana$CHD==1 & dset.ana$Anno>1999), ]
t.chd.div<-data.frame(prop.table(table(dset.tables$CHD, dset.tables$DIV))*100)
colnames(t.chd.div)<-c("CHD", "DIV", "Frequency(%)")
t.chd.div

for(year in unique(dset.tables$Anno)){
  dset.tables.y<-dset.ana[which(dset.ana$CHD==1 & dset.ana$Anno==year), ]
  t.chd.div.y<-data.frame(prop.table(table(dset.tables.y$CHD, dset.tables.y$DIV))*100)
  colnames(t.chd.div.y)<-c("CHD", "DIV", "Frequency(%)")
  print(year)
  print(t.chd.div.y)
  dset.plot.chd.div<-rbind(
    dset.plot.chd.div,
    cbind(rep(year, 2), t.chd.div.y[,2:3])
  )
}

colnames(dset.plot.chd.div)<-c("year", "group", "pfreq")

## PLOT PREVALENCE PER YEAR ----

dset.plot<-prev.table[which(prev.table$Year>1999), ]

## CHD

lm.chd<-lm(dset.plot$CHD~index(dset.plot$Year))
summary(lm.chd)
pval<-ifelse(summary(lm.chd)$coef[2,4]<0.001,"<0.001", paste0("=", round(summary(lm.chd)$coef[2,4],3)))

tsfit <- trendsegment(dset.plot$CHD, bal = 0, th.const = 1.1, continuous=TRUE, connected=TRUE)
print(tsfit)
plot(dset.plot$CHD, type = "b", ylim = range(dset.plot$CHD, tsfit$est))
lines(tsfit$est, col=2, lwd=2)

lm.div.1<-lm(dset.plot[c(1:tsfit$cpt[1]),"CHD"]~dset.plot[c(1:tsfit$cpt[1]),"Year"])
summary(lm.div.1)
pval.1<-ifelse(summary(lm.div.1)$coef[2,4]<0.001,"<0.001", paste0("=", round(summary(lm.div.1)$coef[2,4],3)))

lm.div.2<-lm(dset.plot[c(tsfit$cpt[1]:length(tsfit$est)),"CHD"]~dset.plot[c(tsfit$cpt[1]:length(tsfit$est)),"Year"])
summary(lm.div.2)
pval.2<-ifelse(summary(lm.div.2)$coef[2,4]<0.001,"<0.001", paste0("=", round(summary(lm.div.2)$coef[2,4],3)))

r1<- data.frame (xmin=2007, xmax=Inf, ymin=-Inf, ymax=Inf) # CEDAP + SDO
segs<-data.frame(x1=2000, x2=2007, y1=tsfit$est[1], y2=tsfit$est[tsfit$cpt])
segs.2<-data.frame(x1=2007, x2=2019, y1=tsfit$est[tsfit$cpt], y2=tsfit$est[length(tsfit$est)])

p<-ggplot(dset.plot, aes(x=(Year), y=CHD, group = 1)) +
  geom_line(color = "gray") + #aes(color=PVL)
  geom_point(color = "gray") + #aes(shape/color=PVL)
  geom_rect(data=r1, aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax), fill="gray", alpha=0.2, inherit.aes = FALSE) +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), colour="blue", lwd = 0.8, data = segs) +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), colour="blue", lwd= 0.8, data = segs.2) +
  #geom_smooth(method = "lm", size=0.1, colour="black") +
  scale_x_continuous(breaks = seq(min(dset.plot$Year), max(dset.plot$Year), by = 1)) +
  ylim(0, 15) +
  ggtitle("CHD") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
        panel.grid.major = element_blank()#, panel.grid.minor = element_blank()
        ) +
  xlab("Year") +
  ylab("Prevalence x1000") +
  annotate("text", 2004, 0.5, label=paste0("Overall linear trend: p", pval)) +
  annotate("text", 2001, 12.5, label=paste0("p", pval.1), size = 3) +
  annotate("text", 2010, 12.5, label=paste0("p", pval.2), size = 3) +
  annotate("text", 2000, 7.5, label="6.56", size = 3, color = "grey30") +
  annotate("text", 2007, 3.5, label="4.76", size = 3, color = "grey30") +
  annotate("text", 2019, 8.5, label="9.30", size = 3, color = "grey30")
p

## CHDS

lm.chds<-lm(dset.plot$CHDS~dset.plot$Year)
summary(lm.chds)
pval<-ifelse(summary(lm.chds)$coef[2,4]<0.001,"<0.001", paste0("=", round(summary(lm.chds)$coef[2,4],3)))

tsfit <- trendsegment(dset.plot$CHDS, bal = 0, th.const = 1.1, continuous=TRUE, connected=TRUE)
print(tsfit)
plot(dset.plot$CHDS, type = "b", ylim = range(dset.plot$CHDS, tsfit$est))
lines(tsfit$est, col=2, lwd=2)

lm.div.1<-lm(dset.plot[c(1:tsfit$cpt[1]),"CHDS"]~dset.plot[c(1:tsfit$cpt[1]),"Year"])
summary(lm.div.1)
pval.1<-ifelse(summary(lm.div.1)$coef[2,4]<0.001,"<0.001", paste0("=", round(summary(lm.div.1)$coef[2,4],3)))

lm.div.2<-lm(dset.plot[c(tsfit$cpt[1]:length(tsfit$est)),"CHDS"]~dset.plot[c(tsfit$cpt[1]:length(tsfit$est)),"Year"])
summary(lm.div.2)
pval.2<-ifelse(summary(lm.div.2)$coef[2,4]<0.001,"<0.001", paste0("=", round(summary(lm.div.2)$coef[2,4],3)))


r1<- data.frame (xmin=2008, xmax=Inf, ymin=-Inf, ymax=Inf) # CEDAP + SDO
segs<-data.frame(x1=2000, x2=2008, y1=tsfit$est[1], y2=tsfit$est[tsfit$cpt])
segs.2<-data.frame(x1=2008, x2=2019, y1=tsfit$est[tsfit$cpt], y2=tsfit$est[length(tsfit$est)])

p<-ggplot(dset.plot, aes(x=(Year), y=CHDS, group = 1)) +
  geom_line(color = "gray") + #aes(color=PVL)
  geom_point(color = "gray") + #aes(shape/color=PVL)
  geom_rect(data=r1, aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax), fill="grey", alpha=0.2, inherit.aes = FALSE) +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), colour="red", lwd = 0.8, data = segs) +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), colour="red", lwd= 0.8, data = segs.2) +
  scale_x_continuous(breaks = seq(min(dset.plot$Year), max(dset.plot$Year), by = 1)) +
  #geom_smooth(method = "lm", size=0.1, colour="black") +
  ylim(0, 5) +
  ggtitle("SEVERE CHD") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
        panel.grid.major = element_blank()#, panel.grid.minor = element_blank()
        ) +
  xlab("Year") +
  ylab("Prevalence x1000") +
  annotate("text", 2004, 0.2, label=paste0("Overall linear trend: p", pval)) +
  annotate("text", 2001, 4, label=paste0("p", pval.1), size = 3) +
  annotate("text", 2010, 4, label=paste0("p", pval.2), size = 3) +
  annotate("text", 2000, 2.8, label="2.54", size = 3, color = "grey30") +
  annotate("text", 2008, 1.2, label="1.55", size = 3, color = "grey30") +
  annotate("text", 2019, 3, label="2.66", size = 3, color = "grey30")
p

## DIV

lm.div<-lm(dset.plot$DIV~dset.plot$Year)
summary(lm.div)
pval<-ifelse(summary(lm.div)$coef[2,4]<0.001,"<0.001", paste0("=", round(summary(lm.div)$coef[2,4],3)))

tsfit <- trendsegment(dset.plot$DIV, bal = 0, th.const = 1.3, continuous=TRUE, connected=TRUE)
print(tsfit)
plot(dset.plot$DIV, type = "b", ylim = range(dset.plot$DIV, tsfit$est))
lines(tsfit$est, col=2, lwd=2)

lm.div.1<-lm(dset.plot[c(1:tsfit$cpt[1]),"DIV"]~dset.plot[c(1:tsfit$cpt[1]),"Year"])
summary(lm.div.1)
pval.1<-ifelse(summary(lm.div.1)$coef[2,4]<0.001,"<0.001", paste0("=", round(summary(lm.div.1)$coef[2,4],3)))

lm.div.2<-lm(dset.plot[c(tsfit$cpt[1]:tsfit$cpt[2]),"DIV"]~dset.plot[c(tsfit$cpt[1]:tsfit$cpt[2]),"Year"])
summary(lm.div.2)
pval.2<-ifelse(summary(lm.div.2)$coef[2,4]<0.001,"<0.001", paste0("=", round(summary(lm.div.2)$coef[2,4],3)))

lm.div.3<-lm(dset.plot[c(tsfit$cpt[2]:length(tsfit$est)),"DIV"]~dset.plot[c(tsfit$cpt[2]:length(tsfit$est)),"Year"])
summary(lm.div.3)
pval.3<-ifelse(summary(lm.div.3)$coef[2,4]<0.001,"<0.001", paste0("=", round(summary(lm.div.3)$coef[2,4],3)))

r1<- data.frame (xmin=2007, xmax=2014, ymin=-Inf, ymax=Inf) # CEDAP + SDO
r2<- data.frame (xmin=2014, xmax=Inf, ymin=-Inf, ymax=Inf) # CEDAP + SDO
segs<-data.frame(x1=2000, x2=2007, y1=tsfit$est[1], y2=tsfit$est[tsfit$cpt[1]])
segs.2<-data.frame(x1=2007, x2=2014, y1=tsfit$est[tsfit$cpt[1]], y2=tsfit$est[tsfit$cpt[2]])
segs.3<-data.frame(x1=2014, x2=2019, y1=tsfit$est[tsfit$cpt[2]], y2=tsfit$est[length(tsfit$est)])

p<-ggplot(dset.plot, aes(x=(Year), y=DIV, group = 1)) +
  geom_line(color = "gray") + #aes(color=PVL)
  geom_point(color = "gray") + #aes(shape/color=PVL)
  geom_rect(data=r1, aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax), fill="grey", alpha=0.2, inherit.aes = FALSE) +
  geom_rect(data=r2, aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax), fill="white", alpha=0.2, inherit.aes = FALSE) +
  scale_x_continuous(breaks = seq(min(dset.plot$Year), max(dset.plot$Year), by = 1)) +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), colour="orange", lwd = 0.8, data = segs) +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), colour="orange", lwd= 0.8, data = segs.2) +
  geom_segment(aes(x = x1, y = y1, xend = x2, yend = y2), colour="orange", lwd= 0.8, data = segs.3) +
  #geom_smooth(method = "lm", size=0.1, colour="black") +
  ylim(0, 10) +
  #xlim(2000, 2020) +
  ggtitle("DIV") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
        panel.grid.major = element_blank()#, panel.grid.minor = element_blank()
  ) +
  xlab("Year") +
  ylab("Prevalence x1000") +
  annotate("text", 2004, 0.5, label=paste0("Overall linear trend: p", pval)) +
  annotate("text", 2001, 8, label=paste0("p", pval.1), size = 3) +
  annotate("text", 2010, 8, label=paste0("p", pval.2), size = 3) +
  annotate("text", 2016, 8, label=paste0("p", pval.3), size = 3) +
  annotate("text", 2000, 3.8, label="3.14", size = 3, color = "grey30") +
  annotate("text", 2007, 1.8, label="2.40", size = 3, color = "grey30") +
  annotate("text", 2014, 5, label="5.97", size = 3, color = "grey30") +
  annotate("text", 2019, 5.3, label="5.73", size = 3, color = "grey30")
p


## PLOT RELATIVE PERCENT CHD CHDS----

# Stacked + percent
p<-ggplot(dset.plot.chd.chds, aes(fill=group, y=pfreq, x=year)) + 
  geom_bar(stat="identity") +
  scale_fill_manual(values=c("grey", "orange"), labels = c("CHD", "DIV")) +
  ggtitle("CHD - severe CHD") +
  xlab("Anno") +
  ylab("Frequenza (%)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
        panel.grid.major = element_blank()#, panel.grid.minor = element_blank()
  )
p

## PLOT RELATIVE PERCENT CHD DIV----

# Stacked + percent
p<-ggplot(dset.plot.chd.div, aes(fill=group, y=pfreq, x=year)) + 
  geom_bar(stat="identity") +
  scale_fill_manual(values=c("grey", "orange"), labels = c("CHD", "DIV")) +
  ggtitle("CHD - DIV") +
  xlab("Anno") +
  ylab("Frequenza (%)") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
        panel.grid.major = element_blank(), # panel.grid.minor = element_blank()
        legend.title = element_blank()
  )
p

## PLOT SOURCE RELATIVE CONTRIBUTION  ----

# IMER = 4
# CEDAP = 3
# SDO = 1
# SDO+7 = 2
# SDO confermate con Scheda IMER dai referenti = 1
# RARE = 4

library(viridis)
library(hrbrthemes)
library(ggridges)

dset.ana$SOURCE=NA

sel<-which(dset.ana$Numero<1000)
dset.ana[sel, "SOURCE"]<-4

sel<-which(dset.ana$Numero>=1000 & dset.ana$Numero<2000)
dset.ana[sel, "SOURCE"]<-3

sel<-which(dset.ana$Numero>=2000 & dset.ana$Numero<4000)
dset.ana[sel, "SOURCE"]<-1

sel<-which(dset.ana$Numero>=4000 & dset.ana$Numero<5000)
dset.ana[sel, "SOURCE"]<-2

sel<-which(dset.ana$Numero>=5000 & dset.ana$Numero<6000)
dset.ana[sel, "SOURCE"]<-1

sel<-which(dset.ana$Numero>=6000)
dset.ana[sel, "SOURCE"]<-4
table(dset.ana$SOURCE)

dset.plot<-dset.ana[which(dset.ana$Anno>2006), c(2, 218, 219,220,221) ]

# Percentuale contributo sorgenti dati solo sui div

dset.plot<-dset.plot[which(dset.plot$DIV==1),]

dset.agg<-as.data.frame(
  dset.plot %>%
  group_by(Anno, SOURCE) %>%
  summarise(n=n()) %>%
  mutate(p = n / sum(n, na.rm = TRUE))
  )

dset.agg<-dset.agg %>%
  complete(Anno, SOURCE, fill = list(n=0, p=0))

dset.agg$prev<-dset.agg$n/sum(dset.agg$n)

cedap<-rep(NA, dim(dset.agg)[1])
for(i in 1:dim(dset.agg)[1]){
  cedap[i]<-dset.pop[which(dset.pop$year==pull(dset.agg[i,"Anno"])), "birth_merged"]
}
  
dset.agg<-mutate(dset.agg, cedap=cedap)
dset.agg<-mutate(dset.agg, prev.cedap=n/cedap)

dset.agg<-mutate_at(dset.agg, vars(prev)
                    ~ .x * 1000) %>%
          mutate_at(dset.agg, vars(p),
                    ~ .x * 100) %>%
          mutate_at(dset.agg, vars(prev.cedap),
                    ~ .x * 1000)

# dset.agg$prev<-dset.agg$prev*1000
# dset.agg$p<-dset.agg$p*100
# dset.agg$prev.cedap<-dset.agg$prev.cedap*1000


## PLOT
# n= absolute number
# p=relative frequecy per class
# prev.cedap=prevalence per year

dset.agg$SOURCE<-factor(dset.agg$SOURCE, levels=c(1,2,3,4))

p<-ggplot(dset.agg, aes(x=(Anno), y=(p), fill=as.character(SOURCE))) + 
  geom_area() +
  scale_fill_manual(labels = c("SDO", "SDO >7d", "CEDAP", "IMER"), 
                     values = c("gray", "darkseagreen1", "sandybrown", "royalblue")) +
  ggtitle("Data sources DIV") +
  xlab("Year") +
  ylab("(%)") + #Prevalence x1000
  scale_x_continuous(breaks = seq(min(dset.agg$Anno), max(dset.agg$Anno), by = 1)) +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
        #panel.grid.major = element_blank(),  
        panel.grid.minor = element_blank(),
        legend.title = element_blank(),
        legend.position = "bottom"
  )
p

write.csv2(dset.agg, file = paste0(outdir, "/strange.misure.sources.csv"), row.names = F)

## EXPORT TABLES ----

write.csv2(dset.ana[which(dset.ana$CHD==1), ], file = paste0(outdir, "/imer.chd.csv"), row.names = F)
write.csv2(dset.ana[which(dset.ana$CHDS==1), ], file = paste0(outdir, "/imer.chds.csv"), row.names = F)
write.csv2(dset.ana[which(dset.ana$DIV==1), ], file = paste0(outdir, "/imer.div.csv"), row.names = F)
write.csv2(t.chd.chds.y, file = paste0(outdir, "/imer.chd.chds.y.csv"), row.names = F)
write.csv2(t.chd.div.y, file = paste0(outdir, "/imer.chd.div.y.csv"), row.names = F)
write.csv2(dset.ana, file = paste0(outdir, "/imer.indicatori.csv"), row.names = F)
write.csv2(prev.table, file=paste0(outdir, "/dset.div.agg.table.csv"), row.names = F)

