# Functions ---------------------------------------------
source("/Users/mmanfrini/Analisi/template/codice/funbox.v2.R")
library(readxl)

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

wd<-("/Users/mmanfrini/Analisi/IMER")
setwd(wd)
indir=paste0(wd, "/imerdb/2019")
outdir=paste0(wd,"/cocchi")

# LOAD DATASET RAW ----

# imer db

dset <- read.csv2(paste0(indir,"/imerdb.csv"),
                    stringsAsFactors=T)


eurocat_imer_tab1 <- read_excel("cocchi/eurocat.imer.tab1.xlsx", 
                                skip = 18)
a<-NULL
for(i in 1:dim(eurocat_imer_tab1)[1]){
  if(!is.na(eurocat_imer_tab1[i, "Anomaly ^"])){
    a<-eurocat_imer_tab1[i, "Anomaly ^"]  
  } else {
    eurocat_imer_tab1[i, "Anomaly ^"]=a  
  }
}

eurocat_imer_tab1$`Total N`<-as.numeric(eurocat_imer_tab1$`Total N`)
eurocat_imer_tab1$`LB N`<-as.numeric(eurocat_imer_tab1$`LB N`)
eurocat_imer_tab1$`FD N`<-as.numeric(eurocat_imer_tab1$`FD N`)
eurocat_imer_tab1$`TOPFA N`<-as.numeric(eurocat_imer_tab1$`TOPFA N`)

# eurocat

eurocat_all_tab1 <- read_excel("cocchi/eurocat.all.tab1.xlsx", 
                                skip = 54)
a<-NULL
for(i in 1:dim(eurocat_all_tab1)[1]){
  if(!is.na(eurocat_all_tab1[i, "Anomaly ^"])){
    a<-eurocat_all_tab1[i, "Anomaly ^"]  
  } else {
    eurocat_all_tab1[i, "Anomaly ^"]=a  
  }
}

eurocat_all_tab1$`Total N`<-as.numeric(eurocat_all_tab1$`Total N`)
eurocat_all_tab1$`LB N`<-as.numeric(eurocat_all_tab1$`LB N`)
eurocat_all_tab1$`FD N`<-as.numeric(eurocat_all_tab1$`FD N`)
eurocat_all_tab1$`TOPFA N`<-as.numeric(eurocat_all_tab1$`TOPFA N`)




# PLOT 1 ----

## Aggregated data

sel<-which(eurocat_all_tab1$`Anomaly ^`== "Severe congenital heart defects" 
           & eurocat_all_tab1$Years<2002)

eurocat_all_tab1<-eurocat_all_tab1[-sel,]

sel<-which(eurocat_all_tab1$Years>2019)

eurocat_all_tab1<-eurocat_all_tab1[-sel,]

tab.agg<-data.frame()

for(i in levels(as.factor(eurocat_imer_tab1$`Anomaly ^`))){
  print(i)
  ax<-eurocat_imer_tab1[which(eurocat_imer_tab1$`Anomaly ^`==i),]
  ax.population.sum<-sum(ax$Population)
  ax.cases.sum<-sum(ax$`LB N`, ax$`FD N`, ax$`TOPFA N`)
  incx<-ax.cases.sum/ax.population.sum*10000
  descx<-ax$`Anomaly ^`
  rowx<-data.frame(descx[1], incx)
  tab.agg<-rbind(tab.agg, rowx)
}

colnames(tab.agg)<-c("Anomaly", "Prevalence")

tab.agg<-tab.agg[which(tab.agg$Anomaly!="All anomalies"),]

tab.agg<-tab.agg[order(-tab.agg$Prevalence),]

tab.agg$Anomaly<-as.character(tab.agg$Anomaly)

recoded<-"Kidney and urinary tract"
tab.agg[5, "Anomaly"]<-recoded

tab.agg$Anomaly<-as.factor(tab.agg$Anomaly)

# column selection

sel<-c(1, 2, 3, 5, 7, 8, 9, 14, 24, 32, 37, 39)

# barplot

p<-ggplot(data=tab.agg[sel,], aes(x=reorder(Anomaly, Prevalence), y=Prevalence)) +
  geom_bar(stat="identity", width=0.5, fill="steelblue") +
  theme(axis.line = element_line(colour = "black",),
        axis.text.y = element_text(vjust=0.3),
        axis.text = element_text(size = 10),
        panel.grid.major = element_blank()) +
  xlab("") +
  ylab("Prevalence x 10,000") +
  coord_flip() +
  ggtitle("EUROCAT Data exchange portal", subtitle = "IMER (1981-2019)")
p

# TABELLA 2 ----

# rimozione anno < 2002 & anno > 2015 da tabella imer per Severe congenital heart defects

eurocat_imer_tab1_reduced<-eurocat_imer_tab1

eurocat_imer_tab1_reduced<-eurocat_imer_tab1_reduced[which(eurocat_imer_tab1_reduced$`Anomaly ^`!="All anomalies"),]

sel<-which(eurocat_imer_tab1_reduced$`Anomaly ^`== "Severe congenital heart defects" 
           & eurocat_imer_tab1_reduced$Years<2002)

eurocat_imer_tab1_reduced<-eurocat_imer_tab1_reduced[-sel,]

sel<-which(eurocat_imer_tab1_reduced$Years>2019)

eurocat_imer_tab1_reduced<-eurocat_imer_tab1_reduced[-sel,]

# dat aggregati imer

tab.agg.imer<-data.frame()

for(i in levels(as.factor(eurocat_imer_tab1_reduced$`Anomaly ^`))){
  print(i)
  ax<-eurocat_imer_tab1_reduced[which(eurocat_imer_tab1_reduced$`Anomaly ^`==i),]
  ax.population.sum<-sum(ax$Population)
  ax.cases.sum<-sum(ax$`LB N`, ax$`FD N`, ax$`TOPFA N`)
  incx<-ax.cases.sum/ax.population.sum*10000
  conf.ll<-(1.96/2 - sqrt(ax.cases.sum + 0.02))^2/ax.population.sum*10000
  conf.ul<-(1.96/2 + sqrt(ax.cases.sum + 0.96))^2/ax.population.sum*10000
  descx<-ax$`Anomaly ^`
  rowx<-data.frame(descx[1], ax.cases.sum, round(incx,3), paste0(round(conf.ll,3), " - ", round(conf.ul,3)))
  tab.agg.imer<-rbind(tab.agg.imer, rowx)
}

colnames(tab.agg.imer)<-c("Anomaly", "Total", "Prevalence", "95% ci")

tab.agg.imer<-tab.agg.imer[order(tab.agg.imer$Anomaly),]

tab.agg.imer[which(tab.agg.imer$Anomaly=="Severe congenital heart defects"), "Years"]<-"2002 - 2019"

tab.agg.imer[which(tab.agg.imer$Anomaly!="Severe congenital heart defects"), "Years"]<-"1981 - 2019"


# dati aggregati EUROCAT

tab.agg.all<-data.frame()

for(i in levels(as.factor(eurocat_all_tab1$`Anomaly ^`))){
  print(i)
  ax<-eurocat_all_tab1[which(eurocat_all_tab1$`Anomaly ^`==i),]
  ax.population.sum<-sum(ax$Population)
  ax.cases.sum<-sum(ax$`LB N`, ax$`FD N`, ax$`TOPFA N`)
  incx<-ax.cases.sum/ax.population.sum*10000
  conf.ll<-(1.96/2 - sqrt(ax.cases.sum + 0.02))^2/ax.population.sum*10000
  conf.ul<-(1.96/2 + sqrt(ax.cases.sum + 0.96))^2/ax.population.sum*10000
  descx<-ax$`Anomaly ^`
  rowx<-data.frame(descx[1], ax.cases.sum, round(incx, 3), paste0(round(conf.ll,3), " - ", round(conf.ul,3)))
  tab.agg.all<-rbind(tab.agg.all, rowx)
}

colnames(tab.agg.all)<-c("Anomaly", "Total", "Prevalence", "95% ci")

tab.agg.all<-tab.agg.all[which(tab.agg.all$Anomaly!="All anomalies"),]

tab.agg.all<-tab.agg.all[order(tab.agg.all$Anomaly),]

tab.agg.all[which(tab.agg.all$Anomaly=="Severe congenital heart defects"), "Years"]<-"2002 - 2019"

tab.agg.all[which(tab.agg.all$Anomaly!="Severe congenital heart defects"), "Years"]<-"1981 - 2019"

# Prevalence comparisons ----

p<-data.frame()

for(i in levels(as.factor(eurocat_imer_tab1_reduced$`Anomaly ^`))){
  print(i)
  
  if(i!="All anomalies"){
    ax.imer<-eurocat_imer_tab1_reduced[which(eurocat_imer_tab1_reduced$`Anomaly ^`==i),]
    ax.imer.population.sum<-sum(ax.imer$Population)
    ax.imer.cases.sum<-sum(ax.imer$`LB N`, ax.imer$`FD N`, ax.imer$`TOPFA N`)
    
    ax.all<-eurocat_all_tab1[which(eurocat_all_tab1$`Anomaly ^`==i),]
    ax.all.population.sum<-sum(ax.all$Population)
    ax.all.cases.sum<-sum(ax.all$`LB N`, ax.all$`FD N`, ax.all$`TOPFA N`)
    
    pt<-prop.test(c(ax.imer.cases.sum, ax.all.cases.sum), # cases
                  c(ax.imer.population.sum, ax.all.population.sum), # trials
                  alternative = "two.sided",
                  conf.level = 0.95,
                  correct = F
    )
    
    row<-cbind(i, round(pt$p.value,2))
    p<-rbind(p, row)  
  }
}

colnames(p)<-c("Anomaly", "p-value")


# merge tables

tabs.merged<-cbind(tab.agg.imer, tab.agg.all, p)

sel<-c(84, # Severe congenital heart defects
       25, # Common arterial truncus
       38, # Double outlet left ventricle
       39, # Double outlet right ventricle
       26, # Complete transposition of great arteries (D-TGA)
       35, # Corrected transposition of great arteries (L-TGA)
       86, # Single ventricle
       103, # Ventricular septal defect
       15, # Atrial septal defect
       16, # Atrioventricular septal defect
       93, # Tetralogy and pentatology of Fallot
       97, # Triscuspid atresia and stenosis
       43, # Ebstein’s anomaly
       81, # Pulmonary valve stenosis
       80, # Pulmonary valve atresia
       11, # Aortic valve atresia/stenosis
       67, # Mitral valve atresia/stenosis
       54, # Hypoplastic left hear (HLH/HLHS)
       55, # Hypoplastic right heart (HRH/HRHS)
       24, # Coarctation of aorta
       10, # Aortic atresia / interrupted aortic arch
       94, # Total anomalous pulmonary venous return
       75 # PDA as only CHD in term infants
       )

tabs.merged<-tabs.merged[sel,]

write.csv2(tabs.merged, file=paste0(outdir, "/tab1.csv"), row.names = F)

# table 3 ----

codes=c("745", "746", "7470", "7471", "7472", "7473", "7474")

imer.1980.1999<-dset[which(dset$Anno>=1980 & dset$Anno<2000),]
imer.2000.2019<-dset[which(dset$Anno>=2000),]

cases.1980.1999<-unique(findICD9Cases(codes = codes, imer.1980.1999[, c(15:22)]))
cases.2000.2019<-unique(findICD9Cases(codes = codes, imer.1980.1999[, c(15:22)]))
  
  
eurocat.1980.1999<-eurocat_all_tab1[which(eurocat_all_tab1$Years>=1980 & eurocat_all_tab1$Years<2000),]
eurocat.2000.2019<-eurocat_all_tab1[which(eurocat_all_tab1$Years>=2000 & eurocat_all_tab1$Years<2020),]

sel<-which(eurocat.1980.1999$`Anomaly ^`== "Congenital Heart Defects")
eurocat.1980.1999<-eurocat.1980.1999[sel,]
tpop.1980.1999<-sum(eurocat.1980.1999$Population)
tN.1980.1999<-sum(eurocat.1980.1999$`Total N`)
p.1980.1999<-tN.1980.1999/tpop.1980.1999*10000

sel<-which(eurocat.2000.2019$`Anomaly ^`== "Congenital Heart Defects")
eurocat.2000.2019<-eurocat.2000.2019[sel,]
tpop.2000.2019<-sum(eurocat.2000.2019$Population)
tN.2000.2019<-sum(eurocat.2000.2019$`Total N`)
p.2000.2019<-tN.2000.2019/tpop.2000.2019*10000

