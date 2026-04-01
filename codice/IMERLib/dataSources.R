# CONTRIBUTO FONTI DATI 2021 ----

Imer1978_2022 <- read_delim("I:/Drive condivisi/IMER/database/Imer1978-2022.csv", 
                            +     delim = ";", escape_double = FALSE, trim_ws = TRUE)

ImerFilterdByYear <- Imer1978_2022 %>%
  filter(Anno>=2022)

rm(Imer1978_2022)

library(ggrepel)

# Schede IMER <1000
# CedAP 1000 < 2000
# SDO 2000 < 4000
# SDO7+ 4000 < 5000
# SDO confermate con Scheda IMER dai referenti 5000 < 6000
# Rare >=6000

# IMER = 4
# CEDAP = 3
# SDO = 1
# SDO+7 = 2
# SDO confermate con Scheda IMER dai referenti = 1
# RARE = 6
# IVG = 5

ImerFilterdByYear$SOURCE=NA

sel<-which(ImerFilterdByYear$Numero<1000)
ImerFilterdByYear[sel, "SOURCE"]<-4

sel<-which(ImerFilterdByYear$Numero>=1000 & ImerFilterdByYear$Numero<2000)
ImerFilterdByYear[sel, "SOURCE"]<-3

sel<-which(ImerFilterdByYear$Numero>=2000 & ImerFilterdByYear$Numero<4000)
ImerFilterdByYear[sel, "SOURCE"]<-1

sel<-which(Imer2016.2020$Numero>=4000 & ImerFilterdByYear$Numero<5000)
ImerFilterdByYear[sel, "SOURCE"]<-2

sel<-which(ImerFilterdByYear$Numero>=5000 & ImerFilterdByYear$Numero<6000)
ImerFilterdByYear[sel, "SOURCE"]<-1

sel<-which(ImerFilterdByYear$Numero>=6000)
ImerFilterdByYear[sel, "SOURCE"]<-6

sel<-which(ImerFilterdByYear$TipoDiNascita==4)
ImerFilterdByYear[sel, "SOURCE"]<-5
table(ImerFilterdByYear$SOURCE)

ImerFilterdByYear$SOURCE<-factor(ImerFilterdByYear$SOURCE, levels=c(1,2,3,4,5,6))

relTab<-data.frame(prop.table(table(ImerFilterdByYear$SOURCE)))
#relTab<-relTab[-3,]
relTab$Var1<-droplevels(relTab$Var1)

relTablabs <- relTab %>% 
  mutate(csum = rev(cumsum(rev(Freq))), 
         pos = Freq/2 + lead(csum, 1),
         pos = if_else(is.na(pos), Freq/2, pos))

jpeg(filename = paste0(plotDir, "/contributo.fonti.dati", ".jpg"), 
     width = 4, height = 4, units = "in", pointsize = 12,
     res = 300)

p<-ggplot(relTab, aes(x="", y=Freq, fill=Var1)) + 
  geom_bar(stat="identity", width=1, color="white") +
  geom_label_repel(data = relTablabs,
                   aes(y = pos, label = paste0(round(Freq*100,2), "%")),
                   segment.colour="black", size = 4, nudge_x = 1, show.legend = FALSE) +
  coord_polar("y", start=0) +
  scale_fill_manual(labels = c("SDO", "SDO >7d", "CedAP", "IMER", "IVG", "Registro malattie rare"), 
                    values = c("lightskyblue3", "lightblue", "orange", "mediumpurple2", "darkolivegreen3", "indianred1")) +
  ggtitle("Contributi delle fonti di accertamento", subtitle = "2016 - 2020") +
  theme_void() +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        # axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
        # #panel.grid.major = element_blank(),  
        # panel.grid.minor = element_blank(),
        legend.title = element_blank(),
        legend.position = "bottom"
  )
p

dev.off()