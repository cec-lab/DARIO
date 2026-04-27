
library(dplyr)
library(purrr)
library(readr)
library(rlang)
library(htmltools)
library(DT)


#Data import

wd <- "~/Desktop/git_hub/DARIO"
setwd(wd)

eurocatData_test_Luca <- read_csv2(
  paste0(wd,"/export/eurocatData.csv"),
  col_types = cols(
    birth_date = col_character(),
    death_date = col_character(),
    datemo     = col_character()
  )
)
eurocatData_test_Luca <- eurocatData_test_Luca %>%
  rename(residmo = resmo)




############################################################
# 1) OMIM NON NA & SYNDROME NA
############################################################
cat("\n==============================\n")
cat("1) OMIM NON NA & SYNDROME NA\n")
cat("==============================\n")

w1 <- subset(eurocatData_test_Luca,
             !is.na(omim) & is.na(syndrome))

cat("Totale:", nrow(w1), "\n")
print(table(w1$data_source))
print(table(w1$omim))

cat("\n--- DETTAGLIO ---\n")
print(w1[, c("numloc","data_source","omim","syndrome", "presyn", "malfo1")])


############################################################
# 2) firstpre=(1:7,11) & presyn != 1
############################################################
cat("\n==============================\n")
cat("2) firstpre=(1:7,11) & presyn != 1\n")
cat("==============================\n")

w2 <- subset(eurocatData_test_Luca,
              firstpre %in% c(1:7,11) & presyn != 1)

w2 |> select(type,firstpre, presyn )

cat("Totale:", nrow(w2), "\n")
print(table(w2$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w2[, c("numloc","data_source","syndrome","firstpre", "presyn")])

############################################################
# 3) whendisc=6 & presyn !=1 | PREMAL1:8 !=1
############################################################
cat("\n==============================\n")
cat("3) whendisc=6 & presyn !=1 & syndrome not NA\n")
cat("==============================\n")

w3 <- subset(eurocatData_test_Luca,
             whendisc == 6 & !(presyn == 1 |premal1 == 1 | premal2 == 1 | premal3 == 1 | premal4 == 1 | premal5 == 1 | premal6 == 1 | premal7 == 1 | premal8 == 1))

cat("Totale:", nrow(w3), "\n")
print(table(w3$data_source))
print(table(w3$presyn))

cat("\n--- DETTAGLIO ---\n")
print(w3[, c("numloc","data_source","whendisc","presyn","premal1","premal2", "premal3", "premal4", "premal5", "premal6","premal7","premal8")])


############################################################
# 5) firstpre 1-2 & gestlength <22
############################################################
cat("\n==============================\n")
cat("5) firstpre 1-2 & gestlength <22\n")
cat("==============================\n")

w5 <- subset(eurocatData_test_Luca,
             firstpre %in% c(1,2) & !is.na(gestlength) & gestlength >= 22)

cat("Totale:", nrow(w5), "\n")
print(table(w5$data_source))
print(table(w5$firstpre, w5$gestlength))

cat("\n--- DETTAGLIO ---\n")
print(w5[, c("numloc","data_source","firstpre","gestlength","type","whendisc")])



############################################################
# 8) firstpre 1:7,11 & nessun premal=1
############################################################
cat("\n==============================\n")
cat("8) firstpre 1:7,11 & nessun premal=1\n")
cat("==============================\n")

w8 <- subset(eurocatData_test_Luca,
             firstpre %in% c(1:7,11) &
               !(premal1 == 1 | premal2 == 1 | premal3 == 1 |
                   premal4 == 1 | premal5 == 1 | premal6 == 1 |
                   premal7 == 1 | premal8 == 1))

cat("Totale:", nrow(w8), "\n")
print(table(w8$data_source))
print(table(w8$firstpre))

cat("\n--- DETTAGLIO ---\n")
print(w8[, c("numloc","data_source",
             "firstpre",
             paste0("premal",1:8),"presyn", "whendisc", "type")])

############################################################
# 9) presyn=1 & karyo=3 & gentest=3
############################################################
cat("\n==============================\n")
cat("9) presyn=1 & karyo=3 & gentest=3\n")
cat("==============================\n")

w9 <- subset(eurocatData_test_Luca,
             presyn==1 & karyo==3 & gentest==3)

cat("Totale:", nrow(w9), "\n")
print(table(w9$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w9[, c("numloc","data_source",
             "presyn","karyo","gentest","firstpre", "type", "syndrome", "gestlength")])

############################################################
# 10) consang=1 & sp_consang vuoto
############################################################
cat("\n==============================\n")
cat("10) consang=1 & sp_consang vuoto\n")
cat("==============================\n")

w10 <- subset(eurocatData_test_Luca,
              consang==1 & (is.na(sp_consang) | sp_consang==""))

cat("Totale:", nrow(w10), "\n")
print(table(w10$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w10[, c("numloc","data_source","consang","sp_consang")])

############################################################
# 11) whendisc=6 & condisc !=1
############################################################
cat("\n==============================\n")
cat("11) whendisc=6 & condisc !=1\n")
cat("==============================\n")

w11 <- subset(eurocatData_test_Luca,
              whendisc==6 & condisc!=1)

cat("Totale:", nrow(w11), "\n")
print(table(w11$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w11[, c("numloc","data_source",
              "whendisc","condisc","firstpre","presyn", "type")])

############################################################
# 12) sex=9 & pm non 3/4/9
############################################################
cat("\n==============================\n")
cat("12) sex=9 & pm non 3/4/9\n")
cat("==============================\n")

w12 <- subset(eurocatData_test_Luca,
              sex==9 & !(pm %in% c(3,4,9)))

cat("Totale:", nrow(w12), "\n")
print(table(w12$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w12[, c("numloc","data_source","sex","pm","type")])

############################################################
# 13) type=4 & presyn=2
############################################################
cat("\n==============================\n")
cat("13) type=4 & presyn=2\n")
cat("==============================\n")

w13 <- subset(eurocatData_test_Luca,
              type==4 & presyn==2)

cat("Totale:", nrow(w13), "\n")
print(table(w13$data_source))
print(table(w13$type, w13$presyn))

cat("\n--- DETTAGLIO CASI ---\n")

print(
  w13[, c("numloc",
          "data_source",
          "type",
          "presyn",
          "syndrome",
          "malfo1","malfo2",
          "premal1","premal2")]
)

############################################################
# 14) type=4 & survival è 1/3/9
############################################################
cat("\n==============================\n")
cat("14) type=4 & survival non 1/3/9\n")
cat("==============================\n")

w14 <- subset(eurocatData_test_Luca,
              type==4 & (survival %in% c(1,3,9)))

cat("Totale:", nrow(w14), "\n")
print(table(w14$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w14[, c("numloc","data_source",
              "type","survival","whendisc")])

############################################################
# 15) totpreg fuori dominio
############################################################
cat("\n==============================\n")
cat("15) totpreg fuori dominio\n")
cat("==============================\n")

w15 <- subset(eurocatData_test_Luca,
              !is.na(totpreg) &
                !(totpreg %in% c("0","1","2","3","4","5","6","7","8","9",
                                 "10","11","12","13","14","15","16",
                                 "17","18","19","20","99")))

cat("Totale:", nrow(w15), "\n")
print(table(w15$data_source))
print(table(w15$totpreg))

cat("\n--- DETTAGLIO ---\n")
print(w15[, c("numloc","data_source","agemo","totpreg")])


############################################################
# 17) nbrbaby>=2 & sp_twin NA
############################################################
cat("\n==============================\n")
cat("17) nbrbaby>=2 & sp_twin NA\n")
cat("==============================\n")

w17 <- subset(eurocatData_test_Luca,
              nbrbaby >=2 & is.na(sp_twin))

cat("Totale:", nrow(w17), "\n")
print(table(w17$data_source))
print(table(w17$nbrbaby))

cat("\n--- DETTAGLIO ---\n")
print(w17[, c("numloc","data_source","nbrbaby","sp_twin", "totpreg", "whendisc")])

############################################################
# 19) whendisc=6 & premal3 non 2/9
############################################################
cat("\n==============================\n")
cat("19) whendisc=6 & premal3 non 2/9\n")
cat("==============================\n")

w19 <- subset(eurocatData_test_Luca,
              whendisc==6 & !(premal3 %in% c(2,9)))

cat("Totale:", nrow(w19), "\n")
print(table(w19$data_source))
print(table(w19$premal3))

cat("\n--- DETTAGLIO ---\n")
print(w19[, c("numloc","data_source","whendisc","premal3", "type", "malfo3", "malfo2", "malfo1")])

############################################################
# 20) premal1-8=1 & karyo=3 & gentest=3
############################################################
cat("\n==============================\n")
cat("20) premal1-8=1 & karyo=3 & gentest=3\n")
cat("==============================\n")

w20 <- subset(eurocatData_test_Luca,
              (premal1==1 | premal2==1 | premal3==1 | premal4==1 |
                 premal5==1 | premal6==1 | premal7==1 | premal8==1) &
                karyo==3 & gentest==3)

cat("Totale:", nrow(w20), "\n")
print(table(w20$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w20[, c("numloc","data_source",
              "premal1","premal2","premal3","premal4",
              "premal5","premal6","premal7","premal8",
              "karyo","gentest","malfo2","whendisc","type")])


############################################################
# 21) whendisc=6 & firstpre 8/9/10
############################################################
cat("\n==============================\n")
cat("21) whendisc=6 & firstpre 8/9/10\n")
cat("==============================\n")

w21 <- subset(eurocatData_test_Luca,
              whendisc==6 & firstpre %in% c(8,9,10))

cat("Totale:", nrow(w21), "\n")
print(table(w21$data_source))
print(table(w21$firstpre))

cat("\n--- DETTAGLIO ---\n")
print(w21[, c("numloc","data_source","whendisc","firstpre", "type")])

############################################################
# 24) malfo5 compilato & sp_malfo5 vuoto
############################################################
cat("\n==============================\n")
cat("24) malfo5 compilato & sp_malfo5 vuoto\n")
cat("==============================\n")

w24 <- subset(eurocatData_test_Luca,
              !is.na(malfo5) &
                (is.na(sp_malfo5) | sp_malfo5==""))

cat("Totale:", nrow(w24), "\n")
print(table(w24$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w24[, c("numloc","data_source","malfo4","malfo5","sp_malfo5")])


############################################################
# 25) malfo2 compilato & sp_malfo2 vuoto
############################################################
cat("\n==============================\n")
cat("25) malfo2 compilato & sp_malfo2 vuoto\n")
cat("==============================\n")

w25 <- subset(eurocatData_test_Luca,
              !is.na(malfo2) &
                (is.na(sp_malfo2) | sp_malfo2==""))

cat("Totale:", nrow(w25), "\n")
print(table(w25$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w25[, c("numloc","data_source","malfo2","sp_malfo2", "malfo1", "sp_malfo1")])


############################################################
# 26) firstpre 6/11 & karyo=3
############################################################
cat("\n==============================\n")
cat("26) firstpre 6/11 & karyo=3\n")
cat("==============================\n")

w26 <- subset(eurocatData_test_Luca,
              firstpre %in% c(6,11) & karyo==3)

cat("Totale:", nrow(w26), "\n")
print(table(w26$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w26[, c("numloc","data_source",
              "firstpre","karyo","gentest","type", "whendisc")])


############################################################
# 27) karyo=1 & sp_karyo vuoto
############################################################
cat("\n==============================\n")
cat("27) karyo=1 & sp_karyo vuoto\n")
cat("==============================\n")

w27 <- subset(eurocatData_test_Luca,
              karyo==1 & (is.na(sp_karyo) | sp_karyo==""))

cat("Totale:", nrow(w27), "\n")
print(table(w27$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w27[, c("numloc","data_source","karyo","sp_karyo")])

############################################################
# 28) type=4 & whendisc !=6
############################################################
cat("\n==============================\n")
cat("28) type=4 & whendisc !=6\n")
cat("==============================\n")

w28 <- subset(eurocatData_test_Luca,
              type==4 & whendisc !=6)

cat("Totale:", nrow(w28), "\n")
print(table(w28$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w28[, c("pm","data_source","type","whendisc","death_date")])


############################################################
# 29) nbrbaby=2 & nbrmalf=2 & prevsib 
############################################################
cat("\n==============================\n")
cat("29) nbrbaby=2 & nbrmalf=2 & prevsib \n")
cat("==============================\n")

w29 <- subset(eurocatData_test_Luca,
              nbrbaby==2 & nbrmalf=="2" &
                (is.na(prevsib) | prevsib!=1))

cat("Totale:", nrow(w29), "\n")
print(table(w29$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w29[, c("numloc","data_source",
              "nbrbaby","nbrmalf","prevsib")])

############################################################
# 30) nbrbaby>1 & nbrmalf >= nbrbaby
############################################################
cat("\n==============================\n")
cat("30) nbrbaby>1 & nbrmalf >= nbrbaby\n")
cat("==============================\n")

nbrmalf_num <- suppressWarnings(as.numeric(eurocatData_test_Luca$nbrmalf))

w30 <- subset(eurocatData_test_Luca,
              nbrbaby > 1 & nbrbaby < 8 &
                !is.na(nbrmalf_num) &
                nbrmalf_num > nbrbaby)

w30_text <- subset(eurocatData_test_Luca,
                   !is.na(nbrmalf) &
                     is.na(suppressWarnings(as.numeric(nbrmalf))))

cat("Valori non numerici in nbrmalf:", nrow(w30_text), "\n")

print(w30_text[, c("numloc","data_source","nbrbaby","nbrmalf")])

cat("Totale:", nrow(w30), "\n")
print(table(w30$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w30[, c("numloc","data_source","nbrbaby","nbrmalf")])


############################################################
# 32) firsttri 2/9 & drugs1 compilato
############################################################
cat("\n==============================\n")
cat("32) firsttri 2/9 & drugs1 compilato\n")
cat("==============================\n")

w32 <- subset(eurocatData_test_Luca,
              firsttri %in% c(2,9) &
                (!is.na(drugs1) | !is.na(drugs2) | !is.na(drugs3) |
                   !is.na(drugs4) | !is.na(drugs5) | !is.na(extra_drugs)))

cat("Totale:", nrow(w32), "\n")
print(table(w32$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w32[, c("numloc","data_source","firsttri","drugs1", "drugs2")])


############################################################
# 33) sex=3 & nessun Q56 nei malfo
############################################################
cat("\n==============================\n")
cat("33) sex=3 & nessun Q56 nei malfo\n")
cat("==============================\n")

w33 <- subset(eurocatData_test_Luca,
              sex==3 &
                !(grepl("^Q56", malfo1) |
                    grepl("^Q56", malfo2) |
                    grepl("^Q56", malfo3) |
                    grepl("^Q56", malfo4) |
                    grepl("^Q56", malfo5) |
                    grepl("^Q56", malfo6) |
                    grepl("^Q56", malfo7) |
                    grepl("^Q56", malfo8)))

cat("Totale:", nrow(w33), "\n")
print(table(w33$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w33[, c("numloc","data_source","sex",
              "malfo1","malfo2","malfo3","malfo4", "type")])

############################################################
# 34) agemo fuori range
############################################################
cat("\n==============================\n")
cat("34) agemo fuori range\n")
cat("==============================\n")

w34 <- subset(eurocatData_test_Luca,
              !is.na(agemo) & agemo!=99 &
                (agemo <10 | agemo >60))

cat("Totale:", nrow(w34), "\n")
print(table(w34$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w34[, c("numloc","data_source","agemo","totpreg")])


############################################################
# 35) faanom 1/2/3 & sp_faanom vuoto
############################################################
cat("\n==============================\n")
cat("35) faanom 1/2/3 & sp_faanom vuoto\n")
cat("==============================\n")

w35 <- subset(eurocatData_test_Luca,
              !is.na(faanom) &
                faanom %in% c(1,2,3) &
                (is.na(sp_faanom) | sp_faanom==""))

cat("Totale:", nrow(w35), "\n")
print(table(w35$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w35[, c("numloc","data_source","faanom","sp_faanom")])


############################################################
# 36) illdur1 lunghezza >4
############################################################
cat("\n==============================\n")
cat("36) illdur1 lunghezza >4\n")
cat("==============================\n")

w36 <- subset(eurocatData_test_Luca,
              !is.na(illdur1) & illdur1!="" &
                nchar(illdur1) >4)

cat("Totale:", nrow(w36), "\n")
print(table(w36$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w36[, c("numloc","data_source","illdur1")])


############################################################
# 37) malfo1 compilato & sp_malfo1 vuoto
############################################################
cat("\n==============================\n")
cat("37) malfo1 compilato & sp_malfo1 vuoto\n")
cat("==============================\n")

w37 <- subset(eurocatData_test_Luca,
              !is.na(malfo1) &
                (is.na(sp_malfo1) | sp_malfo1==""))

cat("Totale:", nrow(w37), "\n")
print(table(w37$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w37[, c("numloc","data_source","malfo1","sp_malfo1", "syndrome")])

############################################################
# 38) bmi fuori range
############################################################
cat("\n==============================\n")
cat("38) bmi fuori range\n")
cat("==============================\n")

w38 <- subset(eurocatData_test_Luca,
              !is.na(bmi) &
                !bmi %in% c(99) &
                (bmi <15 | bmi >50))

cat("Totale:", nrow(w38), "\n")
print(table(w38$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w38[, c("numloc","data_source","bmi")])



############################################################
# 38) type==1, pm fatto, death_date =NA
############################################################
cat("\n==============================\n")
cat("39) type=1 e pm fatto\n")
cat("==============================\n")

w39 <- subset(eurocatData_test_Luca,
              type == 1 & pm %in% c(1,2,4) & !is.na(death_date))

cat("Totale:", nrow(w39), "\n")
print(table(w39$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w39[, c("numloc","data_source","type","death_date", "pm")])




library(dplyr)
library(purrr)
library(readr)
library(rlang)



#Data import

wd <- "~/Desktop/git_hub/DARIO"
setwd(wd)

eurocatData_test_Luca <- read_csv2(
  paste0(wd,"/export/eurocatData.csv"),
  col_types = cols(
    birth_date = col_character(),
    death_date = col_character(),
    datemo     = col_character()
  )
)
eurocatData_test_Luca <- eurocatData_test_Luca %>%
  rename(residmo = resmo)




############################################################
# 1) OMIM NON NA & SYNDROME NA
############################################################
cat("\n==============================\n")
cat("1) OMIM NON NA & SYNDROME NA\n")
cat("==============================\n")

w1 <- subset(eurocatData_test_Luca,
             !is.na(omim) & is.na(syndrome))

cat("Totale:", nrow(w1), "\n")
print(table(w1$data_source))
print(table(w1$omim))

cat("\n--- DETTAGLIO ---\n")
print(w1[, c("numloc","data_source","omim","syndrome", "presyn", "malfo1")])


############################################################
# 2) firstpre=(1:7,11) & presyn != 1
############################################################
cat("\n==============================\n")
cat("2) firstpre=(1:7,11) & presyn != 1\n")
cat("==============================\n")

w2 <- subset(eurocatData_test_Luca,
             firstpre %in% c(1:7,11) & presyn != 1)

w2 |> select(type,firstpre, presyn )

cat("Totale:", nrow(w2), "\n")
print(table(w2$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w2[, c("numloc","data_source","syndrome","firstpre", "presyn")])

############################################################
# 3) whendisc=6 & presyn !=1 | PREMAL1:8 !=1
############################################################
cat("\n==============================\n")
cat("3) whendisc=6 & presyn !=1 & syndrome not NA\n")
cat("==============================\n")

w3 <- subset(eurocatData_test_Luca,
             whendisc == 6 & !(presyn == 1 |premal1 == 1 | premal2 == 1 | premal3 == 1 | premal4 == 1 | premal5 == 1 | premal6 == 1 | premal7 == 1 | premal8 == 1))

cat("Totale:", nrow(w3), "\n")
print(table(w3$data_source))
print(table(w3$presyn))

cat("\n--- DETTAGLIO ---\n")
print(w3[, c("numloc","data_source","whendisc","presyn","premal1","premal2", "premal3", "premal4", "premal5", "premal6","premal7","premal8")])


############################################################
# 5) firstpre 1-2 & gestlength <22
############################################################
cat("\n==============================\n")
cat("5) firstpre 1-2 & gestlength <22\n")
cat("==============================\n")

w5 <- subset(eurocatData_test_Luca,
             firstpre %in% c(1,2) & !is.na(gestlength) & gestlength >= 22)

cat("Totale:", nrow(w5), "\n")
print(table(w5$data_source))
print(table(w5$firstpre, w5$gestlength))

cat("\n--- DETTAGLIO ---\n")
print(w5[, c("numloc","data_source","firstpre","gestlength","type","whendisc")])



############################################################
# 8) firstpre 1:7,11 & nessun premal=1
############################################################
cat("\n==============================\n")
cat("8) firstpre 1:7,11 & nessun premal=1\n")
cat("==============================\n")

w8 <- subset(eurocatData_test_Luca,
             firstpre %in% c(1:7,11) &
               !(premal1 == 1 | premal2 == 1 | premal3 == 1 |
                   premal4 == 1 | premal5 == 1 | premal6 == 1 |
                   premal7 == 1 | premal8 == 1))

cat("Totale:", nrow(w8), "\n")
print(table(w8$data_source))
print(table(w8$firstpre))

cat("\n--- DETTAGLIO ---\n")
print(w8[, c("numloc","data_source",
             "firstpre",
             paste0("premal",1:8),"presyn", "whendisc", "type")])

############################################################
# 9) presyn=1 & karyo=3 & gentest=3
############################################################
cat("\n==============================\n")
cat("9) presyn=1 & karyo=3 & gentest=3\n")
cat("==============================\n")

w9 <- subset(eurocatData_test_Luca,
             presyn==1 & karyo==3 & gentest==3)

cat("Totale:", nrow(w9), "\n")
print(table(w9$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w9[, c("numloc","data_source",
             "presyn","karyo","gentest","firstpre", "type", "syndrome", "gestlength")])

############################################################
# 10) consang=1 & sp_consang vuoto
############################################################
cat("\n==============================\n")
cat("10) consang=1 & sp_consang vuoto\n")
cat("==============================\n")

w10 <- subset(eurocatData_test_Luca,
              consang==1 & (is.na(sp_consang) | sp_consang==""))

cat("Totale:", nrow(w10), "\n")
print(table(w10$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w10[, c("numloc","data_source","consang","sp_consang")])

############################################################
# 11) whendisc=6 & condisc !=1
############################################################
cat("\n==============================\n")
cat("11) whendisc=6 & condisc !=1\n")
cat("==============================\n")

w11 <- subset(eurocatData_test_Luca,
              whendisc==6 & condisc!=1)

cat("Totale:", nrow(w11), "\n")
print(table(w11$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w11[, c("numloc","data_source",
              "whendisc","condisc","firstpre","presyn", "type")])

############################################################
# 12) sex=9 & pm non 3/4/9
############################################################
cat("\n==============================\n")
cat("12) sex=9 & pm non 3/4/9\n")
cat("==============================\n")

w12 <- subset(eurocatData_test_Luca,
              sex==9 & !(pm %in% c(3,4,9)))

cat("Totale:", nrow(w12), "\n")
print(table(w12$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w12[, c("numloc","data_source","sex","pm","type")])

############################################################
# 13) type=4 & presyn=2
############################################################
cat("\n==============================\n")
cat("13) type=4 & presyn=2\n")
cat("==============================\n")

w13 <- subset(eurocatData_test_Luca,
              type==4 & presyn==2)

cat("Totale:", nrow(w13), "\n")
print(table(w13$data_source))
print(table(w13$type, w13$presyn))

cat("\n--- DETTAGLIO CASI ---\n")

print(
  w13[, c("numloc",
          "data_source",
          "type",
          "presyn",
          "syndrome",
          "malfo1","malfo2",
          "premal1","premal2")]
)

############################################################
# 14) type=4 & survival è 1/3/9
############################################################
cat("\n==============================\n")
cat("14) type=4 & survival non 1/3/9\n")
cat("==============================\n")

w14 <- subset(eurocatData_test_Luca,
              type==4 & (survival %in% c(1,3,9)))

cat("Totale:", nrow(w14), "\n")
print(table(w14$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w14[, c("numloc","data_source",
              "type","survival","whendisc")])

############################################################
# 15) totpreg fuori dominio
############################################################
cat("\n==============================\n")
cat("15) totpreg fuori dominio\n")
cat("==============================\n")

w15 <- subset(eurocatData_test_Luca,
              !is.na(totpreg) &
                !(totpreg %in% c("0","1","2","3","4","5","6","7","8","9",
                                 "10","11","12","13","14","15","16",
                                 "17","18","19","20","99")))

cat("Totale:", nrow(w15), "\n")
print(table(w15$data_source))
print(table(w15$totpreg))

cat("\n--- DETTAGLIO ---\n")
print(w15[, c("numloc","data_source","agemo","totpreg")])


############################################################
# 17) nbrbaby>=2 & sp_twin NA
############################################################
cat("\n==============================\n")
cat("17) nbrbaby>=2 & sp_twin NA\n")
cat("==============================\n")

w17 <- subset(eurocatData_test_Luca,
              nbrbaby >=2 & is.na(sp_twin))

cat("Totale:", nrow(w17), "\n")
print(table(w17$data_source))
print(table(w17$nbrbaby))

cat("\n--- DETTAGLIO ---\n")
print(w17[, c("numloc","data_source","nbrbaby","sp_twin", "totpreg", "whendisc")])

############################################################
# 19) whendisc=6 & premal3 non 2/9
############################################################
cat("\n==============================\n")
cat("19) whendisc=6 & premal3 non 2/9\n")
cat("==============================\n")

w19 <- subset(eurocatData_test_Luca,
              whendisc==6 & !(premal3 %in% c(2,9)))

cat("Totale:", nrow(w19), "\n")
print(table(w19$data_source))
print(table(w19$premal3))

cat("\n--- DETTAGLIO ---\n")
print(w19[, c("numloc","data_source","whendisc","premal3", "type", "malfo3", "malfo2", "malfo1")])

############################################################
# 20) premal1-8=1 & karyo=3 & gentest=3
############################################################
cat("\n==============================\n")
cat("20) premal1-8=1 & karyo=3 & gentest=3\n")
cat("==============================\n")

w20 <- subset(eurocatData_test_Luca,
              (premal1==1 | premal2==1 | premal3==1 | premal4==1 |
                 premal5==1 | premal6==1 | premal7==1 | premal8==1) &
                karyo==3 & gentest==3)

cat("Totale:", nrow(w20), "\n")
print(table(w20$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w20[, c("numloc","data_source",
              "premal1","premal2","premal3","premal4",
              "premal5","premal6","premal7","premal8",
              "karyo","gentest","malfo2","whendisc","type")])


############################################################
# 21) whendisc=6 & firstpre 8/9/10
############################################################
cat("\n==============================\n")
cat("21) whendisc=6 & firstpre 8/9/10\n")
cat("==============================\n")

w21 <- subset(eurocatData_test_Luca,
              whendisc==6 & firstpre %in% c(8,9,10))

cat("Totale:", nrow(w21), "\n")
print(table(w21$data_source))
print(table(w21$firstpre))

cat("\n--- DETTAGLIO ---\n")
print(w21[, c("numloc","data_source","whendisc","firstpre", "type")])

############################################################
# 24) malfo5 compilato & sp_malfo5 vuoto
############################################################
cat("\n==============================\n")
cat("24) malfo5 compilato & sp_malfo5 vuoto\n")
cat("==============================\n")

w24 <- subset(eurocatData_test_Luca,
              !is.na(malfo5) &
                (is.na(sp_malfo5) | sp_malfo5==""))

cat("Totale:", nrow(w24), "\n")
print(table(w24$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w24[, c("numloc","data_source","malfo4","malfo5","sp_malfo5")])


############################################################
# 25) malfo2 compilato & sp_malfo2 vuoto
############################################################
cat("\n==============================\n")
cat("25) malfo2 compilato & sp_malfo2 vuoto\n")
cat("==============================\n")

w25 <- subset(eurocatData_test_Luca,
              !is.na(malfo2) &
                (is.na(sp_malfo2) | sp_malfo2==""))

cat("Totale:", nrow(w25), "\n")
print(table(w25$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w25[, c("numloc","data_source","malfo2","sp_malfo2", "malfo1", "sp_malfo1")])


############################################################
# 26) firstpre 6/11 & karyo=3
############################################################
cat("\n==============================\n")
cat("26) firstpre 6/11 & karyo=3\n")
cat("==============================\n")

w26 <- subset(eurocatData_test_Luca,
              firstpre %in% c(6,11) & karyo==3)

cat("Totale:", nrow(w26), "\n")
print(table(w26$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w26[, c("numloc","data_source",
              "firstpre","karyo","gentest","type", "whendisc")])


############################################################
# 27) karyo=1 & sp_karyo vuoto
############################################################
cat("\n==============================\n")
cat("27) karyo=1 & sp_karyo vuoto\n")
cat("==============================\n")

w27 <- subset(eurocatData_test_Luca,
              karyo==1 & (is.na(sp_karyo) | sp_karyo==""))

cat("Totale:", nrow(w27), "\n")
print(table(w27$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w27[, c("numloc","data_source","karyo","sp_karyo")])

############################################################
# 28) type=4 & whendisc !=6
############################################################
cat("\n==============================\n")
cat("28) type=4 & whendisc !=6\n")
cat("==============================\n")

w28 <- subset(eurocatData_test_Luca,
              type==4 & whendisc !=6)

cat("Totale:", nrow(w28), "\n")
print(table(w28$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w28[, c("pm","data_source","type","whendisc","death_date")])


############################################################
# 29) nbrbaby=2 & nbrmalf=2 & prevsib 
############################################################
cat("\n==============================\n")
cat("29) nbrbaby=2 & nbrmalf=2 & prevsib \n")
cat("==============================\n")

w29 <- subset(eurocatData_test_Luca,
              nbrbaby==2 & nbrmalf=="2" &
                (is.na(prevsib) | prevsib!=1))

cat("Totale:", nrow(w29), "\n")
print(table(w29$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w29[, c("numloc","data_source",
              "nbrbaby","nbrmalf","prevsib")])

############################################################
# 30) nbrbaby>1 & nbrmalf >= nbrbaby
############################################################
cat("\n==============================\n")
cat("30) nbrbaby>1 & nbrmalf >= nbrbaby\n")
cat("==============================\n")

nbrmalf_num <- suppressWarnings(as.numeric(eurocatData_test_Luca$nbrmalf))

w30 <- subset(eurocatData_test_Luca,
              nbrbaby > 1 & nbrbaby < 8 &
                !is.na(nbrmalf_num) &
                nbrmalf_num > nbrbaby)

w30_text <- subset(eurocatData_test_Luca,
                   !is.na(nbrmalf) &
                     is.na(suppressWarnings(as.numeric(nbrmalf))))

cat("Valori non numerici in nbrmalf:", nrow(w30_text), "\n")

print(w30_text[, c("numloc","data_source","nbrbaby","nbrmalf")])

cat("Totale:", nrow(w30), "\n")
print(table(w30$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w30[, c("numloc","data_source","nbrbaby","nbrmalf")])


############################################################
# 32) firsttri 2/9 & drugs1 compilato
############################################################
cat("\n==============================\n")
cat("32) firsttri 2/9 & drugs1 compilato\n")
cat("==============================\n")

w32 <- subset(eurocatData_test_Luca,
              firsttri %in% c(2,9) &
                (!is.na(drugs1) | !is.na(drugs2) | !is.na(drugs3) |
                   !is.na(drugs4) | !is.na(drugs5) | !is.na(extra_drugs)))

cat("Totale:", nrow(w32), "\n")
print(table(w32$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w32[, c("numloc","data_source","firsttri","drugs1", "drugs2")])


############################################################
# 33) sex=3 & nessun Q56 nei malfo
############################################################
cat("\n==============================\n")
cat("33) sex=3 & nessun Q56 nei malfo\n")
cat("==============================\n")

w33 <- subset(eurocatData_test_Luca,
              sex==3 &
                !(grepl("^Q56", malfo1) |
                    grepl("^Q56", malfo2) |
                    grepl("^Q56", malfo3) |
                    grepl("^Q56", malfo4) |
                    grepl("^Q56", malfo5) |
                    grepl("^Q56", malfo6) |
                    grepl("^Q56", malfo7) |
                    grepl("^Q56", malfo8)))

cat("Totale:", nrow(w33), "\n")
print(table(w33$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w33[, c("numloc","data_source","sex",
              "malfo1","malfo2","malfo3","malfo4", "type")])

############################################################
# 34) agemo fuori range
############################################################
cat("\n==============================\n")
cat("34) agemo fuori range\n")
cat("==============================\n")

w34 <- subset(eurocatData_test_Luca,
              !is.na(agemo) & agemo!=99 &
                (agemo <10 | agemo >60))

cat("Totale:", nrow(w34), "\n")
print(table(w34$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w34[, c("numloc","data_source","agemo","totpreg")])


############################################################
# 35) faanom 1/2/3 & sp_faanom vuoto
############################################################
cat("\n==============================\n")
cat("35) faanom 1/2/3 & sp_faanom vuoto\n")
cat("==============================\n")

w35 <- subset(eurocatData_test_Luca,
              !is.na(faanom) &
                faanom %in% c(1,2,3) &
                (is.na(sp_faanom) | sp_faanom==""))

cat("Totale:", nrow(w35), "\n")
print(table(w35$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w35[, c("numloc","data_source","faanom","sp_faanom")])


############################################################
# 36) illdur1 lunghezza >4
############################################################
cat("\n==============================\n")
cat("36) illdur1 lunghezza >4\n")
cat("==============================\n")

w36 <- subset(eurocatData_test_Luca,
              !is.na(illdur1) & illdur1!="" &
                nchar(illdur1) >4)

cat("Totale:", nrow(w36), "\n")
print(table(w36$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w36[, c("numloc","data_source","illdur1")])


############################################################
# 37) malfo1 compilato & sp_malfo1 vuoto
############################################################
cat("\n==============================\n")
cat("37) malfo1 compilato & sp_malfo1 vuoto\n")
cat("==============================\n")

w37 <- subset(eurocatData_test_Luca,
              !is.na(malfo1) &
                (is.na(sp_malfo1) | sp_malfo1==""))

cat("Totale:", nrow(w37), "\n")
print(table(w37$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w37[, c("numloc","data_source","malfo1","sp_malfo1", "syndrome")])

############################################################
# 38) bmi fuori range
############################################################
cat("\n==============================\n")
cat("38) bmi fuori range\n")
cat("==============================\n")

w38 <- subset(eurocatData_test_Luca,
              !is.na(bmi) &
                !bmi %in% c(99) &
                (bmi <15 | bmi >50))

cat("Totale:", nrow(w38), "\n")
print(table(w38$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w38[, c("numloc","data_source","bmi")])



############################################################
# 38) type==1, pm fatto, death_date =NA
############################################################
cat("\n==============================\n")
cat("39) type=1 e pm fatto\n")
cat("==============================\n")

w39 <- subset(eurocatData_test_Luca,
              type == 1 & pm %in% c(1,2,4) & !is.na(death_date))

cat("Totale:", nrow(w39), "\n")
print(table(w39$data_source))

cat("\n--- DETTAGLIO ---\n")
print(w39[, c("numloc","data_source","type","death_date", "pm")])




#salva in un html ----

descriptions <- list(
  s1  = "omim NON NA & syndrome NA",
  s2  = "firstpre ∈ {1:7,11} & presyn != 1",
  s3  = "whendisc = 6 & nessun premal1:8 = 1 & presyn != 1",
  s5  = "firstpre ∈ {1,2} & gestlength >= 22",
  s8  = "firstpre ∈ {1:7,11} & nessun premal1:8 = 1",
  s9  = "presyn = 1 & karyo = 3 & gentest = 3",
  s10 = "consang = 1 & sp_consang vuoto",
  s11 = "whendisc = 6 & condisc != 1",
  s12 = "sex = 9 & pm non ∈ {3,4,9}",
  s13 = "type = 4 & presyn = 2",
  s14 = "type = 4 & survival ∈ {1,3,9}",
  s15 = "totpreg fuori dominio",
  s17 = "nbrbaby >= 2 & sp_twin NA",
  s19 = "whendisc = 6 & premal3 non ∈ {2,9}",
  s20 = "premal1:8 = 1 & karyo = 3 & gentest = 3",
  s21 = "whendisc = 6 & firstpre ∈ {8,9,10}",
  s24 = "malfo5 compilato & sp_malfo5 vuoto",
  s25 = "malfo2 compilato & sp_malfo2 vuoto",
  s26 = "firstpre ∈ {6,11} & karyo = 3",
  s27 = "karyo = 1 & sp_karyo vuoto",
  s28 = "type = 4 & whendisc != 6",
  s29 = "nbrbaby = 2 & nbrmalf = 2 & prevsib != 1",
  s30 = "nbrbaby > 1 & nbrmalf > nbrbaby",
  s32 = "firsttri ∈ {2,9} & drugs compilati",
  s33 = "sex = 3 & nessun codice Q56 nei malfo",
  s34 = "agemo fuori range (10–60)",
  s35 = "faanom ∈ {1,2,3} & sp_faanom vuoto",
  s36 = "illdur1 lunghezza > 4",
  s37 = "malfo1 compilato & sp_malfo1 vuoto",
  s38 = "bmi fuori range (15–50)",
  s39 = "type = 1 & pm fatto & death_date presente"
)

sections <- list(
  s1 = list(title = "1) OMIM", data = w1),
  s2 = list(title = "2) firstpre", data = w2),
  s3 = list(title = "3) whendisc", data = w3),
  s5 = list(title = "5) gestlength", data = w5),
  s8 = list(title = "8) premal", data = w8),
  s9 = list(title = "9) presyn/karyo", data = w9),
  s10 = list(title = "10) consang", data = w10),
  s11 = list(title = "11) condisc", data = w11),
  s12 = list(title = "12) sex", data = w12),
  s13 = list(title = "13) type", data = w13),
  s14 = list(title = "14) survival", data = w14),
  s15 = list(title = "15) totpreg", data = w15),
  s17 = list(title = "17) twin", data = w17),
  s19 = list(title = "19) premal3", data = w19),
  s20 = list(title = "20) premal", data = w20),
  s21 = list(title = "21) firstpre", data = w21),
  s24 = list(title = "24) malfo5", data = w24),
  s25 = list(title = "25) malfo2", data = w25),
  s26 = list(title = "26) karyo", data = w26),
  s27 = list(title = "27) sp_karyo", data = w27),
  s28 = list(title = "28) whendisc", data = w28),
  s29 = list(title = "29) prevsib", data = w29),
  s30 = list(title = "30) nbrmalf", data = w30),
  s32 = list(title = "32) drugs", data = w32),
  s33 = list(title = "33) Q56", data = w33),
  s34 = list(title = "34) agemo", data = w34),
  s35 = list(title = "35) faanom", data = w35),
  s36 = list(title = "36) illdur1", data = w36),
  s37 = list(title = "37) malfo1", data = w37),
  s38 = list(title = "38) bmi", data = w38),
  s39 = list(title = "39) pm", data = w39)
)

add_section_html <- function(id, title, data, description){
  
  n <- nrow(data)
  
  # tabella HTML (solo se ci sono righe)
  table_html <- if(n > 0){
    tags$table(
      border = 1,
      style = "border-collapse: collapse; font-size:12px;",
      
      tags$thead(
        tags$tr(
          lapply(names(data), function(col){
            tags$th(col, style="padding:4px; background:#f0f0f0;")
          })
        )
      ),
      
      tags$tbody(
        lapply(seq_len(n), function(i){
          tags$tr(
            lapply(data[i, ], function(x){
              tags$td(as.character(x), style="padding:4px;")
            })
          )
        })
      )
    )
    
  } else {
    tags$p("Nessun record trovato", style="color:green;")
  }
  
  # blocco sezione
  tags$div(
    id = id,
    style = "margin-bottom:40px;",
    
    tags$h2(title),
    
    tags$p(
      tags$b("Descrizione: "), description
    ),
    
    tags$p(
      tags$b("Totale casi: "), n
    ),
    
    table_html,
    
    tags$hr()
  )
}

index <- tags$div(
  style = "position:fixed; left:0; top:0; width:250px; height:100%; overflow:auto; background:#f7f7f7; padding:10px;",
  
  tags$h3("Indice"),
  
  lapply(names(sections), function(id){
    tags$p(
      tags$a(href = paste0("#", id), sections[[id]]$title)
    )
  })
)

report_sections <- lapply(names(sections), function(id){
  
  sec <- sections[[id]]
  
  add_section_html(
    id = id,
    title = sec$title,
    data = sec$data,
    description = descriptions[[id]]
  )
})

report <- tagList(
  
  tags$head(
    tags$style(HTML("
      body { margin-left: 280px; font-family: Arial; }
    "))
  ),
  
  index,
  
  tags$h1("Report Controlli Qualità EUROCAT"),
  
  !!!report_sections   
)

save_html(report, file = "report_controlli.html")
browseURL("report_controlli.html")


