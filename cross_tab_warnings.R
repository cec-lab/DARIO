rm(list = ls())

baseDir=getwd()
source(paste0(baseDir,"/config.R"), echo = T)
source(paste0(baseDir,"/functions.R"), echo = T)

############################################################
# ===== DATA IMPORT =====
############################################################

wd <- "/home/imer/works/DI/coorti/2024/DARIO-DARIOv1.0.1"
setwd(wd)

eurocatData_test_Luca <- read_csv2(
  paste0(wd,"/export/eurocatData.csv"),
  col_types = cols(
    birth_date = col_character(),
    death_date = col_character(),
    datemo     = col_character()
  )
)

eurocatData_test_Luca <- transcode_complete(eurocatData_test_Luca,eurocat_vars_list)

eurocatData_test_Luca <- eurocatData_test_Luca %>%
  rename(residmo = resmo)

############################################################
# ===== WARNING DATASET =====
############################################################

#----------------------------------------------------------
# W1
#----------------------------------------------------------
w1 <- subset(
  eurocatData_test_Luca,
  !is.na(omim) & is.na(syndrome)
)

#----------------------------------------------------------
# W2
#----------------------------------------------------------
w2 <- subset(
  eurocatData_test_Luca,
  firstpre %in% c(1:7,11) & presyn != 1
)

#----------------------------------------------------------
# W3
#----------------------------------------------------------
w3 <- subset(
  eurocatData_test_Luca,
  whendisc == 6 &
    !(presyn == 1 |
        premal1 == 1 |
        premal2 == 1 |
        premal3 == 1 |
        premal4 == 1 |
        premal5 == 1 |
        premal6 == 1 |
        premal7 == 1 |
        premal8 == 1)
)

#----------------------------------------------------------
# W5
#----------------------------------------------------------
w5 <- subset(
  eurocatData_test_Luca,
  firstpre %in% c(1,2) &
    !is.na(gestlength) &
    gestlength >= 22
)

#----------------------------------------------------------
# W8
#----------------------------------------------------------
w8 <- subset(
  eurocatData_test_Luca,
  firstpre %in% c(1:7,11) &
    !(premal1 == 1 |
        premal2 == 1 |
        premal3 == 1 |
        premal4 == 1 |
        premal5 == 1 |
        premal6 == 1 |
        premal7 == 1 |
        premal8 == 1)
)

#----------------------------------------------------------
# W9
#----------------------------------------------------------
w9 <- subset(
  eurocatData_test_Luca,
  presyn == 1 &
    karyo == 3 &
    gentest == 3
)

#----------------------------------------------------------
# W10
#----------------------------------------------------------
w10 <- subset(
  eurocatData_test_Luca,
  consang == 1 &
    (is.na(sp_consang) | sp_consang == "")
)

#----------------------------------------------------------
# W11
#----------------------------------------------------------
w11 <- subset(
  eurocatData_test_Luca,
  whendisc == 6 &
    condisc != 1
)

#----------------------------------------------------------
# W12
#----------------------------------------------------------
w12 <- subset(
  eurocatData_test_Luca,
  sex == 9 &
    !(pm %in% c(3,4,9))
)

#----------------------------------------------------------
# W13
#----------------------------------------------------------
w13 <- subset(
  eurocatData_test_Luca,
  type == 4 &
    presyn == 2
)

#----------------------------------------------------------
# W14
#----------------------------------------------------------
w14 <- subset(
  eurocatData_test_Luca,
  type == 4 &
    survival %in% c(1,3,9)
)

#----------------------------------------------------------
# W15
#----------------------------------------------------------
w15 <- subset(
  eurocatData_test_Luca,
  !is.na(totpreg) &
    !(totpreg %in% c(
      "0","01","02","03","04","05","06","07","08","09",
      "10","11","12","13","14","15","16",
      "17","18","19","20","99"
    ))
)

#----------------------------------------------------------
# W17
#----------------------------------------------------------
w17 <- subset(
  eurocatData_test_Luca,
  nbrbaby >= 2 &
    is.na(sp_twin)
)

#----------------------------------------------------------
# W19
#----------------------------------------------------------
w19 <- subset(
  eurocatData_test_Luca,
  whendisc == 6 &
    !(premal3 %in% c(2,9))
)

#----------------------------------------------------------
# W20
#----------------------------------------------------------
w20 <- subset(
  eurocatData_test_Luca,
  (
    premal1 == 1 |
      premal2 == 1 |
      premal3 == 1 |
      premal4 == 1 |
      premal5 == 1 |
      premal6 == 1 |
      premal7 == 1 |
      premal8 == 1
  ) &
    karyo == 3 &
    gentest == 3
)

#----------------------------------------------------------
# W21
#----------------------------------------------------------
w21 <- subset(
  eurocatData_test_Luca,
  whendisc == 6 &
    firstpre %in% c(8,9,10)
)

#----------------------------------------------------------
# W24
#----------------------------------------------------------
w24 <- subset(
  eurocatData_test_Luca,
  !is.na(malfo5) &
    (is.na(sp_malfo5) | sp_malfo5 == "")
)

#----------------------------------------------------------
# W25
#----------------------------------------------------------
w25 <- subset(
  eurocatData_test_Luca,
  !is.na(malfo2) &
    (is.na(sp_malfo2) | sp_malfo2 == "")
)

#----------------------------------------------------------
# W26
#----------------------------------------------------------
w26 <- subset(
  eurocatData_test_Luca,
  firstpre %in% c(6,11) &
    karyo == 3
)

#----------------------------------------------------------
# W27
#----------------------------------------------------------
w27 <- subset(
  eurocatData_test_Luca,
  karyo == 1 &
    (is.na(sp_karyo) | sp_karyo == "")
)

#----------------------------------------------------------
# W28
#----------------------------------------------------------
w28 <- subset(
  eurocatData_test_Luca,
  type == 4 &
    whendisc != 6
)

#----------------------------------------------------------
# W29
#----------------------------------------------------------
w29 <- subset(
  eurocatData_test_Luca,
  nbrbaby == 2 &
    nbrmalf == "2" &
    (is.na(prevsib) | prevsib != 1)
)

#----------------------------------------------------------
# W30
#----------------------------------------------------------
nbrmalf_num <- suppressWarnings(
  as.numeric(eurocatData_test_Luca$nbrmalf)
)

w30 <- subset(
  eurocatData_test_Luca,
  nbrbaby > 1 &
    nbrbaby < 8 &
    !is.na(nbrmalf_num) &
    nbrmalf_num > nbrbaby
)

#----------------------------------------------------------
# W32
#----------------------------------------------------------
w32 <- subset(
  eurocatData_test_Luca,
  firsttri %in% c(2,9) &
    (
      !is.na(drugs1) |
        !is.na(drugs2) |
        !is.na(drugs3) |
        !is.na(drugs4) |
        !is.na(drugs5) |
        !is.na(extra_drugs)
    )
)

#----------------------------------------------------------
# W33
#----------------------------------------------------------
w33 <- subset(
  eurocatData_test_Luca,
  sex == 3 &
    !(
      grepl("^Q56", malfo1) |
        grepl("^Q56", malfo2) |
        grepl("^Q56", malfo3) |
        grepl("^Q56", malfo4) |
        grepl("^Q56", malfo5) |
        grepl("^Q56", malfo6) |
        grepl("^Q56", malfo7) |
        grepl("^Q56", malfo8)
    )
)

#----------------------------------------------------------
# W34
#----------------------------------------------------------
w34 <- subset(
  eurocatData_test_Luca,
  !is.na(agemo) &
    agemo != 99 &
    (agemo < 10 | agemo > 60)
)

#----------------------------------------------------------
# W35
#----------------------------------------------------------
w35 <- subset(
  eurocatData_test_Luca,
  !is.na(faanom) &
    faanom %in% c(1,2,3) &
    (is.na(sp_faanom) | sp_faanom == "")
)

#----------------------------------------------------------
# W36
#----------------------------------------------------------
w36 <- subset(
  eurocatData_test_Luca,
  !is.na(illdur1) &
    illdur1 != "" &
    nchar(illdur1) > 4
)

#----------------------------------------------------------
# W37
#----------------------------------------------------------
w37 <- subset(
  eurocatData_test_Luca,
  !is.na(malfo1) &
    (is.na(sp_malfo1) | sp_malfo1 == "")
)

#----------------------------------------------------------
# W38
#----------------------------------------------------------
w38 <- subset(
  eurocatData_test_Luca,
  !is.na(bmi) &
    bmi != 99 &
    (bmi < 15 | bmi > 50)
)

#----------------------------------------------------------
# W39
#----------------------------------------------------------
w39 <- subset(
  eurocatData_test_Luca,
  type == 1 &
    pm %in% c(1,2,4) &
    !is.na(death_date)
)


############################################################
# ===== REPORT HTML COMPLETO =====
############################################################

library(htmltools)
library(lubridate)
library(tidyr)

#-----------------------------
# 1) METADATI WARNING
#-----------------------------
meta <- list(
  w1  = list(title="Crosstab: omim × syndrome", cols=c("numloc","data_source","omim","syndrome")),
  w2  = list(title="Crosstab: firstpre × presyn", cols=c("numloc","data_source","firstpre","presyn")),
  w3  = list(title="Crosstab: whendisc × presyn × premal", cols=c("numloc","data_source","whendisc","presyn",paste0("premal",1:3))),
  w5  = list(title="Crosstab: firstpre × gestlength", cols=c("numloc","data_source","firstpre","gestlength")),
  w8  = list(title="Crosstab: firstpre × premal", cols=c("numloc","data_source","firstpre",paste0("premal",1:3))),
  w9  = list(title="Crosstab: presyn × karyo × gentest", cols=c("numloc","data_source","presyn","karyo","gentest")),
  w10 = list(title="Crosstab: consang × sp_consang", cols=c("numloc","data_source","consang","sp_consang")),
  w11 = list(title="Crosstab: whendisc × condisc", cols=c("numloc","data_source","whendisc","condisc")),
  w12 = list(title="Crosstab: sex × pm", cols=c("numloc","data_source","sex","pm")),
  w13 = list(title="Crosstab: type × presyn", cols=c("numloc","data_source","type","presyn")),
  w14 = list(title="Crosstab: type × survival", cols=c("numloc","data_source","type","survival")),
  w15 = list(title="Crosstab: totpreg", cols=c("numloc","data_source","totpreg")),
  w17 = list(title="Crosstab: nbrbaby × sp_twin", cols=c("numloc","data_source","nbrbaby","sp_twin")),
  w19 = list(title="Crosstab: whendisc × premal3", cols=c("numloc","data_source","whendisc","premal3")),
  w20 = list(title="Crosstab: premal × karyo × gentest", cols=c("numloc","data_source","karyo","gentest",paste0("premal",1:3))),
  w21 = list(title="Crosstab: whendisc × firstpre", cols=c("numloc","data_source","whendisc","firstpre")),
  w24 = list(title="Crosstab: malfo5 × sp_malfo5", cols=c("numloc","data_source","malfo5","sp_malfo5")),
  w25 = list(title="Crosstab: malfo2 × sp_malfo2", cols=c("numloc","data_source","malfo2","sp_malfo2")),
  w26 = list(title="Crosstab: firstpre × karyo", cols=c("numloc","data_source","firstpre","karyo")),
  w27 = list(title="Crosstab: karyo × sp_karyo", cols=c("numloc","data_source","karyo","sp_karyo")),
  w28 = list(title="Crosstab: type × whendisc", cols=c("numloc","data_source","type","whendisc")),
  w29 = list(title="Crosstab: nbrbaby × nbrmalf × prevsib", cols=c("numloc","data_source","nbrbaby","nbrmalf","prevsib")),
  w30 = list(title="Crosstab: nbrbaby × nbrmalf", cols=c("numloc","data_source","nbrbaby","nbrmalf")),
  w32 = list(title="Crosstab: firsttri × drugs", cols=c("numloc","data_source","firsttri","drugs1","drugs2")),
  w33 = list(title="Crosstab: sex × malfo", cols=c("numloc","data_source","sex","malfo1")),
  w34 = list(title="Crosstab: agemo", cols=c("numloc","data_source","agemo")),
  w35 = list(title="Crosstab: faanom × sp_faanom", cols=c("numloc","data_source","faanom","sp_faanom")),
  w36 = list(title="Crosstab: illdur1", cols=c("numloc","data_source","illdur1")),
  w37 = list(title="Crosstab: malfo1 × sp_malfo1", cols=c("numloc","data_source","malfo1","sp_malfo1")),
  w38 = list(title="Crosstab: bmi", cols=c("numloc","data_source","bmi")),
  w39 = list(title="Crosstab: type × pm × death_date", cols=c("numloc","data_source","type","pm","death_date"))
)

warnings_list <- mget(names(meta))  # prende w1...w39 automaticamente

#-----------------------------
# 2) FUNZIONE TABELLA
#-----------------------------
make_table <- function(df, max_rows = 100){
  
  if(nrow(df) == 0){
    return(tags$p("Nessun record", style="color:green"))
  }
  
  df <- head(df, max_rows)
  
  tags$table(
    border = 1,
    style="border-collapse:collapse; font-size:11px; width:100%;",
    
    tags$thead(tags$tr(lapply(names(df), tags$th))),
    
    tags$tbody(
      lapply(seq_len(nrow(df)), function(i){
        tags$tr(lapply(df[i,], function(x) tags$td(as.character(x))))
      })
    )
  )
}

#-----------------------------
# 3) SEZIONI WARNING
#-----------------------------
sections <- lapply(names(warnings_list), function(nome){
  
  df <- warnings_list[[nome]]
  info <- meta[[nome]]
  
  n <- nrow(df)
  colore <- if(n > 0) "red" else "green"
  
  cols <- intersect(info$cols, names(df))
  df_small <- df[, cols, drop=FALSE]
  
  tags$div(
    style="margin-bottom:50px;",
    
    tags$h2(info$title, style=paste0("color:", colore)),
    
    tags$p(tags$b("Warning: "), nome),
    tags$p(tags$b("Totale casi: "), n),
    
    tags$h4("Variabili rilevanti"),
    make_table(df_small),
    
    tags$h4("Dataset completo"),
    make_table(df, max_rows = 200),
    
    tags$hr()
  )
})

#-----------------------------
# 4) TABELLA SURVIVAL
#-----------------------------

df2 <- eurocatData_test_Luca %>%
  mutate(
    
    birth_date_clean = suppressWarnings(
      as.Date(birth_date, format = "%Y-%m-%d")
    ),
    
    death_date_clean = suppressWarnings(
      as.Date(death_date, format = "%Y-%m-%d")
    ),
    
    death_days = ifelse(
      !is.na(birth_date_clean) &
        !is.na(death_date_clean),
      
      as.numeric(death_date_clean - birth_date_clean),
      
      NA
    ),
    
    death_date_status = case_when(
      
      death_date == "" ~
        "Missing death date",
      
      death_date == "2222/22/22" ~
        "Alive at 1 year",
      
      death_date == "3333/33/33" ~
        "Unknown survival at 1 year",
      
      grepl("x", tolower(death_date)) ~
        "Incomplete death date",
      
      !is.na(death_date_clean) ~
        "Valid death date",
      
      TRUE ~
        "Invalid death date format"
    )
    
  )
###########################################################
# TABELLA COMPLETA
###########################################################

tab_surv <- df2 %>%
  select(
    numloc,
    data_source,
    survival,
    type,
    birth_date,
    death_date,
    death_days,
    death_date_status
  ) %>%
  arrange(
    survival,
    type,
    death_days
  )

###########################################################
# TABELLA RIASSUNTIVA
###########################################################

tab_surv_summary <- df2 %>%
  count(
    survival,
    type,
    death_date_status
  ) %>%
  pivot_wider(
    names_from  = death_date_status,
    values_from = n,
    values_fill = 0
  )


tab_surv_inconsistent <- df2 %>%
  filter(
    
    #######################################################
    # morto entro 1 settimana
    # ma death > 7 giorni
    #######################################################
    
    (
      survival == 2 &
        type == 1 &
        !is.na(death_days) &
        death_days > 7
    )
    
    |
      
      #######################################################
    # vivo oltre 1 settimana
    # ma morte entro 7 giorni
    #######################################################
    
    (
      survival == 1 &
        type == 1 &
        !is.na(death_days) &
        death_days <= 7
    )
    
    |
      
      #######################################################
    # vivo oltre 1 settimana
    # ma death date reale presente
    #######################################################
    
    (
      survival == 1 &
        type == 1 &
        death_date_status == "Valid death date" &
        death_days <= 365
    )
    
    |
      
      #######################################################
    # morto entro 1 settimana
    # ma placeholder vivo a 1 anno
    #######################################################
    
    (
      survival == 2 &
        type == 1 &
        death_date == "2222/22/22"
    )
    
    |
      
      #######################################################
    # survival ignoto
    # ma morte chiaramente documentata
    #######################################################
    
    (
      survival == 9 &
        type == 1 &
        !is.na(death_days)
    )
    
  ) %>%
  
  select(
    numloc,
    data_source,
    survival,
    type,
    birth_date,
    death_date,
    death_days,
    death_date_status
  ) %>%
  
  arrange(
    survival,
    death_days
  )


#-----------------------------
# 5) REPORT
#-----------------------------
report <- tagList(
  
  tags$head(
    tags$style(HTML("
      body { font-family: Arial; margin:20px; }
      table { width:100%; }
      h2 { margin-top:40px; }
    "))
  ),
  
  tags$h1("EUROCAT Quality Control Report"),
  
  #########################################################
  # SURVIVAL / DEATH DATE SECTION
  #########################################################
  
  tags$h2(
    "Consistency between survival status, case type and death date"
  ),
  
  tags$h4(
    "Summary of death date information by survival and case type"
  ),
  
  make_table(tab_surv_summary, max_rows = 200),
  
  tags$h4(
    "Detailed records"
  ),
  
  make_table(tab_surv, max_rows = 500),
  
  tags$h4(
    "Potential inconsistencies between survival and death date"
  ),
  
  make_table(tab_surv_inconsistent, max_rows = 200),
  
  tags$hr(),
  
  #########################################################
  # WARNING SECTIONS
  #########################################################
  
  sections
)

save_html(report, "report_controlli.html")

rstudioapi::viewer("report_controlli.html")

file.show("report_controlli.html")
