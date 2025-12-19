
linkBySdoNeo = function(inKey, targetKey){
  l=match(inKey, targetKey)
  return(ifelse(!is.na(l)>0, l , 0))
}

getPlaceFromBirthCenter = function(inKey, lookupTable, lookupKey){
  l = match(inKey, pull(lookupTable$`lookupKey`))
  return(ifelse(!is.na(l)>0, pull(lookupTable[l, `lookupKey`]), 0))
}
