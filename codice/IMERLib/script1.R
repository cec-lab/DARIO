# COSTRUZIONE DELLA TABELLA DA IMPORTARE NEL DATABASE .mdb PRIMA DI EFFETTUARE 
# INTEGRAZIONE CON DATI CEDAP E SDO

# packages ----


# Tabella schede ----
Schede <- read.csv2("~/IMER/IMER/2020/Schede.csv")
View(Schede)

# Tabella malformazioni ----
Malformazioni <- read.csv("~/IMER/IMER/2020/Malformazioni.csv", sep=";")
Malfromazioni <- Malformazioni[with(Malformazioni, order(Codice, Principale)), ]
View(Malformazioni)

# Template output ----
outTemplate <- read.csv("~/IMER/IMER/2020/RegistroAmanda.csv", sep=";")

# Selezione dei casi 2020 dalle schede ----
ss<-grep("2020", Schede$Anno)
Schede.2020<-Schede[ss,]

# Selezione dei casi 2020 dalle malformazioni ----
# Codifica nuova variabile NMALF (numero progressivo malformazione per paziente)
# Reshape long 2 wide

sm<-grep("2020", Malformazioni$Codice)
Malformazioni.2020<-Malformazioni[sm,]
Malformazioni.2020$NMALF<-rep(NA, dim(Malformazioni.2020)[1])
for(c in Malformazioni.2020$Codice){
  sel<-which(Malformazioni.2020$Codice==c)
  Malformazioni.2020[sel,"NMALF"]<-seq(1:length(sel))
}
Malformazioni.2020.w<-reshape(Malformazioni.2020, idvar = "Codice", 
                              timevar = "NMALF", 
                              v.names = c("ICD9", "ICD10", "Descrizione"),
                              direction = "wide")

# RIMOZIONE ELIMINATI ----
sel.m<-which(Malformazioni.2020.w$ICD9.1=="999999")
codes<-Malformazioni.2020.w[sel.m, "Codice"]

if(length(codes)>0){
  sel.s<-vector()
  for(c in codes){
    s=NULL
    print(c)
    s<-which(Schede.2020$Codice==c)
    if(!is.null(s)){
      
    }
    sel.s<-c(sel.s, s)
  }
  sel.s
  
  Malformazioni.2020.w<-Malformazioni.2020.w[-sel.m,]
  Schede.2020<-Schede.2020[-sel.s,]
}



# LINKAGE Malformazioni wide con schede ----

# Vettore dei numeri di riga del dataset malfromazioni che corrisponodono alle
# singole schede. Il valore 0 indica nessuna corrispondenza

linked<-rep(0, dim(Schede.2020)[1])

for(i in 1:dim(Schede.2020)[1]){
  code<-Schede.2020[i, "Codice"]
  l<-which(Malformazioni.2020.w$Codice==code)
  ifelse(length(l)>0, linked[i]<-l, linked[i]<-0)
}

Schede.2020$link.malf<-linked

# Dataframe ordinato delle malformazioni secondo quanto indicato nella variabile
# Schede.2020$link.malf


malf.selected.ordered<-data.frame()
blank_line<-data.frame(matrix(data = rep(NA, 27), nrow = 1))
colnames(blank_line)<-colnames(Malformazioni.2020.w)
for(i in 1:dim(Schede.2020)[1]){
  l<-Schede.2020[i, "link.malf"]
  if(l!=0){
    malf.selected.ordered<-rbind(malf.selected.ordered, Malformazioni.2020.w[l,])  
  } else {
    malf.selected.ordered<-rbind(malf.selected.ordered, 
                                 blank_line)  
  }
}

tmpSet<-cbind(Schede.2020, malf.selected.ordered)

# OUT

dset.out<-outTemplate[0,]
dset.out<-cbind(
  tmpSet$Anno,
  tmpSet$NumScheda,
  tmpSet$CodCentro,
  tmpSet$DataNascita,
  tmpSet$Cognome,
  tmpSet$Nome,
  tmpSet$Principale,
  tmpSet[,c(16, 19, 22, 25, 28, 31, 34, 35,    #ICD9
           17, 20, 23, 26, 29, 32, 35, 38)],   #ICD10
  tmpSet[, c(18, 21, 24, 27, 30, 33, 36, 39)], #Descrizioni
  tmpSet$Formula
)
colnames(dset.out)<-colnames(outTemplate)

dset.out.no.na<-dset.out[which(!is.na(dset.out$ICD91)),]

# CONTROLLO MISSING VARIABILE 'PRINCIPALE' ----
# SE SONO PRESENTI IL CLINICO DEVE INSERIRE I DATI MANCANTI

selected<-dset.out.no.na[which(dset.out.no.na$Principale==""),]
selected<-selected[which(!is.na(selected$ICD92)),]

# WRITE DATASETS ----

write.csv2(dset.out, file = paste0(getwd(), "/missings.csv"), row.names = F)
write.csv2(dset.out, file = paste0(getwd(), "/amanda.csv"), row.names = F, na="-")
write.csv2(dset.out.no.na, file = paste0(getwd(), "/amanda.no.na.csv"), row.names = F, na="-")
