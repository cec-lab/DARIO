
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

#transcodifica eurocat - stage 4 e 5

transcode_complete <- function(df, eurocat_vars_list){
  
  missing_cols <- setdiff(eurocat_vars_list, names(df))
  
  # aggiungo tutte le colonne mancanti come stringa vuota
  for(col in missing_cols){
    df[[col]] <- ""
  }
  
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
  
  # SIB (DEVONO RESTARE BLANK)
  sib_vars <- c("sib1","sib2","sib3")
  for(v in intersect(sib_vars, names(df))){
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
    "folic_g14","extra_er_resmo","prevsib","cedap_linked","cod_pres","gentest"
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
  
  # MOTHER
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
  
  # FIX SPECIFICO ILLDUR (9 = missing valido)
  for(v in c("illdur1","illdur2")){
    if(v %in% names(df)){
      df[[v]] <- as.character(df[[v]])
      
      df[[v]][
        is.na(df[[v]]) | 
          trimws(df[[v]]) %in% c("", "9")
      ] <- "9"
      
      df[[v]] <- suppressWarnings(as.numeric(df[[v]]))
    }
  }
  
  # ORDINA COLONNE
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


# stage 2.1
parse_pipe <- function(x){
  
  x <- as.character(x)
  
  code <- str_split_i(x, "\\|", 2)
  desc <- str_split_i(x, "\\|", 3)
  
  code[is.na(code)] <- ""
  desc[is.na(desc)] <- ""
  
  return(list(code = code, desc = desc))
}




#stage 5 duplicati in Redcap ----

resolve_redcap_duplicates <- function(df){
  
  malfo_vars <- paste0("malfo", 1:8)
  
  df %>%
    group_by(prog_paz_neo) %>%
    group_modify(~{
      
      sub <- .x
      id  <- .y$prog_paz_neo
      
      # CASO NA → NON FARE NULLA
      if(is.na(id)){
        return(sub)
      }
      
      # SE NON DUPLICATO → PASSA
      if(nrow(sub) == 1){
        return(sub)
      }
      
      id <- as.character(id)
      cat("\nDUPLICATO REDCAP:", id, "\n")
      
      # ===============================
      # BLOCCO SU SYNDROME
      
      syndromes <- sub$syndrome
      syndromes <- syndromes[!is.na(syndromes) & trimws(syndromes) != ""]
      
      if(length(unique(syndromes)) > 1){
        
        print(data.frame(
          prog_paz_neo = id,
          syndrome = sub$syndrome
        ))
        
        stop(paste0(
          "ERRORE BLOCCANTE: syndrome diverse per prog_paz_neo = ",
          id
        ))
      }
      
      # ===============================
      # scegli riga migliore
      
      na_count <- apply(sub, 1, function(x){
        sum(is.na(x) | (is.character(x) & trimws(x) == ""))
      })
      
      best_row <- sub[which.min(na_count), , drop = FALSE]
      
      # ===============================
      # unione malfo
      
      all_malfo <- unlist(sub[, malfo_vars], use.names = FALSE)
      
      all_malfo <- all_malfo[
        !is.na(all_malfo) &
          trimws(all_malfo) != "" &
          all_malfo != "NA"
      ]
      
      all_malfo <- unique(all_malfo)
      
      for(i in seq_along(malfo_vars)){
        if(i <= length(all_malfo)){
          best_row[[ malfo_vars[i] ]] <- all_malfo[i]
        } else {
          best_row[[ malfo_vars[i] ]] <- ""
        }
      }
      
      return(best_row)
      
    }) %>%
    ungroup()
}


#date stage 5

date_vars <- c("birth_date", "death_date", "datemo")

clean_date <- function(x){
  
  x <- as.character(x)
  out <- rep("xxxx/xx/xx", length(x))
  
  # Codici speciali
  out[x == "222222"]     <- "2222/22/22"
  out[x == "333333"]     <- "3333/33/33"
  out[x == "999999"]     <- "xxxx/xx/xx"
  out[x == "xx-xx-xxxx"] <- "xxxx/xx/xx"
  out[x == "xxxx/xx/xx"] <- "xxxx/xx/xx"
  
  # yyyy-mm-dd
  idx_iso <- grepl("^\\d{4}-\\d{2}-\\d{2}$", x)
  out[idx_iso] <- format(as.Date(x[idx_iso], "%Y-%m-%d"), "%Y/%m/%d")
  
  # dd/mm/yyyy
  idx_full <- grepl("^\\d{2}/\\d{2}/\\d{4}$", x)
  out[idx_full] <- format(as.Date(x[idx_full], "%d/%m/%Y"), "%Y/%m/%d")
  
  # dd/mm/yy
  idx_short <- grepl("^\\d{2}/\\d{2}/\\d{2}$", x)
  if(any(idx_short)){
    tmp <- as.Date(x[idx_short], "%d/%m/%y")
    out[idx_short] <- format(tmp, "%Y/%m/%d")
  }
  
  return(out)
}
