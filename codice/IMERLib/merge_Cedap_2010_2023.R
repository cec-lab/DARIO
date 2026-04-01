
rm(list=ls())

#lavoro unione Cedap dal 2010 al 2023
wd <- "/Users/luca/Library/CloudStorage/GoogleDrive-cmmlcu@unife.it/Drive condivisi/IMER/documenti/report/2025/tabelle_eurocat"

#Data import
Cedap2010 <- read_excel("~/Library/CloudStorage/GoogleDrive-cmmlcu@unife.it/Drive condivisi/IMER/database/Cedap/Cedap2010.xlsx")
Cedap2011 <- read_excel("~/Library/CloudStorage/GoogleDrive-cmmlcu@unife.it/Drive condivisi/IMER/database/Cedap/Cedap2011.xlsx")
Cedap2012 <- read_excel("~/Library/CloudStorage/GoogleDrive-cmmlcu@unife.it/Drive condivisi/IMER/database/Cedap/Cedap2012.xlsx")
Cedap2013 <- read_excel("~/Library/CloudStorage/GoogleDrive-cmmlcu@unife.it/Drive condivisi/IMER/database/Cedap/Cedap2013.xlsx")
Cedap2014 <- read_excel("~/Library/CloudStorage/GoogleDrive-cmmlcu@unife.it/Drive condivisi/IMER/database/Cedap/Cedap2014.xlsx")
Cedap2015 <- read_excel("~/Library/CloudStorage/GoogleDrive-cmmlcu@unife.it/Drive condivisi/IMER/database/Cedap/Cedap2015.xlsx")
Cedap2016 <- read.csv2("~/Library/CloudStorage/GoogleDrive-cmmlcu@unife.it/Drive condivisi/IMER/database/Cedap/Cedap2016.csv")
Cedap2017 <- read.csv2("~/Library/CloudStorage/GoogleDrive-cmmlcu@unife.it/Drive condivisi/IMER/database/Cedap/Cedap2017.csv")
Cedap2018 <- read.csv2("~/Library/CloudStorage/GoogleDrive-cmmlcu@unife.it/Drive condivisi/IMER/database/Cedap/Cedap2018.csv")
Cedap2019 <- read.csv2("~/Library/CloudStorage/GoogleDrive-cmmlcu@unife.it/Drive condivisi/IMER/database/Cedap/Cedap2019.csv")
Cedap2020 <- read.csv2("~/Library/CloudStorage/GoogleDrive-cmmlcu@unife.it/Drive condivisi/IMER/database/Cedap/Cedap2020.csv")
Cedap2021 <- read.csv2("~/Library/CloudStorage/GoogleDrive-cmmlcu@unife.it/Drive condivisi/IMER/database/Cedap/Cedap2021.csv")
Cedap2022 <- read_excel("~/Library/CloudStorage/GoogleDrive-cmmlcu@unife.it/Drive condivisi/IMER/database/Cedap/Cedap2022.xlsx")
cedap_plus_2023 <- read.csv2("~/Library/CloudStorage/GoogleDrive-cmmlcu@unife.it/Drive condivisi/IMER/database/Cedap/cedap_plus_2023.csv")

#Allineamento colonne con cedap_plus_2023

#2010
# elenco colonne 2010
col10 <- names(Cedap2010)
col23 <- names(cedap_plus_2023)

# ---- mapping manuale 2010 → 2023 ----
mapping_2010_2023 <- c(
  # Identificativi
  "prog_paz_neo" = "prog_paz",
  "COD_AZI" = "cod_azi",
  "COD_STAB" = "cod_stab",
  "SDO_NEO" = "sdo_neo",
  "COD_PRES" = "neonati10_cod_pres",
    
  # Anagrafica / evento
  "Sesso" = "genere",
  "VITALITA" = "vitalita",
  "dt_parto" = "dt_parto",
  "PESO" = "peso",
  "dt_nas_m" = "dt_nas_m",
  "CIRCONFERENZA_CRANICA" = "cfr_cran",
  
  # Neonati
  "nati_maschi" = "n_maschi",
  "nati_femmine" = "n_femmine",
  
  # Madre residenza e cittadinanza
  "CITTADINANZA_M" = "cittad_m",
  "comune_residenza_madre" = "com_res_m",
  
  # Gravidanza / ecografie / PMA
  "eta_gestazionale" = "eta_gest",
  "NUMERO_ECOGRAFIE" = "n_ecograf",
  "ABITUDINE_AL_FUMO" = "tabacco",
  "CONSANGUINEITA" = "consang",
  "metodi_PMA" = "procr_ass",
  "CONCEPIMENTI_PRECEDENTI" = "concep_pr",
  
  # Diagnosi e malformazioni
  "Malformazione_diagnosticata_1" = "cod_malf1",
  "Malformazione_diagnosticata_2" = "cod_malf2",
  "Malformazione_diagnosticata_3" = "cod_malf3",
  "MALFORMAZIONI_MADRE" = "malf_m",
  "MALFORMAZIONI_PADRE" = "malf_p",
  "MALFORMAZIONI_GENITORI_MADRE" = "malf_gen_m",
  "MALFORMAZIONI_GENITORI_PADRE" = "malf_gen_p",
  "MALFORMAZIONI_PARENTI_MADRE" = "malf_par_m",
  "MALFORMAZIONI_PARENTI_PADRE" = "malf_par_p",
  "MALFORMAZIONI_FRATELLI_SORELLE" = "malf_fs",
  "CARIOTIPO_DEL_NATO" = "cariotipo",
  "riscontro_autoptico" = "autopsia",
  "MALATTIE_INSORTE_IN_GRAVIDANZA_1" = "pat_grav1",
  "MALATTIE_INSORTE_IN_GRAVIDANZA_2" = "pat_grav2",
  
  # Anamnesi 
  "PARTI_PRECEDENTI" = "parti_pr",
  "NUMERO_ABORTI_SPONTANEI" = "aborti",
  "NUMERO_IVG" = "ivg",
  "NUMERO_NATI_VIVI" = "nativivi",
  "NUMERO_NATI_MORTI" = "natimor",
  "NUMERO_TAGLI_CESAREI" = "cesarei",
  
  # Socioeconomico
  "STATO_CIVILE_MADRE" = "statociv_m",
  "TITOLO_DI_STUDIO_MADRE" = "titolo_m",
  "TITOLO_DI_STUDIO_PADRE" = "titolo_p",
  "CONDIZIONE_PROF_MADRE" = "condiz_m",
  "CONDIZIONE_PROF_PADRE" = "condiz_p",
  
  # Diagnostica prenatale
  "AMNIOCENTESI" = "amniocen",
  "VILLOCENTESI" = "villicor",
  "FETOSCOPIA" = "fetoscop"
)


# 1️⃣ Rinomina colonne 2010 con mapping
Cedap2010_renamed <- rename(Cedap2010, !!!mapping_2010_2023)

# 2️⃣ Colonne del 2023
cols_2023 <- colnames(cedap_plus_2023)

# 3️⃣ Aggiungi colonne mancanti in 2010 con NA del tipo corretto
cols_mancanti <- setdiff(cols_2023, colnames(Cedap2010_renamed))

for (c in cols_mancanti) {
  tipo <- class(cedap_plus_2023[[c]])[1]
  
  if (tipo %in% c("integer", "numeric")) {
    Cedap2010_renamed[[c]] <- as.numeric(NA)
  } else if (tipo == "character") {
    Cedap2010_renamed[[c]] <- as.character(NA)
  } else if (tipo == "logical") {
    Cedap2010_renamed[[c]] <- as.logical(NA)
  } else if (tipo %in% c("Date", "POSIXct")) {
    Cedap2010_renamed[[c]] <- as.Date(NA)
  } else {
    Cedap2010_renamed[[c]] <- NA
  }
}

# 4️⃣ Elimina colonne non presenti nel 2023
cols_extra <- setdiff(colnames(Cedap2010_renamed), cols_2023)
Cedap2010_renamed <- Cedap2010_renamed[, !(names(Cedap2010_renamed) %in% cols_extra)]

# 5️⃣ Riordina le colonne come il 2023
Cedap2010_renamed <- Cedap2010_renamed[, cols_2023]

# ✅ controllo finale
cat("Colonne 2010:", ncol(Cedap2010_renamed), "\n")
cat("Colonne 2023:", length(cols_2023), "\n")
print(all(colnames(Cedap2010_renamed) == colnames(cedap_plus_2023)))

str(Cedap2010_renamed)


# ---- mapping manuale 2011 → 2023 ----
mapping_2011_2023 <- c(
  
  # Identificativi
  "COD_AZI"          = "cod_azi",
  "COD_STAB"         = "cod_stab",
  "COD_PRES"         = "Neonati_cod_pres",
  "prog_paz_neo"     = "prog_paz",
  "PROG_SDO"         = "prog_sdo",
  "SDO_NEO"          = "sdo_neo",
  
  
  # Evento nascita
  "dt_parto"         = "dt_parto",
  "dt_nas_m"         = "dt_nas_m",

  # Neonati
  "Sesso"            = "genere",
  "PESO"             = "peso",
  "CIRCONFERENZA_CRANICA" = "cfr_cran",
  "nati_maschi"      = "n_maschi",
  "nati_femmine"     = "n_femmine",
  "VITALITA"         = "vitalita",
  
  # Madre
  "CITTADINANZA_M"   = "cittad_m",
  "comune_residenza_madre" = "com_res_m",
  "TITOLO_DI_STUDIO_MADRE" = "titolo_m",
  "CONDIZIONE_PROF_MADRE"  = "condiz_m",
  "STATO_CIVILE_MADRE"     = "statociv_m",
  
  # Padre
  "TITOLO_DI_STUDIO_PADRE" = "titolo_p",
  "CONDIZIONE_PROF_PADRE"  = "condiz_p",
  
  # Gravidanza / esami
  "eta_gestazionale" = "eta_gest",
  "ETA_GESTAZIONALE_ALLA_DIAGNOSI" = "eta_gest_dm",
  "ABITUDINE_AL_FUMO" = "tabacco",
  "CONSANGUINEITA"    = "consang",
  "NUMERO_ECOGRAFIE"  = "n_ecograf",
  "metodi_PMA"        = "procr_ass",
  "CONCEPIMENTI_PRECEDENTI" = "concep_pr",
  
  # Malformazioni / diagnosi
  "Malformazione_diagnosticata_1" = "cod_malf1",
  "Malformazione_diagnosticata_2" = "cod_malf2",
  "Malformazione_diagnosticata_3" = "cod_malf3",
  "MALFORMAZIONI_MADRE"           = "malf_m",
  "MALFORMAZIONI_PADRE"           = "malf_p",
  "MALFORMAZIONI_GENITORI_MADRE"  = "malf_gen_m",
  "MALFORMAZIONI_GENITORI_PADRE"  = "malf_gen_p",
  "MALFORMAZIONI_PARENTI_MADRE"   = "malf_par_m",
  "MALFORMAZIONI_PARENTI_PADRE"   = "malf_par_p",
  "MALFORMAZIONI_FRATELLI_SORELLE"= "malf_fs",
  "riscontro_autoptico"           = "autopsia",
  "CARIOTIPO_DEL_NATO"           = "cariotipo",
  "MALATTIE_INSORTE_IN_GRAVIDANZA_1" = "pat_grav1",
  "MALATTIE_INSORTE_IN_GRAVIDANZA_2" = "pat_grav2",
  
  # Anamnesi ostetrica
  "PARTI_PRECEDENTI"  = "parti_pr",
  "NUMERO_ABORTI_SPONTANEI" = "aborti",
  "NUMERO_IVG"        = "ivg",
  "NUMERO_NATI_VIVI"  = "nativivi",
  "NUMERO_NATI_MORTI" = "natimor",
  "NUMERO_TAGLI_CESAREI" = "cesarei",
  
  # Diagnosi prenatale
  "AMNIOCENTESI"   = "amniocen",
  "VILLOCENTESI"   = "villicor",
  "FETOSCOPIA"     = "fetoscop"
)

# Rinomina colonne 2011 secondo mapping
Cedap2011_renamed <- dplyr::rename(Cedap2011, !!!mapping_2011_2023)

# Lista colonne target (2023)
cols_2023 <- colnames(cedap_plus_2023)

# Colonne da tenere (comuni)
cols_keep <- intersect(colnames(Cedap2011_renamed), cols_2023)

# Colonne mancanti nel 2011 → aggiungi NA del tipo giusto
cols_missing <- setdiff(cols_2023, colnames(Cedap2011_renamed))

for (c in cols_missing) {
  tipo <- class(cedap_plus_2023[[c]])[1]
  if (tipo %in% c("integer","numeric")) Cedap2011_renamed[[c]] <- as.numeric(NA)
  else if (tipo == "character") Cedap2011_renamed[[c]] <- as.character(NA)
  else if (tipo == "logical") Cedap2011_renamed[[c]] <- as.logical(NA)
  else if (tipo %in% c("Date","POSIXct")) Cedap2011_renamed[[c]] <- as.Date(NA)
  else Cedap2011_renamed[[c]] <- NA
}

# Tieni solo colonne presenti nel 2023
Cedap2011_renamed <- Cedap2011_renamed[, cols_2023]

cat("✅ Cedap2011 armonizzato alle colonne 2023\n")

# ✅ controllo finale
cat("Colonne 2011:", ncol(Cedap2011_renamed), "\n")
cat("Colonne 2023:", length(cols_2023), "\n")
print(all(colnames(Cedap2011_renamed) == colnames(cedap_plus_2023)))


# ---- mapping manuale 2012 → 2023 ----

mapping_2012_2023 <- c(
  # Identificativi già presenti
  "COD_AZI"              = "COD_AZI",
  "COD_STAB"             = "COD_STAB",
  "COD_PRES"             = "Neonati_cod_pres",   
  "prog_paz_neo"         = "prog_paz",
  "PROG_SDO"             = "prog_sdo",
  "SDO_NEO"              = "sdo_neo",

  # Date / orari
  "dt_parto"             = "dt_parto",
  "dt_nas_m"             = "dt_nas_m",
  
  # Nascita / neonato
  "Sesso"                = "genere",
  "PESO"                 = "peso",
  "CIRCONFERENZA_CRANICA"= "cfr_cran",
  "nati_maschi"          = "n_maschi",
  "nati_femmine"         = "n_femmine",
  "VITALITA"             = "vitalita",
  
  # Madre
  "CITTADINANZA_M"       = "cittad_m",
  "comune_residenza_madre" = "com_res_m",
  "TITOLO_DI_STUDIO_MADRE" = "titolo_m",
  "CONDIZIONE_PROF_MADRE"  = "condiz_m",
  "STATO_CIVILE_MADRE"     = "statociv_m",
  
  # Padre
  "TITOLO_DI_STUDIO_PADRE" = "titolo_p",
  "CONDIZIONE_PROF_PADRE"  = "condiz_p",
  
  # Gravidanza / esami
  "eta_gestazionale"     = "eta_gest",
  "ETA_GESTAZIONALE_ALLA_DIAGNOSI" = "eta_gest_dm",
  "ABITUDINE_AL_FUMO"    = "tabacco",
  "CONSANGUINEITA"       = "consang",
  "NUMERO_ECOGRAFIE"     = "n_ecograf",
  "metodi_PMA"           = "procr_ass",
  "CONCEPIMENTI_PRECEDENTI" = "concep_pr",
  
  # Malformazioni / diagnosi
  "Malformazione_diagnosticata_1" = "cod_malf1",
  "Malformazione_diagnosticata_2" = "cod_malf2",
  "Malformazione_diagnosticata_3" = "cod_malf3",
  "MALFORMAZIONI_MADRE"  = "malf_m",
  "MALFORMAZIONI_PADRE"  = "malf_p",
  "MALFORMAZIONI_GENITORI_MADRE" = "malf_gen_m",
  "MALFORMAZIONI_GENITORI_PADRE" = "malf_gen_p",
  "MALFORMAZIONI_PARENTI_MADRE"  = "malf_par_m",
  "MALFORMAZIONI_PARENTI_PADRE"  = "malf_par_p",
  "MALFORMAZIONI_FRATELLI_SORELLE" = "malf_fs",
  "riscontro_autoptico"  = "autopsia",
  "CARIOTIPO_DEL_NATO"   = "cariotipo",
  "MALATTIE_INSORTE_IN_GRAVIDANZA_1" = "pat_grav1",
  "MALATTIE_INSORTE_IN_GRAVIDANZA_2" = "pat_grav2",
  
  # Anamnesi ostetrica
  "PARTI_PRECEDENTI"     = "parti_pr",
  "NUMERO_ABORTI_SPONTANEI" = "aborti",
  "NUMERO_IVG"           = "ivg",
  "NUMERO_NATI_VIVI"     = "nativivi",
  "NUMERO_NATI_MORTI"    = "natimor",
  "NUMERO_TAGLI_CESAREI" = "cesarei",
  
  # Diagnostica prenatale
  "AMNIOCENTESI"         = "amniocen",
  "VILLOCENTESI"         = "villicor",
  "FETOSCOPIA"           = "fetoscop",
  
  # <-- variazioni madre: altezza/peso pregravidico/BMI -->
  "ALTEZZA_MADRE"        = "altezza_m",
  "PESO_MADRE_PREGRAVIDICO" = "peso_m",
  "BMI"                  = "bmi"
)

# ---- esegui rinomina (newname = oldname)
Cedap2012_renamed <- dplyr::rename(Cedap2012, !!!mapping_2012_2023)

# ---- assicurati che tutte le colonne 2023 siano presenti: aggiungi quelle mancanti con NA del tipo giusto ----
cols_2023 <- colnames(cedap_plus_2023)

cols_missing <- setdiff(cols_2023, colnames(Cedap2012_renamed))

for (c in cols_missing) {
  tipo <- class(cedap_plus_2023[[c]])[1]
  if (tipo %in% c("integer","numeric")) Cedap2012_renamed[[c]] <- as.numeric(NA)
  else if (tipo == "character") Cedap2012_renamed[[c]] <- as.character(NA)
  else if (tipo == "logical") Cedap2012_renamed[[c]] <- as.logical(NA)
  else if (tipo %in% c("Date","POSIXct","POSIXt")) Cedap2012_renamed[[c]] <- as.Date(NA)
  else Cedap2012_renamed[[c]] <- NA
}

# ---- rimuovi eventuali colonne extra non presenti in 2023 ----
extra_cols <- setdiff(colnames(Cedap2012_renamed), cols_2023)
if (length(extra_cols)) Cedap2012_renamed <- Cedap2012_renamed[, setdiff(colnames(Cedap2012_renamed), extra_cols)]

# ---- ordina colonne come 2023 ----
Cedap2012_renamed <- Cedap2012_renamed[, cols_2023]

# ---- controllo finale ----
cat("Colonne 2023:", length(cols_2023), "\n")
cat("Colonne Cedap2012_renamed:", ncol(Cedap2012_renamed), "\n")
print(all(colnames(Cedap2012_renamed) == cols_2023))



# ---- mapping manuale 2013 → 2023 ----

mapping_2013_2023 <- c(
  # Identificativi
  "COD_AZI" = "COD_AZI",
  "COD_STAB" = "COD_STAB",
  "COD_PRES" = "Cedap2013_Neo_cod_pres",
  "prog_paz_neo" = "prog_paz",
  "SDO_NEO" = "sdo_neo",
  "PROG_SDO" = "prog_sdo",

  # Date e dati nascita
  "dt_parto" = "dt_parto",
  "dt_nas_m" = "dt_nas_m",
  "PESO" = "peso",
  "CIRCONFERENZA_CRANICA" = "cfr_cran",
  "Sesso" = "genere",  
  "nati_maschi" = "n_maschi",
  "nati_femmine" = "n_femmine",
  "VITALITA" = "vitalita",
  
  # Variabili madre
  "CITTADINANZA_M" = "cittad_m",
  "comune_residenza_madre" = "com_res_m",
  "TITOLO_DI_STUDIO_MADRE" = "titolo_m",
  "CONDIZIONE_PROF_MADRE" = "condiz_m",
  "STATO_CIVILE_MADRE" = "statociv_m",
  
  # Padre
  "TITOLO_DI_STUDIO_PADRE" = "titolo_p",
  "CONDIZIONE_PROF_PADRE" = "condiz_p",
  
  # Gravidanza
  "eta_gestazionale" = "eta_gest",
  "ETA_GESTAZIONALE_ALLA_DIAGNOSI" = "eta_gest_dm",
  "NUMERO_ECOGRAFIE" = "n_ecograf",
  "ABITUDINE_AL_FUMO" = "tabacco",
  "CONSANGUINEITA" = "consang",
  
  # PMA
  "metodi_PMA" = "procr_ass",
  "CONCEPIMENTI_PRECEDENTI" = "concep_pr",
  
  # Ostetriche / risultati precedenti
  "PARTI_PRECEDENTI" = "parti_pr",
  "NUMERO_ABORTI_SPONTANEI" = "aborti",
  "NUMERO_IVG" = "ivg",
  "NUMERO_NATI_VIVI" = "nativivi",
  "NUMERO_NATI_MORTI" = "natimor",
  "NUMERO_TAGLI_CESAREI" = "cesarei",
  
  # Diagnosi prenatale
  "AMNIOCENTESI" = "amniocen",
  "VILLOCENTESI" = "villicor",
  "FETOSCOPIA" = "fetoscop",
  
  # Malformazioni
  "Malformazione_diagnosticata_1" = "cod_malf1",
  "Malformazione_diagnosticata_2" = "cod_malf2",
  "Malformazione_diagnosticata_3" = "cod_malf3",
  "MALFORMAZIONI_MADRE" = "malf_m",
  "MALFORMAZIONI_PADRE" = "malf_p",
  "MALFORMAZIONI_GENITORI_MADRE" = "malf_gen_m",
  "MALFORMAZIONI_GENITORI_PADRE" = "malf_gen_p",
  "MALFORMAZIONI_PARENTI_MADRE" = "malf_par_m",
  "MALFORMAZIONI_PARENTI_PADRE" = "malf_par_p",
  "MALFORMAZIONI_FRATELLI_SORELLE" = "malf_fs",
  "CARIOTIPO_DEL_NATO" = "cariotipo",
  "riscontro_autoptico" = "autopsia",
  "MALATTIE_INSORTE_IN_GRAVIDANZA_1" = "pat_grav1",
  "MALATTIE_INSORTE_IN_GRAVIDANZA_2" = "pat_grav2",
  
  # Peso e altezza madre
  "ALTEZZA_MADRE" = "altezza_m",
  "PESO_MADRE_PREGRAVIDICO" = "peso_m",
  "BMI" = "bmi"
)

Cedap2013_renamed <- dplyr::rename(Cedap2013, !!!mapping_2013_2023)

cols_2023 <- colnames(cedap_plus_2023)
cols_missing <- setdiff(cols_2023, colnames(Cedap2013_renamed))

for (c in cols_missing) {
  tipo <- class(cedap_plus_2023[[c]])[1]
  if (tipo %in% c("integer","numeric")) Cedap2013_renamed[[c]] <- as.numeric(NA)
  else if (tipo=="character") Cedap2013_renamed[[c]] <- as.character(NA)
  else if (tipo=="logical") Cedap2013_renamed[[c]] <- as.logical(NA)
  else if (tipo %in% c("Date","POSIXct","POSIXt")) Cedap2013_renamed[[c]] <- as.Date(NA)
  else Cedap2013_renamed[[c]] <- NA
}

extra_cols <- setdiff(colnames(Cedap2013_renamed), cols_2023)
Cedap2013_renamed <- Cedap2013_renamed[, cols_2023]

cat("Colonne 2013:", ncol(Cedap2013_renamed), "\n")
cat("Colonne 2023:", length(cols_2023), "\n")
print(all(colnames(Cedap2013_renamed) == colnames(cedap_plus_2023)))


# ---- mapping manuale 2014 → 2023 ----
mapping_2014_2023 <- c(
  # Identificativi
  "COD_AZI"          = "COD_AZI",
  "COD_STAB"         = "COD_STAB",
  "COD_PRES"         = "Neonati14_cod_pres",
  "prog_paz_neo"     = "prog_paz",
  "PROG_SDO"         = "prog_sdo",
  "SDO_NEO"          = "sdo_neo",
 
  
  # Evento nascita
  "dt_parto"         = "dt_parto",
  "dt_nas_m"         = "dt_nas_m",
  
  # Neonati
  "Sesso"            = "genere",
  "PESO"             = "peso",
  "CIRCONFERENZA_CRANICA" = "cfr_cran",
  "nati_maschi"      = "n_maschi",
  "nati_femmine"     = "n_femmine",
  "VITALITA"         = "vitalita",
  
  # Madre
  "CITTADINANZA_M"   = "cittad_m",
  "comune_residenza_madre" = "com_res_m",
  "TITOLO_DI_STUDIO_MADRE" = "titolo_m",
  "CONDIZIONE_PROF_MADRE"  = "condiz_m",
  "STATO_CIVILE_MADRE"     = "statociv_m",
  
  # Padre
  "TITOLO_DI_STUDIO_PADRE" = "titolo_p",
  "CONDIZIONE_PROF_PADRE"  = "condiz_p",
  
  # Gravidanza / esami
  "eta_gestazionale" = "eta_gest",
  "ETA_GESTAZIONALE_ALLA_DIAGNOSI" = "eta_gest_dm",
  "ABITUDINE_AL_FUMO" = "tabacco",
  "CONSANGUINEITA"    = "consang",
  "NUMERO_ECOGRAFIE"  = "n_ecograf",
  "metodi_PMA"        = "procr_ass",
  "CONCEPIMENTI_PRECEDENTI" = "concep_pr",
  
  # Malformazioni / diagnosi
  "Malformazione_diagnosticata_1" = "cod_malf1",
  "Malformazione_diagnosticata_2" = "cod_malf2",
  "Malformazione_diagnosticata_3" = "cod_malf3",
  "MALFORMAZIONI_MADRE"          = "malf_m",
  "MALFORMAZIONI_PADRE"          = "malf_p",
  "MALFORMAZIONI_GENITORI_MADRE" = "malf_gen_m",
  "MALFORMAZIONI_GENITORI_PADRE" = "malf_gen_p",
  "MALFORMAZIONI_PARENTI_MADRE"  = "malf_par_m",
  "MALFORMAZIONI_PARENTI_PADRE"  = "malf_par_p",
  "MALFORMAZIONI_FRATELLI_SORELLE" = "malf_fs",
  "riscontro_autoptico"           = "autopsia",
  "CARIOTIPO_DEL_NATO"           = "cariotipo",
  
  # Anamnesi ostetrica
  "PARTI_PRECEDENTI"  = "parti_pr",
  "NUMERO_ABORTI_SPONTANEI" = "aborti",
  "NUMERO_IVG"        = "ivg",
  "NUMERO_NATI_VIVI"  = "nativivi",
  "NUMERO_NATI_MORTI" = "natimor",
  "NUMERO_TAGLI_CESAREI" = "cesarei",
  
  # Diagnostica prenatale
  "AMNIOCENTESI"      = "amniocen",
  "VILLOCENTESI"      = "villicor",
  "FETOSCOPIA"        = "fetoscop"
)

#Rinomina colonne 2014 secondo mapping 
Cedap2014_renamed <- dplyr::rename(Cedap2014, !!!mapping_2014_2023)

#Lista colonne target (2023) 
cols_2023 <- colnames(cedap_plus_2023)

#Colonne mancanti nel 2014 → aggiungi NA del tipo giusto
cols_missing <- setdiff(cols_2023, colnames(Cedap2014_renamed))
for (c in cols_missing) {
  tipo <- class(cedap_plus_2023[[c]])[1]
  if (tipo %in% c("integer","numeric")) Cedap2014_renamed[[c]] <- as.numeric(NA)
  else if (tipo == "character") Cedap2014_renamed[[c]] <- as.character(NA)
  else if (tipo == "logical") Cedap2014_renamed[[c]] <- as.logical(NA)
  else if (tipo %in% c("Date","POSIXct")) Cedap2014_renamed[[c]] <- as.Date(NA)
  else Cedap2014_renamed[[c]] <- NA
}

#Tieni solo colonne presenti nel 2023
Cedap2014_renamed <- Cedap2014_renamed[, cols_2023]

#Controllo finale
cat("Colonne 2014:", ncol(Cedap2014_renamed), "\n")
cat("Colonne 2023:", length(cols_2023), "\n")
print(all(colnames(Cedap2014_renamed) == colnames(cedap_plus_2023)))


# ---- mapping manuale 2015 → 2023 ----
mapping_2015_2023 <- c(
  # Identificativi
  "COD_AZI"          = "COD_AZI",
  "COD_STAB"         = "COD_STAB",
  "COD_PRES"         = "Neonati2015_cod_pres",
  "prog_paz_neo"     = "prog_paz",
  "PROG_SDO"         = "prog_sdo",
  "SDO_NEO"          = "sdo_neo",

  # Evento nascita
  "dt_parto"         = "dt_parto",
  "dt_nas_m"         = "dt_nas_m",
  
  # Neonati
  "Sesso"            = "genere",
  "PESO"             = "peso",
  "CIRCONFERENZA_CRANICA" = "cfr_cran",
  "nati_maschi"      = "n_maschi",
  "nati_femmine"     = "n_femmine",
  "VITALITA"         = "vitalita",
  
  # Madre
  "CITTADINANZA_M"   = "cittad_m",
  "comune_residenza_madre" = "com_res_m",
  "TITOLO_DI_STUDIO_MADRE" = "titolo_m",
  "CONDIZIONE_PROF_MADRE"  = "condiz_m",
  "STATO_CIVILE_MADRE"     = "statociv_m",
  
  # Padre
  "TITOLO_DI_STUDIO_PADRE" = "titolo_p",
  "CONDIZIONE_PROF_PADRE"  = "condiz_p",
  
  # Gravidanza / esami
  "eta_gestazionale" = "eta_gest",
  "ETA_GESTAZIONALE_ALLA_DIAGNOSI" = "eta_gest_dm",
  "ABITUDINE_AL_FUMO" = "tabacco",
  "CONSANGUINEITA"    = "consang",
  "NUMERO_ECOGRAFIE"  = "n_ecograf",
  "metodi_PMA"        = "procr_ass",

  # Malformazioni / diagnosi
  "Malformazione_diagnosticata_1" = "cod_malf1",
  "Malformazione_diagnosticata_2" = "cod_malf2",
  "Malformazione_diagnosticata_3" = "cod_malf3",
  "MALFORMAZIONI_MADRE"          = "malf_m",
  "MALFORMAZIONI_PADRE"          = "malf_p",
  "MALFORMAZIONI_GENITORI_MADRE" = "malf_gen_m",
  "MALFORMAZIONI_GENITORI_PADRE" = "malf_gen_p",
  "MALFORMAZIONI_PARENTI_MADRE"  = "malf_par_m",
  "MALFORMAZIONI_PARENTI_PADRE"  = "malf_par_p",
  "MALFORMAZIONI_FRATELLI_SORELLE" = "malf_fs",
  "riscontro_autoptico"           = "autopsia",
  "CARIOTIPO_DEL_NATO"           = "cariotipo",
  
  # Anamnesi ostetrica
  "PARTI_PRECEDENTI"  = "parti_pr",
  "NUMERO_ABORTI_SPONTANEI" = "aborti",
  "NUMERO_IVG"        = "ivg",
  "NUMERO_NATI_VIVI"  = "nativivi",
  "NUMERO_NATI_MORTI" = "natimor",
  "NUMERO_TAGLI_CESAREI" = "cesarei",
  
  # Diagnostica prenatale
  "AMNIOCENTESI"      = "amniocen",
  "VILLOCENTESI"      = "villicor",
  "FETOSCOPIA"        = "fetoscop"
)

# ---- Rinomina colonne 2015 secondo mapping ----
Cedap2015_renamed <- dplyr::rename(Cedap2015, !!!mapping_2015_2023)

# ---- Lista colonne target (2023) ----
cols_2023 <- colnames(cedap_plus_2023)

# ---- Colonne mancanti nel 2015 → aggiungi NA del tipo giusto ----
cols_missing <- setdiff(cols_2023, colnames(Cedap2015_renamed))
for (c in cols_missing) {
  tipo <- class(cedap_plus_2023[[c]])[1]
  if (tipo %in% c("integer","numeric")) Cedap2015_renamed[[c]] <- as.numeric(NA)
  else if (tipo == "character") Cedap2015_renamed[[c]] <- as.character(NA)
  else if (tipo == "logical") Cedap2015_renamed[[c]] <- as.logical(NA)
  else if (tipo %in% c("Date","POSIXct")) Cedap2015_renamed[[c]] <- as.Date(NA)
  else Cedap2015_renamed[[c]] <- NA
}

# ---- Tieni solo colonne presenti nel 2023 ----
Cedap2015_renamed <- Cedap2015_renamed[, cols_2023]

# ---- Controllo finale ----
cat("Colonne 2015:", ncol(Cedap2015_renamed), "\n")
cat("Colonne 2023:", length(cols_2023), "\n")
print(all(colnames(Cedap2015_renamed) == colnames(cedap_plus_2023)))


# ---- mapping manuale 2016 → 2023 ----
mapping_2016_2023 <- c(
  # Identificativi
  "COD_AZI"          = "COD_AZI",
  "COD_STAB"         = "COD_STAB",
  "prog_paz_neo"     = "prog_paz",
  "PROG_SDO"         = "prog_sdo",
  "SDO_NEO"          = "sdo_neo",

  # Evento nascita
  "dt_parto"         = "dt_parto",
  "dt_nas_m"         = "dt_nas_m",

  # Neonati
  "Sesso"            = "genere",
  "PESO"             = "peso",
  "CIRCONFERENZA_CRANICA" = "cfr_cran",
  "nati_maschi"      = "n_maschi",
  "nati_femmine"     = "n_femmine",
  "VITALITA"         = "vitalita",
  
  # Madre
  "CITTADINANZA_M"   = "cittad_m",
  "comune_residenza_madre" = "com_res_m",
  "TITOLO_DI_STUDIO_MADRE" = "titolo_m",
  "CONDIZIONE_PROF_MADRE"  = "condiz_m",
  "STATO_CIVILE_MADRE"     = "statociv_m",
  
  # Padre
  "TITOLO_DI_STUDIO_PADRE" = "titolo_p",
  "CONDIZIONE_PROF_PADRE"  = "condiz_p",
  
  # Gravidanza / esami
  "eta_gestazionale" = "eta_gest",
  "ETA_GESTAZIONALE_ALLA_DIAGNOSI" = "eta_gest_dm",
  "ABITUDINE_AL_FUMO" = "tabacco",
  "CONSANGUINEITA"    = "consang",
  "NUMERO_ECOGRAFIE"  = "n_ecograf",
  "metodi_PMA"        = "procr_ass",
  "CONCEPIMENTI_PRECEDENTI" = "concepimenti_pr",
  
  # Malformazioni / diagnosi
  "Malformazione_diagnosticata_1" = "cod_malf1",
  "Malformazione_diagnosticata_2" = "cod_malf2",
  "Malformazione_diagnosticata_3" = "cod_malf3",
  "MALFORMAZIONI_MADRE"          = "malf_m",
  "MALFORMAZIONI_PADRE"          = "malf_p",
  "MALFORMAZIONI_GENITORI_MADRE" = "malf_gen_m",
  "MALFORMAZIONI_GENITORI_PADRE" = "malf_gen_p",
  "MALFORMAZIONI_PARENTI_MADRE"  = "malf_par_m",
  "MALFORMAZIONI_PARENTI_PADRE"  = "malf_par_p",
  "MALFORMAZIONI_FRATELLI_SORELLE" = "malf_fs",
  "riscontro_autoptico"           = "autopsia",
  "CARIOTIPO_DEL_NATO"           = "cariotipo",
  
  # Anamnesi ostetrica
  "PARTI_PRECEDENTI"  = "parti_pr",
  "NUMERO_ABORTI_SPONTANEI" = "aborti",
  "NUMERO_IVG"        = "ivg",
  "NUMERO_NATI_VIVI"  = "nativivi",
  "NUMERO_NATI_MORTI" = "natimor",
  "NUMERO_TAGLI_CESAREI" = "cesarei",
  
  # Diagnostica prenatale
  "AMNIOCENTESI"      = "amniocen",
  "VILLOCENTESI"      = "villicor",
  "FETOSCOPIA"        = "fetoscop"
)

# ---- Rinomina colonne 2016 secondo mapping ----
Cedap2016_renamed <- dplyr::rename(Cedap2016, !!!mapping_2016_2023)

# ---- Lista colonne target (2023) ----
cols_2023 <- colnames(cedap_plus_2023)

# ---- Colonne mancanti nel 2016 → aggiungi NA del tipo giusto ----
cols_missing <- setdiff(cols_2023, colnames(Cedap2016_renamed))
for (c in cols_missing) {
  tipo <- class(cedap_plus_2023[[c]])[1]
  if (tipo %in% c("integer","numeric")) Cedap2016_renamed[[c]] <- as.numeric(NA)
  else if (tipo == "character") Cedap2016_renamed[[c]] <- as.character(NA)
  else if (tipo == "logical") Cedap2016_renamed[[c]] <- as.logical(NA)
  else if (tipo %in% c("Date","POSIXct")) Cedap2016_renamed[[c]] <- as.Date(NA)
  else Cedap2016_renamed[[c]] <- NA
}

# ---- Tieni solo colonne presenti nel 2023 ----
Cedap2016_renamed <- Cedap2016_renamed[, cols_2023]

# ---- Controllo finale ----
cat("Colonne 2016:", ncol(Cedap2016_renamed), "\n")
cat("Colonne 2023:", length(cols_2023), "\n")
print(all(colnames(Cedap2016_renamed) == colnames(cedap_plus_2023)))





# ---- mapping manuale 2017 → 2023 ----
mapping_2017_2023 <- c(
  # Identificativi
  "COD_AZI"        = "COD_AZI",
  "COD_STAB"       = "COD_STAB",
  "prog_paz_neo"   = "prog_paz",
  "SDO_NEO"        = "sdo_neo",
  "PROG_SDO"       = "prog_sdo",
  
  # Nascita / dati temporali
  "dt_parto"       = "dt_parto",
  "dt_nas_m"       = "dt_nas_m",
  
  # Neonato
  "Sesso"          = "genere",
  "PESO"           = "peso",
  "CIRCONFERENZA_CRANICA" = "cfr_cran",
  "nati_maschi"    = "n_maschi",
  "nati_femmine"   = "n_femmine",
  "VITALITA"       = "vitalita",
  
  # Madre
  "CITTADINANZA_M" = "cittad_m",
  "comune_residenza_madre" = "com_res_m",
  "STATO_CIVILE_MADRE" = "statociv_m",
  "TITOLO_DI_STUDIO_MADRE" = "titolo_m",
  "CONDIZIONE_PROF_MADRE"  = "condiz_m",
  
  # Padre
  "TITOLO_DI_STUDIO_PADRE" = "titolo_p",
  "CONDIZIONE_PROF_PADRE"  = "condiz_p",
  
  # Gravidanza
  "eta_gestazionale" = "eta_gest",
  "ETA_GESTAZIONALE_ALLA_DIAGNOSI" = "eta_gest_dm",
  "CONSANGUINEITA"   = "consang",
  "ABITUDINE_AL_FUMO" = "tabacco",
  "metodi_PMA"       = "procr_ass",
  "NUMERO_ECOGRAFIE" = "n_ecograf",
  
  # Anamnesi ostetrica
  "CONCEPIMENTI_PRECEDENTI" = "concepimenti_pr",
  "PARTI_PRECEDENTI"        = "parti_pr",
  "NUMERO_ABORTI_SPONTANEI" = "aborti",
  "NUMERO_IVG"              = "ivg",
  "NUMERO_NATI_VIVI"        = "nativivi",
  "NUMERO_NATI_MORTI"       = "natimor",
  "NUMERO_TAGLI_CESAREI"    = "cesarei",
  
  # Diagnostica prenatale
  "AMNIOCENTESI"    = "amniocen",
  "VILLOCENTESI"    = "villicor",
  "FETOSCOPIA"      = "fetoscop",
  "TEST_COMBINATO"  = "tcombinato",
  
  # Malformazioni
  "Malformazione_diagnosticata_1" = "cod_malf1",
  "Malformazione_diagnosticata_2" = "cod_malf2",
  "Malformazione_diagnosticata_3" = "cod_malf3",
  "MALFORMAZIONI_MADRE"           = "malf_m",
  "MALFORMAZIONI_PADRE"           = "malf_p",
  "MALFORMAZIONI_GENITORI_MADRE"  = "malf_gen_m",
  "MALFORMAZIONI_GENITORI_PADRE"  = "malf_gen_p",
  "MALFORMAZIONI_PARENTI_MADRE"   = "malf_par_m",
  "MALFORMAZIONI_PARENTI_PADRE"   = "malf_par_p",
  "MALFORMAZIONI_FRATELLI_SORELLE" = "malf_fs",
  "CARIOTIPO_DEL_NATO"            = "cariotipo",
  "riscontro_autoptico"           = "autopsia"
)

# ---- Rinominare ----
Cedap2017_renamed <- dplyr::rename(Cedap2017, !!!mapping_2017_2023)

# ---- Aggiungi colonne mancanti ----
cols_2023 <- colnames(cedap_plus_2023)
cols_missing <- setdiff(cols_2023, colnames(Cedap2017_renamed))

for (c in cols_missing) {
  tipo <- class(cedap_plus_2023[[c]])[1]
  if (tipo %in% c("integer","numeric")) Cedap2017_renamed[[c]] <- as.numeric(NA)
  else if (tipo == "character") Cedap2017_renamed[[c]] <- as.character(NA)
  else if (tipo == "logical") Cedap2017_renamed[[c]] <- as.logical(NA)
  else if (tipo %in% c("Date","POSIXct")) Cedap2017_renamed[[c]] <- as.Date(NA)
  else Cedap2017_renamed[[c]] <- NA
}

# ---- Stessa struttura dell'anno 2023 ----
Cedap2017_renamed <- Cedap2017_renamed[, cols_2023]

# ---- Controllo console ----
cat("Colonne 2017:", ncol(Cedap2017_renamed), "\n")
cat("Colonne 2023:", length(cols_2023), "\n")
print(all(colnames(Cedap2017_renamed) == colnames(cedap_plus_2023)))


# ---- mapping manuale 2018 → 2023 ----
mapping_2018_2023 <- c(
  # Identificativi
  "COD_AZI"        = "COD_AZI",
  "COD_STAB"       = "COD_STAB",
  "prog_paz_neo"   = "prog_paz",
  "SDO_NEO"        = "sdo_neo",
  "PROG_SDO"       = "prog_sdo",
  
  # Nascita / dati temporali
  "dt_parto"       = "dt_parto",
  "dt_nas_m"       = "dt_nas_m",
  
  # Neonato
  "Sesso"                  = "genere",
  "PESO"                   = "peso",
  "CIRCONFERENZA_CRANICA"  = "cfr_cran",
  "nati_maschi"           = "n_maschi",
  "nati_femmine"          = "n_femmine",
  "VITALITA"              = "vitalita",
  
  # Madre
  "CITTADINANZA_M"         = "cittad_m",
  "comune_residenza_madre" = "com_res_m",
  "STATO_CIVILE_MADRE"     = "statociv_m",
  "TITOLO_DI_STUDIO_MADRE" = "titolo_m",
  "CONDIZIONE_PROF_MADRE"  = "condiz_m",
  "ALTEZZA_MADRE"          = "altezza_m",
  "PESO_MADRE_PREGRAVIDICO" = "peso_m",
  "PESO_MADRE_AL_PARTO"     = "peso_m_parto",
  "ABITUDINE_AL_FUMO"       = "tabacco",
  
  # Padre
  "TITOLO_DI_STUDIO_PADRE" = "titolo_p",
  "CONDIZIONE_PROF_PADRE"  = "condiz_p",
  
  # Gravidanza
  "eta_gestazionale"       = "eta_gest",
  "ETA_GESTAZIONALE_ALLA_DIAGNOSI" = "eta_gest_dm",
  "CONSANGUINEITA"         = "consang",
  "metodi_PMA"             = "procr_ass",
  "NUMERO_ECOGRAFIE"       = "n_ecograf",
  
  # Anamnesi ostetrica
  "CONCEPIMENTI_PRECEDENTI" = "concepimenti_pr",
  "PARTI_PRECEDENTI"        = "parti_pr",
  "NUMERO_ABORTI_SPONTANEI" = "aborti",
  "NUMERO_IVG"              = "ivg",
  "NUMERO_NATI_VIVI"        = "nativivi",
  "NUMERO_NATI_MORTI"       = "natimor",
  "NUMERO_TAGLI_CESAREI"    = "cesarei",
  
  # Diagnostica prenatale
  "AMNIOCENTESI"    = "amniocen",
  "VILLOCENTESI"    = "villicor",
  "FETOSCOPIA"      = "fetoscop",
  "TEST_COMBINATO"  = "tcombinato",
  
  # Malformazioni
  "Malformazione_diagnosticata_1" = "cod_malf1",
  "Malformazione_diagnosticata_2" = "cod_malf2",
  "Malformazione_diagnosticata_3" = "cod_malf3",
  "MALFORMAZIONI_MADRE"           = "malf_m",
  "MALFORMAZIONI_PADRE"           = "malf_p",
  "MALFORMAZIONI_GENITORI_MADRE"  = "malf_gen_m",
  "MALFORMAZIONI_GENITORI_PADRE"  = "malf_gen_p",
  "MALFORMAZIONI_PARENTI_MADRE"   = "malf_par_m",
  "MALFORMAZIONI_PARENTI_PADRE"   = "malf_par_p",
  "MALFORMAZIONI_FRATELLI_SORELLE" = "malf_fs",
  "CARIOTIPO_DEL_NATO"            = "cariotipo",
  "riscontro_autoptico"           = "autopsia"
)

# ---- Rinominare ----
Cedap2018_renamed <- dplyr::rename(Cedap2018, !!!mapping_2018_2023)

# ---- Aggiungi colonne mancanti ----
cols_2023 <- colnames(cedap_plus_2023)
cols_missing <- setdiff(cols_2023, colnames(Cedap2018_renamed))

for (c in cols_missing) {
  tipo <- class(cedap_plus_2023[[c]])[1]
  if (tipo %in% c("integer","numeric")) Cedap2018_renamed[[c]] <- as.numeric(NA)
  else if (tipo == "character") Cedap2018_renamed[[c]] <- as.character(NA)
  else if (tipo == "logical") Cedap2018_renamed[[c]] <- as.logical(NA)
  else if (tipo %in% c("Date","POSIXct")) Cedap2018_renamed[[c]] <- as.Date(NA)
  else Cedap2018_renamed[[c]] <- NA
}

# ---- Stessa struttura dell'anno 2023 ----
Cedap2018_renamed <- Cedap2018_renamed[, cols_2023]

# ---- Controllo console ----
cat("Colonne 2018:", ncol(Cedap2018_renamed), "\n")
cat("Colonne 2023:", length(cols_2023), "\n")
print(all(colnames(Cedap2018_renamed) == colnames(cedap_plus_2023)))

setdiff(names(cols_2023), mapping_2018_2023)


# ---- mapping manuale 2019 → 2023 ----
mapping_2019_2023 <- c(
  # Identificativi
  "COD_AZI"                    = "COD_AZI",
  "COD_STAB"                   = "COD_STAB",
  "COD_PRES"                   = "Neonati_2019_rer_COD_PRES",
  "prog_paz_neo"               = "PROG_PAZ",
  "SDO_NEO"                    = "SDO_NEO",
  "PROG_SDO"                   = "PROG_SDO",
  
  # Nascita / date
  "dt_parto"                   = "dt_parto",
  "dt_nas_m"                   = "dt_nas_m",
  
  # Neonato
  "Sesso"                      = "GENERE",
  "PESO"                       = "PESO",
  "CIRCONFERENZA_CRANICA"      = "CFR_CRAN",
  "nati_maschi"                = "N_MASCHI",
  "nati_femmine"               = "N_FEMMINE",
  "VITALITA"                   = "VITALITA",
  
  # Madre
  "CITTADINANZA_M"             = "CITTAD_M",
  "comune_residenza_madre"     = "COM_RES_M",
  "STATO_CIVILE_MADRE"         = "STATOCIV_M",
  "TITOLO_DI_STUDIO_MADRE"     = "TITOLO_M",
  "CONDIZIONE_PROF_MADRE"      = "CONDIZ_M",
  
  # Padre
  "TITOLO_DI_STUDIO_PADRE"     = "TITOLO_P",
  "CONDIZIONE_PROF_PADRE"      = "CONDIZ_P",
  
  # Gravidanza
  "eta_gestazionale"           = "ETA_GEST",
  "ETA_GESTAZIONALE_ALLA_DIAGNOSI" = "ETA_GEST_DM",
  "CONSANGUINEITA"             = "CONSANG",
  "ABITUDINE_AL_FUMO"          = "TABACCO",
  "metodi_PMA"                 = "PROCR_ASS",
  "NUMERO_ECOGRAFIE"           = "N_ECOGRAF",
  
  # Anamnesi ostetrica
  "CONCEPIMENTI_PRECEDENTI"    = "CONCEP_PR",
  "PARTI_PRECEDENTI"           = "PARTI_PR",
  "NUMERO_ABORTI_SPONTANEI"    = "ABORTI",
  "NUMERO_IVG"                 = "IVG",
  "NUMERO_NATI_VIVI"           = "NATIVIVI",
  "NUMERO_NATI_MORTI"          = "NATIMOR",
  "NUMERO_TAGLI_CESAREI"       = "CESAREI",
  
  # Diagnostica prenatale
  "AMNIOCENTESI"               = "AMNIOCEN",
  "VILLOCENTESI"               = "VILLICOR",
  "FETOSCOPIA"                 = "FETOSCOP",
  "TEST_COMBINATO"             = "TCOMBINATO",
  
  # Misure materne
  "ALTEZZA_MADRE"              = "ALTEZZA_M",
  "PESO_MADRE_AL_PARTO"        = "PESO_M_PARTO",
  "PESO_MADRE_PREGRAVIDICO"    = "PESO_M",
  
  # Malformazioni
  "Malformazione_diagnosticata_1" = "COD_MALF1",
  "Malformazione_diagnosticata_2" = "COD_MALF2",
  "Malformazione_diagnosticata_3" = "COD_MALF3",
  "MALFORMAZIONI_MADRE"        = "MALF_M",
  "MALFORMAZIONI_PADRE"        = "MALF_P",
  "MALFORMAZIONI_GENITORI_MADRE" = "MALF_GEN_M",
  "MALFORMAZIONI_GENITORI_PADRE" = "MALF_GEN_P",
  "MALFORMAZIONI_PARENTI_MADRE" = "MALF_PAR_M",
  "MALFORMAZIONI_PARENTI_PADRE" = "MALF_PAR_P",
  "MALFORMAZIONI_FRATELLI_SORELLE" = "MALF_FS",
  "CARIOTIPO_DEL_NATO"         = "CARIOTIPO",
  "riscontro_autoptico"        = "AUTOPSIA"
)

# ---- Rinominare ----
Cedap2019_renamed <- dplyr::rename(Cedap2019, !!!mapping_2019_2023)

# ---- Aggiungi colonne mancanti ----
cols_2023 <- colnames(cedap_plus_2023)
cols_missing <- setdiff(cols_2023, colnames(Cedap2019_renamed))

for (c in cols_missing) {
  tipo <- class(cedap_plus_2023[[c]])[1]
  if (tipo %in% c("integer","numeric")) Cedap2019_renamed[[c]] <- as.numeric(NA)
  else if (tipo == "character") Cedap2019_renamed[[c]] <- as.character(NA)
  else if (tipo == "logical") Cedap2019_renamed[[c]] <- as.logical(NA)
  else if (tipo %in% c("Date","POSIXct")) Cedap2019_renamed[[c]] <- as.Date(NA)
  else Cedap2019_renamed[[c]] <- NA
}

# ---- Stessa struttura dell'anno 2023 ----
Cedap2019_renamed <- Cedap2019_renamed[, cols_2023]

# ---- Controllo console ----
cat("Colonne 2019:", ncol(Cedap2019_renamed), "\n")
cat("Colonne 2023:", length(cols_2023), "\n")
print(all(colnames(Cedap2019_renamed) == colnames(cedap_plus_2023)))




# ---- mapping manuale 2020 → 2023 ----

mapping_2020_2023 <- c(
  
  # Identificativi
  "COD_AZI"                     = "COD_AZI",
  "COD_STAB"                    = "COD_STAB",
  "COD_PRES"                    = "Neonati20_rer_COD_PRES",
  "prog_paz_neo"                = "PROG_PAZ",
  "SDO_NEO"                     = "SDO_NEO",
  "PROG_SDO"                    = "PROG_SDO",

  # Date / parto
  "dt_parto"                    = "dt_parto",
  "dt_nas_m"                    = "dt_nas_m",
  
  # Neonato
  "Sesso"                       = "GENERE",
  "PESO"                        = "PESO",
  "CIRCONFERENZA_CRANICA"       = "CFR_CRAN",
  "nati_maschi"                 = "N_MASCHI",
  "nati_femmine"                = "N_FEMMINE",
  "VITALITA"                    = "VITALITA",
  
  # Madre
  "CITTADINANZA_M"              = "CITTAD_M",
  "comune_residenza_madre"      = "COM_RES_M",
  "STATO_CIVILE_MADRE"          = "STATOCIV_M",
  "TITOLO_DI_STUDIO_MADRE"      = "TITOLO_M",
  "CONDIZIONE_PROF_MADRE"       = "CONDIZ_M",
  
  # Padre
  "TITOLO_DI_STUDIO_PADRE"      = "TITOLO_P",
  "CONDIZIONE_PROF_PADRE"       = "CONDIZ_P",
  
  # Gestazione
  "eta_gestazionale"            = "ETA_GEST",
  "ETA_GESTAZIONALE_ALLA_DIAGNOSI" = "ETA_GEST_DM",
  "CONSANGUINEITA"              = "CONSANG",
  "ABITUDINE_AL_FUMO"           = "TABACCO",
  "metodi_PMA"                  = "PROCR_ASS",
  "NUMERO_ECOGRAFIE"            = "N_ECOGRAF",
  
  # Anamnesi ostetrica
  "CONCEPIMENTI_PRECEDENTI"     = "CONCEP_PR",
  "PARTI_PRECEDENTI"            = "PARTI_PR",
  "NUMERO_ABORTI_SPONTANEI"     = "ABORTI",
  "NUMERO_IVG"                  = "IVG",
  "NUMERO_NATI_VIVI"            = "NATIVIVI",
  "NUMERO_NATI_MORTI"           = "NATIMOR",
  "NUMERO_TAGLI_CESAREI"        = "CESAREI",
  
  # Diagnostica prenatale
  "AMNIOCENTESI"                = "AMNIOCEN",
  "VILLOCENTESI"                = "VILLICOR",
  "FETOSCOPIA"                  = "FETOSCOP",
  "TEST_COMBINATO"              = "TCOMBINATO",
  
  # Misure madre
  "ALTEZZA_MADRE"               = "ALTEZZA_M",
  "PESO_MADRE_AL_PARTO"         = "PESO_M_PARTO",
  "PESO_MADRE_PREGRAVIDICO"     = "PESO_M",
  
  # Malformazioni
  "Malformazione_diagnosticata_1" = "COD_MALF1",
  "Malformazione_diagnosticata_2" = "COD_MALF2",
  "Malformazione_diagnosticata_3" = "COD_MALF3",
  "MALFORMAZIONI_MADRE"          = "MALF_M",
  "MALFORMAZIONI_PADRE"          = "MALF_P",
  "MALFORMAZIONI_GENITORI_MADRE" = "MALF_GEN_M",
  "MALFORMAZIONI_GENITORI_PADRE" = "MALF_GEN_P",
  "MALFORMAZIONI_PARENTI_MADRE"  = "MALF_PAR_M",
  "MALFORMAZIONI_PARENTI_PADRE"  = "MALF_PAR_P",
  "MALFORMAZIONI_FRATELLI_SORELLE" = "MALF_FS",
  "CARIOTIPO_DEL_NATO"           = "CARIOTIPO",
  "riscontro_autoptico"          = "AUTOPSIA"
)

# ---- Rinominare ----
Cedap2020_renamed <- dplyr::rename(Cedap2020, !!!mapping_2020_2023)

# ---- Aggiungi colonne mancanti ----
cols_2023 <- colnames(cedap_plus_2023)
cols_missing <- setdiff(cols_2023, colnames(Cedap2020_renamed))

for (c in cols_missing) {
  tipo <- class(cedap_plus_2023[[c]])[1]
  if (tipo %in% c("integer","numeric")) Cedap2020_renamed[[c]] <- as.numeric(NA)
  else if (tipo == "character") Cedap2020_renamed[[c]] <- as.character(NA)
  else if (tipo == "logical") Cedap2020_renamed[[c]] <- as.logical(NA)
  else if (tipo %in% c("Date","POSIXct")) Cedap2020_renamed[[c]] <- as.Date(NA)
  else Cedap2020_renamed[[c]] <- NA
}

# ---- Stessa struttura 2023 ----
Cedap2020_renamed <- Cedap2020_renamed[, cols_2023]

# ---- Controllo console ----
cat("Colonne 2020:", ncol(Cedap2020_renamed), "\n")
cat("Colonne 2023:", length(cols_2023), "\n")
print(all(colnames(Cedap2020_renamed) == colnames(cedap_plus_2023)))




# ---- mapping manuale 2021 → 2023 ----

mapping_2021_2023 <- c(
  "COD_AZI" = "COD_AZI",
  "COD_STAB" = "COD_STAB",
  "COD_PRES" = "Neonati21_rob_COD_PRES",
  "prog_paz_neo" = "PROG_PAZ",
  "SDO_NEO" = "SDO_NEO",
  "PROG_SDO" = "PROG_SDO",
  "Malformazione_diagnosticata_1" = "COD_MALF1",
  "nati_femmine" = "N_FEMMINE",
  "nati_maschi" = "N_MASCHI",
  "riscontro_autoptico" = "AUTOPSIA",
  "data_nascita_padre" = "AA_NAS_P",
  "STATO_CIVILE_MADRE" = "STATOCIV_M",
  "eta_gestazionale" = "ETA_GEST",
  "comune_residenza_madre" = "COM_RES_M",
  "metodi_PMA" = "PROCR_ASS",
  "ECOGRAFIA_OLTRE22SETTIMANE" = "ECOGRAF",  
  "FETOSCOPIA" = "FETOSCOP",
  "VILLOCENTESI" = "VILLICOR",
  "AMNIOCENTESI" = "AMNIOCEN",
  "TEST_COMBINATO" = "TCOMBINATO",
  "CITTADINANZA_M" = "CITTAD_M",
  "VITALITA" = "VITALITA",
  "NUMERO_ECOGRAFIE" = "N_ECOGRAF",
  "CIRCONFERENZA_CRANICA" = "CFR_CRAN",
  "CONSANGUINEITA" = "CONSANG",
  "dt_nas_m" = "dt_nas_m",
  "PESO_MADRE_AL_PARTO" = "PESO_M_PARTO",
  "PESO" = "PESO",
  "PESO_MADRE_PREGRAVIDICO" = "PESO_M",
  "ALTEZZA_MADRE" = "ALTEZZA_M",
  "ABITUDINE_AL_FUMO" = "TABACCO",
  "dt_parto" = "dt_parto",
  "Sesso" = "GENERE",
  "CONCEPIMENTI_PRECEDENTI" = "CONCEP_PR",
  "PARTI_PRECEDENTI" = "PARTI_PR",
  "NUMERO_ABORTI_SPONTANEI" = "ABORTI",
  "NUMERO_IVG" = "IVG",
  "NUMERO_NATI_VIVI" = "NATIVIVI",
  "NUMERO_NATI_MORTI" = "NATIMOR",
  "NUMERO_TAGLI_CESAREI" = "CESAREI",
  "DIFETTO_ACCRESCIMENTO_FETALE" = "DIF_ACCR",
  "MALATTIE_INSORTE_IN_GRAVIDANZA_1" = "PAT_GRAV1",
  "MALATTIE_INSORTE_IN_GRAVIDANZA_2" = "PAT_GRAV2",
  "MALFORMAZIONI_MADRE" = "MALF_M",
  "MALFORMAZIONI_PADRE" = "MALF_P",
  "MALFORMAZIONI_GENITORI_MADRE" = "MALF_GEN_M",
  "MALFORMAZIONI_GENITORI_PADRE" = "MALF_GEN_P",
  "MALFORMAZIONI_PARENTI_MADRE" = "MALF_PAR_M",
  "MALFORMAZIONI_PARENTI_PADRE" = "MALF_PAR_P",
  "MALFORMAZIONI_FRATELLI_SORELLE" = "MALF_FS",
  "ETA_GESTAZIONALE_ALLA_DIAGNOSI" = "ETA_GEST",
  "CARIOTIPO_DEL_NATO" = "CARIOTIPO",
  "CONDIZIONE_PROF_PADRE" = "CONDIZ_P",
  "TITOLO_DI_STUDIO_PADRE" = "TITOLO_P",
  "CONDIZIONE_PROF_MADRE" = "CONDIZ_M",
  "TITOLO_DI_STUDIO_MADRE" = "TITOLO_M",
  "Malformazione_diagnosticata_2" = "COD_MALF2",
  "Malformazione_diagnosticata_3" = "COD_MALF3"
)


# ---- Rinominare ----
Cedap2021_renamed <- dplyr::rename(Cedap2021, !!!mapping_2021_2023)

# ---- Aggiungi colonne mancanti ----
cols_2023 <- colnames(cedap_plus_2023)
cols_missing <- setdiff(cols_2023, colnames(Cedap2021_renamed))

for (c in cols_missing) {
  tipo <- class(cedap_plus_2023[[c]])[1]
  if (tipo %in% c("integer","numeric")) Cedap2021_renamed[[c]] <- as.numeric(NA)
  else if (tipo == "character") Cedap2021_renamed[[c]] <- as.character(NA)
  else if (tipo == "logical") Cedap2021_renamed[[c]] <- as.logical(NA)
  else if (tipo %in% c("Date","POSIXct")) Cedap2021_renamed[[c]] <- as.Date(NA)
  else Cedap2021_renamed[[c]] <- NA
}

# ---- Ordina colonne ----
Cedap2021_renamed <- Cedap2021_renamed[, cols_2023]

# ---- Controllo console ----
cat("Colonne 2021:", ncol(Cedap2021_renamed), "\n")
cat("Colonne 2023:", length(cols_2023), "\n")
print(all(colnames(Cedap2021_renamed) == colnames(cedap_plus_2023)))

# -----------------------------------------
# ---- MAPPING COLONNE 2022 → 2023 --------
# -----------------------------------------

mapping_2022_2023 <- c(
  
  "COD_AZI" = "COD_AZI",
  "COD_STAB" = "COD_STAB",
  "COD_PRES" = "Neonati_Presidio di evento",   # confermato 2021 same logic
  "prog_paz_neo" = "PROG_PAZ",
  "SDO_NEO" = "SDO_NEO",
  "PROG_SDO" = "PROG_SDO",
  "Malformazione_diagnosticata_1" = "COD_MALF1",
  "Malformazione_diagnosticata_2" = "COD_MALF2",
  "Malformazione_diagnosticata_3" = "COD_MALF3",
  "MALFORMAZIONI_MADRE" = "Malformazioni madre",
  "MALFORMAZIONI_PADRE" = "Malformazioni padre",
  "MALFORMAZIONI_GENITORI_MADRE" = "Malformazioni genitori madre",
  "MALFORMAZIONI_GENITORI_PADRE" = "Malformazioni genitori padre",
  "MALFORMAZIONI_PARENTI_MADRE" = "Malformazioni parenti madre",
  "MALFORMAZIONI_PARENTI_PADRE" = "Malformazioni parenti padre",
  "MALFORMAZIONI_FRATELLI_SORELLE" = "Malformazioni fratelli/sorelle",
  "nati_femmine" = "n_femmine",
  "nati_maschi" = "N_MASCHI",
  "VITALITA" = "VITALITA",
  "riscontro_autoptico" = "AUTOPSIA",
  "data_nascita_padre" = "AA_NAS_P",
  "STATO_CIVILE_MADRE" = "STATOCIV_M",
  "CITTADINANZA_M" = "CITTAD_M",
  "CONDIZIONE_PROF_PADRE" = "CONDIZ_P",
  "TITOLO_DI_STUDIO_PADRE" = "TITOLO_P",
  "CONDIZIONE_PROF_MADRE" = "CONDIZ_M",
  "TITOLO_DI_STUDIO_MADRE" = "TITOLO_M",
  "comune_residenza_madre" = "COM_RES_M",
  "PESO_MADRE_AL_PARTO" = "PESO_M_PARTO",
  "PESO_MADRE_PREGRAVIDICO" = "PESO_M",
  "ALTEZZA_MADRE" = "ALTEZZA_M",
  "ABITUDINE_AL_FUMO" = "TABACCO",
  "eta_gestazionale" = "ETA_GEST",
  "ETA_GESTAZIONALE_ALLA_DIAGNOSI" = "ETA_GEST",
  "CONCEPIMENTI_PRECEDENTI" = "CONCEP_PR",
  "PARTI_PRECEDENTI" = "PARTI_PR",
  "NUMERO_ABORTI_SPONTANEI" = "aborti",
  "NUMERO_IVG" = "ivg",
  "NUMERO_NATI_VIVI" = "nativivi",
  "NUMERO_NATI_MORTI" = "natimor",
  "NUMERO_TAGLI_CESAREI" = "CESAREI",
  "DIFETTO_ACCRESCIMENTO_FETALE" = "DIFF_ACCR",
  "MALATTIE_INSORTE_IN_GRAVIDANZA_1" = "Patologie in gravidanza 1",
  "MALATTIE_INSORTE_IN_GRAVIDANZA_2" = "Patologie in gravidanza 2",
  "metodi_PMA" = "PROC_ASS",
  "ECOGRAFIA_OLTRE22SETTIMANE" = "ECOGRAF",
  "NUMERO_ECOGRAFIE" = "N_ECOGRAF",
  "TEST_COMBINATO" = "TCOMBINATO",
  "VILLOCENTESI" = "VILLICOR",
  "AMNIOCENTESI" = "AMNIOCEN",
  "FETOSCOPIA" = "FETOSCOP",
  "CIRCONFERENZA_CRANICA" = "CFR_CRAN",
  "CONSANGUINEITA" = "CONSANG",
  "CARIOTIPO_DEL_NATO" = "CARIOTIPO",
  "dt_nas_m" = "dt_nas_m",
  "dt_parto" = "dt_parto",
  "Sesso" = "GENERE",
  "PESO" = "PESO"
)

Cedap2022_renamed <- dplyr::rename(Cedap2022, !!!mapping_2022_2023)

cols_2023 <- colnames(cedap_plus_2023)
cols_missing <- setdiff(cols_2023, colnames(Cedap2022_renamed))

for (c in cols_missing) {
  tipo <- class(cedap_plus_2023[[c]])[1]
  if (tipo %in% c("integer","numeric")) Cedap2022_renamed[[c]] <- as.numeric(NA)
  else if (tipo == "character") Cedap2022_renamed[[c]] <- as.character(NA)
  else if (tipo == "logical") Cedap2022_renamed[[c]] <- as.logical(NA)
  else if (tipo %in% c("Date","POSIXct")) Cedap2022_renamed[[c]] <- as.Date(NA)
  else Cedap2022_renamed[[c]] <- NA
}

Cedap2022_renamed <- Cedap2022_renamed[, cols_2023]
cat("Colonne 2022:", ncol(Cedap2022_renamed), "\n")
cat("Colonne 2023:", length(cols_2023), "\n")
print(all(colnames(Cedap2022_renamed) == colnames(cedap_plus_2023)))



#modifica cod_stab ----

names(cedap_plus_2023) <- tolower(names(cedap_plus_2023))

lookup <- cedap_plus_2023 %>%
  select(cod_pres, cod_stab) %>%
  distinct()

Cedap_2010_2023 <- Cedap_2010_2023 %>%
  left_join(lookup, by = "cod_pres", suffix = c("", "_new")) %>%
  mutate(
    cod_stab = if_else(!is.na(cod_stab_new),
                       as.character(cod_stab_new),
                       as.character(cod_stab))
  ) %>%
  select(-cod_stab_new)

cat("✅ cod_stab aggiornato correttamente dai valori del 2023\n")



# ---- Aggiungi variabile anno a ciascun dataset ----
Cedap2010_renamed$anno <- 2010
Cedap2011_renamed$anno <- 2011
Cedap2012_renamed$anno <- 2012
Cedap2013_renamed$anno <- 2013
Cedap2014_renamed$anno <- 2014
Cedap2015_renamed$anno <- 2015
Cedap2016_renamed$anno <- 2016
Cedap2017_renamed$anno <- 2017
Cedap2018_renamed$anno <- 2018
Cedap2019_renamed$anno <- 2019
Cedap2020_renamed$anno <- 2020
Cedap2021_renamed$anno <- 2021
Cedap2022_renamed$anno <- 2022
cedap_plus_2023$anno <- 2023

# ---- Tutte le colonne del 2023 minuscole ----
names(cedap_plus_2023) <- tolower(names(cedap_plus_2023))

# Tipi di riferimento dal 2023
types_2023 <- sapply(cedap_plus_2023, class)

# Lista dataset da uniformare
lista <- ls(pattern = "Cedap20[0-9]{2}_renamed$")

for (dfn in lista) {
  df <- get(dfn)
  
  # Nomi minuscoli
  names(df) <- tolower(names(df))
  
  # Aggiungi colonne mancanti
  missing <- setdiff(names(cedap_plus_2023), names(df))
  for (c in missing) df[[c]] <- NA
  
  # Ordine colonne: anno prima
  col_order <- c("anno", setdiff(names(cedap_plus_2023), "anno"))
  df <- df[, col_order]
  
  # Uniforma tipi sulle classi 2023
  for (c in names(df)) {
    tipo <- types_2023[[c]][1]
    
    if (tipo %in% c("integer", "numeric")) df[[c]] <- as.numeric(df[[c]])
    else if (tipo == "character") df[[c]] <- as.character(df[[c]])
    else if (tipo == "logical") df[[c]] <- as.logical(df[[c]])
    else if (tipo %in% c("Date", "POSIXct")) df[[c]] <- as.Date(df[[c]])
  }
  
  assign(dfn, df)
}

cat("✅ Dataset 2010-2022 uniformati alla struttura del 2023\n")

# ---- Bind finale ----
Cedap_2010_2023 <- bind_rows(
  Cedap2010_renamed,
  Cedap2011_renamed,
  Cedap2012_renamed,
  Cedap2013_renamed,
  Cedap2014_renamed,
  Cedap2015_renamed,
  Cedap2016_renamed,
  Cedap2017_renamed,
  Cedap2018_renamed,
  Cedap2019_renamed,
  Cedap2020_renamed,
  Cedap2021_renamed,
  Cedap2022_renamed,
  cedap_plus_2023
)

cat("📎 Unione completata\n")

# ---- Aggiorna cod_stab usando mapping 2023 ----
lookup <- cedap_plus_2023 %>%
  select(cod_pres, cod_stab) %>%
  distinct()

Cedap_2010_2023 <- Cedap_2010_2023 %>%
  left_join(lookup, by = "cod_pres", suffix = c("", "_new")) %>%
  mutate(cod_stab = if_else(!is.na(cod_stab_new), cod_stab_new, cod_stab)) %>%
  select(-cod_stab_new)

cat("✅ cod_stab aggiornato secondo corrispondenze 2023\n")

# ---- Controllo ----
cat("Totale righe:", nrow(Cedap_2010_2023), "\n")
cat("Totale colonne:", ncol(Cedap_2010_2023), "\n")
print(table(Cedap_2010_2023$anno))


Cedap_2010_2023 <- Cedap_2010_2023 %>%
  mutate(
    dt_nas_m = str_extract(dt_nas_m, "^[^ ]+"),  # rimuovo le ore
    dt_nas_m = parse_date_time(
      dt_nas_m,
      orders = c("dmy", "dmY", "Ymd", "Y-m-d")  # gestisce vari formati
    ),
    dt_nas_m = as.Date(dt_nas_m)  # solo anno-mese-giorno
  )

Cedap_2010_2023 <- Cedap_2010_2023 %>%
  mutate(
    dt_parto = str_extract(dt_parto, "^[^ ]+"),  # rimuovo le ore
    dt_parto = parse_date_time(
      dt_parto,
      orders = c("dmy", "dmY", "Ymd", "Y-m-d")  # gestisce vari formati
    ),
    dt_parto = as.Date(dt_parto)  # solo anno-mese-giorno
  )




# ---- Salvataggio ----
write.csv2(Cedap_2010_2023, file = paste0(wd, "/Cedap_2010_2023.csv"))

cat("File salvato: Cedap_2010_2023.csv\n")


















#--------------------------------------------------- REPORT ----

library(dplyr)
library(readr)

cedap_plus_2023 <- read_csv2("~/Google Drive/Drive condivisi/IMER/database/Cedap/cedap_plus_2023.csv")
Cedap_2010_2023 <- read_csv2("~/Google Drive/Drive condivisi/IMER/documenti/report/2025/tabelle_eurocat/Cedap_2010_2023.csv")

#### 1️⃣ NOMI MINUSCOLI E ANNO PRIMA SU CEDAP 2023 ----

# Lowercase column names
names(cedap_plus_2023) <- tolower(names(cedap_plus_2023))
names(Cedap_2010_2023) <- tolower(names(Cedap_2010_2023))

# Rimuovi colonna tecnica se presente
if ("...1" %in% colnames(Cedap_2010_2023)) {
  Cedap_2010_2023 <- Cedap_2010_2023 %>% select(-...1)
}

# Aggiungi anno = 2023 se manca
if (!"anno" %in% colnames(cedap_plus_2023)) {
  cedap_plus_2023$anno <- 2023
}

# Ordine colonne di riferimento
order_cols <- colnames(Cedap_2010_2023)
order_cols <- c("anno", setdiff(order_cols, "anno"))


#### 2️⃣ FORZA I TIPI DI TUTTE LE VARIABILI COME PLUS 2023 ----

# Tipi di riferimento dal 2023
types_ref <- sapply(cedap_plus_2023, class)

convert_types <- function(df, types_ref) {
  for (col in names(df)) {
    if (!col %in% names(types_ref)) next
    
    target_type <- types_ref[[col]][1]
    
    df[[col]] <- switch(
      target_type,
      "character" = as.character(df[[col]]),
      "numeric"   = as.numeric(df[[col]]),
      "double"    = as.numeric(df[[col]]),
      "integer"   = as.integer(df[[col]]),
      "logical"   = as.logical(df[[col]]),
      df[[col]]
    )
  }
  return(df)
}

# Convert types in full dataset
Cedap_2010_2023 <- convert_types(Cedap_2010_2023, types_ref)

# Riordina colonne anche nel 2023 dopo conversione e fix
cedap_plus_2023 <- cedap_plus_2023 %>%
  select(all_of(order_cols))


#### 3️⃣ SUBSET 2019–2023 ----

Cedap_2019_2023 <- Cedap_2010_2023 %>%
  filter(anno >= 2019 & anno <= 2023)


#### 4️⃣ CHECK ----

cat("\n✅ Tipi allineati al 2023")
cat("\n✅ Variabili tutte minuscolo")
cat("\n✅ 'anno' prima colonna")
cat("\n✅ Nessuna colonna extra tipo ...1")
cat("\n✅ Subset 2019-2023 creato\n")

print(table(Cedap_2019_2023$anno))
str(Cedap_2010_2023)


### 📚 LOAD LIBRARIES
library(dplyr)
library(tidyr)
library(readr)
library(skimr)     # skim() per descrittive
library(stringr)   # gestione stringhe
library(forcats)   # gestione fattori/categorie
library(purrr)
library(tableone)
library(naniar)

### ✅ TAB PER VARIABILi ----

#### 2️⃣ Definisci variabili numeriche continue e categoriche ----

# Variabili numeriche continue per descrittive statistiche
numeric_vars <- c(
  "nati_femmine", "nati_maschi", "eta_gestazionale", 
  "numero_ecografie", "circonferenza_cranica", 
  "peso_madre_al_parto", "peso", "peso_madre_pregravidico", 
  "altezza_madre", "concepimenti_precedenti", "numero_aborti_spontanei", 
  "numero_ivg", "numero_nati_vivi", "numero_nati_morti", 
  "numero_tagli_cesarei", "eta_gestazionale_alla_diagnosi"
)

# Tutte le altre variabili (anche codici numerici) come categoriche
categorical_vars <- setdiff(names(Cedap_2019_2023), numeric_vars)

####---------------------------------------------------- Tabella missing ----
missing_table <- Cedap_2019_2023 %>% 
  summarise(across(everything(), ~ sum(is.na(.)))) %>%
  pivot_longer(everything(), names_to = "variable", values_to = "n_missing") %>%
  mutate(pct_missing = round(n_missing / nrow(Cedap_2019_2023) * 100, 2))

missing_table

gg_miss_var(Cedap_2019_2023)

####------------------------------------------------TAB DESCRITTIVE NUMERICHE ----
numeric_vars <- c(
  "nati_femmine", "nati_maschi", "eta_gestazionale",
  "numero_ecografie", "circonferenza_cranica", "peso_madre_al_parto",
  "peso", "peso_madre_pregravidico", "altezza_madre",
  "concepimenti_precedenti", "numero_aborti_spontanei", "numero_ivg",
  "numero_nati_vivi", "numero_nati_morti", "numero_tagli_cesarei",
  "eta_gestazionale_alla_diagnosi"
)


table_num <- CreateTableOne(vars = numeric_vars, data = Cedap_2019_2023)

# Format stile "mean (SD)"
numeric_descr <- print(
  table_num,
  quote = FALSE,
  noSpaces = TRUE,
  printToggle = FALSE,
  missing = FALSE
)
numeric_descr_df <- as.data.frame(numeric_descr) %>%
  tibble::rownames_to_column("Variable")





####-------------------------------------------- TAB DESCRITTIVE CATEGORICHE SOCIODEMOG ----


# variabili selezionate
cat_vars_focus <- c(
  "condizione_prof_padre",
  "titolo_di_studio_padre",
  "condizione_prof_madre",
  "titolo_di_studio_madre",
  "sesso",
  "abitudine_al_fumo",
  "consanguineita",
  "cittadinanza_m",
  "comune_residenza_madre",
  "stato_civile_madre"
)

# funzione corretta
cat_summary <- function(df, var) {
  tab <- df %>%
    filter(!is.na(.data[[var]])) %>%
    count(.data[[var]], name = "n") %>%
    mutate(
      category = as.character(.data[[var]]),   # ✅ forza character
      pct = round(100 * n / sum(n), 2),
      variable = var
    ) %>%
    select(variable, category, n, pct)
  
  # categoria più frequente
  mode_rows <- tab %>% slice_max(n, n = 1)
  mode_cat <- paste(mode_rows$category, collapse = ", ")
  mode_pct <- unique(mode_rows$pct)
  
  tab %>%
    mutate(
      most_freq = mode_cat,
      pct_most_freq = mode_pct
    )
}

# applica
descr_cat <- map_dfr(cat_vars_focus, ~ cat_summary(Cedap_2019_2023, .x)) %>%
  arrange(variable, desc(n))

descr_cat


#### Risultati ----
# Missing
missing_table
gg_miss_var(Cedap_2019_2023)



### === CREA CARTELLA RISULTATI ===
# crea cartella di output dentro wd

output_path <- file.path(wd, "output_cedap_analisi")

# Se non esiste, ricreala
dir.create(output_path, showWarnings = FALSE)

# 
### === SALVA TABELLE CSV ===
# Salva tabelle numeriche
write.csv2(numeric_descr_df, file = file.path(output_path, "numeric_descr.csv"), row.names = FALSE)

# Salva descrittive categoriche
write.csv2(descr_cat, file = file.path(output_path, "categorical_descr_sociodemog.csv"), row.names = FALSE)

# Salva missing
write.csv2(missing_table, file = file.path(output_path, "missing_table_cedap19_23.csv"), row.names = FALSE)

# Salva grafico missing
ggsave(filename = file.path(output_path, "missing_plot_cedap19_23.png"), plot = gg_miss_var(Cedap_2019_2023))




###-----------------------------------------------------VARIABILI NEONATO----
vars_neonato_cat <- c(
  "cariotipo_del_nato","difetto_accrescimento_fetale","vitalita",
  "malformazione_diagnosticata_1","malformazione_diagnosticata_2","malformazione_diagnosticata_3",
  "malattie_insorte_in_gravidanza_1","malattie_insorte_in_gravidanza_2",
  "malformazioni_madre","malformazioni_padre","malformazioni_genitori_madre","malformazioni_genitori_padre",
  "malformazioni_parenti_madre","malformazioni_parenti_padre","malformazioni_fratelli_sorelle"
)

vars_neonato_num <- c("nati_femmine","nati_maschi","circonferenza_cranica")

###FUNZIONE CATEGORICHE
cat_summary <- function(df, var) {
  df %>%
    mutate(across(all_of(var), as.character)) %>%   # Forza char per evitare errori mix int/chr
    count(across(all_of(var)), name = "n") %>%
    mutate(
      pct = round(n / sum(n) * 100, 2),
      variable = var,
      category = !!sym(var)
    ) %>%
    select(variable, category, n, pct) %>%
    arrange(desc(n))
}

###FUNZIONE PER MODA (valore più frequente)
cat_mode <- function(df, var) {
  df %>%
    mutate(across(all_of(var), as.character)) %>%       
    count(across(all_of(var)), name = "n") %>%
    filter(n == max(n, na.rm = TRUE)) %>%   # Se più modali, prende la prima
    slice(1) %>%
    transmute(
      variable = var,
      most_freq = as.character(!!sym(var)),
      pct = round(n / sum(n) * 100, 2)
    )
}
neonato_cat_table <- map_dfr(vars_neonato_cat, ~cat_summary(Cedap_2019_2023, .x))

plot_cat <- neonato_cat_table %>%
  filter(pct >= 1)

#GRAFICO CATEG
# tieni solo categorie con almeno 1% (per grafico più leggibile)
plot_neonato_cat <- ggplot(plot_cat, aes(x = reorder(category, pct), y = pct)) +
  geom_col() +
  facet_wrap(~ variable, scales = "free_x") +
  coord_flip() +
  labs(
    title = "Distribuzione categorie variabili del neonato",
    x = "Categoria",
    y = "Percentuale (%)"
  ) +
  theme_minimal(base_size = 12)

# Mostra grafico
print(plot_neonato_cat)


###SALVA OUTPUT
write.csv2(neonato_cat_table, file.path(output_path,"neonato_categorical_distribution.csv"), row.names=FALSE)

#---- Salva grafici ----
ggsave(
  paste0(wd, "/output_cedap_analisi/neonato_categorical_plot.png"),
  plot = plot_neonato_cat,
  width = 12, height = 9, dpi = 300
)

ggsave(
  paste0(wd, "/output_cedap_analisi/neonato_categorical_plot.pdf"),
  plot = plot_neonato_cat,
  width = 12, height = 9
)


####-------------------------------------------- TAB DESCRITTIVE ANOMALIE----

vars_malfo <- c(
  "malformazione_diagnosticata_1",
  "malformazione_diagnosticata_2",
  "malformazione_diagnosticata_3"
)

# Converti a carattere prima
malfo_df <- Cedap_2019_2023 %>%
  mutate(across(all_of(vars_malfo), as.character)) %>%
  select(all_of(vars_malfo)) %>%
  pivot_longer(cols = everything(),
               names_to = "variabile",
               values_to = "codice") %>%
  filter(!is.na(codice) & codice != "" & codice != "0") # rimuove non casi

# Tabella frequenze codici
malfo_codici_tab <- malfo_df %>%
  group_by(codice) %>%
  summarise(
    n = n(),
    pct = round(100 * n / nrow(Cedap_2019_2023), 4)
  ) %>%
  arrange(desc(n))

print(malfo_codici_tab)

# Top 20 codici grafico
top_malfo <- malfo_codici_tab %>% slice_max(n, n = 20)

p_malfo <- ggplot(top_malfo, aes(x = reorder(codice, n), y = n)) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Top 20 codici di malformazioni (2019–2023)",
    x = "Codice malformazione",
    y = "Numero casi"
  ) +
  theme(
    panel.background = element_rect(fill = "white"),
    plot.background  = element_rect(fill = "white"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.text = element_text(size = 10),
    axis.title = element_text(size = 11, face = "bold"),
    plot.title = element_text(size = 13, face = "bold", hjust = 0.5)
  )
print(p_malfo)

# Salvataggio

write.csv(
  malfo_codici_tab,
  file = paste0(wd, "/output_cedap_analisi/tabella_codici_malformazioni.csv"),
  row.names = FALSE
)

ggsave(
  paste0(wd, "/output_cedap_analisi/grafico_codici_malformazioni_top20.png"),
  plot = p_malfo, dpi = 300, width = 8, height = 6
)
