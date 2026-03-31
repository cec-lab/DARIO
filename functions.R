
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