
linkBySdoNeo = function(inKey, targetKey){
  l=match(inKey, targetKey)
  return(ifelse(!is.na(l)>0, l , 0))
}

getPlaceFromBirthCenter = function(inKey, lookupTable, lookupKey){
  l = match(inKey, pull(lookupTable$`lookupKey`))
  return(ifelse(!is.na(l)>0, pull(lookupTable[l, `lookupKey`]), 0))
}


fill_from_sdo <- function(redcap, sdo){
  
  idx <- match(redcap$prog_paz_neo, sdo$prog_paz_neo)
  
  vars <- setdiff(intersect(names(redcap), names(sdo)),
                  c("record_id","centre","numloc","data_source","prog_paz_neo"))
  
  for(v in vars){
    
    valid_rows <- which(!is.na(idx))
    
    if(is.character(redcap[[v]])){
      missing_idx <- is.na(redcap[[v]][valid_rows]) | redcap[[v]][valid_rows] == ""
    } else {
      missing_idx <- is.na(redcap[[v]][valid_rows])
    }
    
    missing <- valid_rows[missing_idx]
    
    if(length(missing) > 0){
      redcap[[v]][missing] <- sdo[[v]][ idx[missing] ]
    }
  }
  
  return(redcap)
}





transcode_complete <- function(df, eurocat_vars_list){
  
  # ---------------------------
  # 0. ALLINEAMENTO SCHEMA EUROCAT
  # ---------------------------
  missing_cols <- setdiff(eurocat_vars_list, names(df))
  
  # aggiungo tutte le colonne mancanti come stringa vuota
  for(col in missing_cols){
    df[[col]] <- ""
  }
  
  # ---------------------------
  # 1. FILL MISSING DATA
  # ---------------------------
  
  if("weight" %in% names(df))     df$weight[is.na(df$weight)] <- 9999
  if("gestlength" %in% names(df)) df$gestlength[is.na(df$gestlength)] <- 99
  
  # DATE
  if("datemo" %in% names(df))
    df$datemo[is.na(df$datemo)] <- "xxxx/xx/xx"
  
  if("death_date" %in% names(df))
    df$death_date[is.na(df$death_date)] <- "xxxx/xx/xx"
  
  # MALFO
  malfo_vars <- paste0("malfo", 1:8)
  for(v in malfo_vars){
    if(v %in% names(df)){
      df[[v]][is.na(df[[v]])] <- ""
    }
  }
  
  # STRINGHE sp_
  sp_vars <- names(df)[grepl("^sp_", names(df))]
  for(v in sp_vars){
    df[[v]][is.na(df[[v]])] <- ""
  }
  
  # NUMERICI (1 cifra → 9)
  vars_9 <- c(
    "nbrbaby","nbrmalf","sex","type","survival","whendisc","condisc",
    "karyo","surgery","pm","presyn","matdiab",
    paste0("premal",1:8),
    "socf","cov_severity","consang","sibanom",
    "moanom","faanom","matedu","socm",
    "amniocentesis","chorvilsam","ultrason",
    "pre_sa","pre_topfa","pre_live","pre_still",
    "inf_cov_test","imm_cov_test","oth_cov_test",
    "firstpre","firsttri","assconcept","migrant",
    "folic_g14","extra_er_resmo","prevsib","cedap_linked","cod_pres"
  )
  
  for(v in intersect(vars_9, names(df))){
    df[[v]][is.na(df[[v]])] <- 9
  }
  
  # NUMERICI (2 cifre → 99)
  vars_99 <- c(
    "totpreg","agedisc","agefa","agemo",
    "bmi","mo_smoking","mo_alcohol","start_cov"
  )
  
  for(v in intersect(vars_99, names(df))){
    df[[v]][is.na(df[[v]])] <- 99
  }
  
  # SPECIALI
  if("occupmo" %in% names(df))        df$occupmo[is.na(df$occupmo)] <- 9999
  if("mocitizenship" %in% names(df))  df$mocitizenship[is.na(df$mocitizenship)] <- 999
  
  # STRINGHE GENERICHE
  vars_char <- c(
    "pm_notes","illbef1","illbef2","illdur1","illdur2",
    "omim","orpha","extra_drugs",
    "drugs1","drugs2","drugs3","drugs4","drugs5",
    "sdo_number","resmo","imer_key","prog_paz_neo",
    "genrem","syndrome"
  )
  
  for(v in intersect(vars_char, names(df))){
    df[[v]][is.na(df[[v]])] <- ""
  }
  
  # ---------------------------
  # 2. ORDINA COLONNE
  # ---------------------------
  df <- df[, eurocat_vars_list]
  
  return(df)
}


standardize_types <- function(df, vars_numeric){
  
  vars_numeric <- intersect(vars_numeric, names(df))
  
  # separo numeric e non numeric
  vars_char <- setdiff(names(df), vars_numeric)
  
  df <- df %>%
    mutate(across(all_of(vars_char), as.character)) %>%
    mutate(across(all_of(vars_numeric), ~ suppressWarnings(as.numeric(.))))
  
  return(df)
}


#2.1
parse_pipe <- function(x){
  
  x <- as.character(x)
  
  code <- str_split_i(x, "\\|", 2)
  desc <- str_split_i(x, "\\|", 3)
  
  code[is.na(code)] <- ""
  desc[is.na(desc)] <- ""
  
  return(list(code = code, desc = desc))
}