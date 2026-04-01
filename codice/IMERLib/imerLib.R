# imerLib
# Library of functions to manage IMER data

# FUNCTIONS

# Function findICDCases ----
#  @description 
#  Find cases by ICD
#  @param codes:  vector of codes to search for
#  @param data:   matrix (or dataset or tibble) with columns that contains ICD codes
#  @return: list of indices of selected cases

findICDCases<-function(codes, data){
  selected<- NULL
  map<- NULL
  for(c in 1:dim(data)[2]){
    for(code in codes){
      srow<-grep(paste0("^",code), data[,c])
      if(length(srow>0)){
        map<-rbind(map,
                   cbind(srow, code))
        selected<-c(selected, srow)  
      }
    }
  }
  return(list(selected,map))
}

# Function findResidentCases ----
#  @description 
#  Find cases by residence code
#  @param codes:  vector of codes to search for (CodResidISTAT, file: "I:\Drive condivisi\IMER\CodiciComuni.xlsx")
#  @param data:   matrix (or dataset or tibble) with columns that contains residence codes
#  @return: list of indices of selected cases

findResidentCases<-function(pcodes, ccodes, data){
  selected<- NULL
  map<- NULL
  codes<-data.frame(pcodes, ccodes)
    for(i in 1:dim(codes)[1]){
      prow<-grep(paste0("^",codes[i,1], "$"), data[,1])
      data_filtered<-data[prow,]
      if(length(prow>0)){
        crow<-grep(paste0("^",codes[i,2], "$"), data_filtered[,2])
        map<-rbind(map,
                   cbind(crow, codes[i,"pcodes"], codes[i, "ccodes"]))
        selected<-c(selected, crow)  
      }
    }
  
  return(list(selected,map))
}

# Function birthByMonth ----
# @description
# Summarize cases by month
# @param data:   matrix (or dataset or tibble) with columns that contains 'Mese'
# @return: cumamry of cases by month

birthByMonth<-function(){}

# Function birthByYear ----
# @description
# Summarize cases by year
# @param data:   matrix (or dataset or tibble) with columns that contains 'Anno'
# @return: cumamry of cases by month

birthByYear<-function(data){
  dset %>% group_by(Anno) %>%
    summarize(Anno, count)
}

# Function imerKeyTable ----
# @description
# This functions build the imer key table from a dataset  
# @param dset: dataset 
# @param indexKey: index of key var for strata
# @param fact: factor vars names
# @param norm: non normal vars names
# @param showAll: show all levels
# @return: a table of aggregated data by IMER key
imerKeyTable<-function(dset, indexKey=1, fact=NULL, nnorm=NULL, showAll=T){
  
  # Check number of strata> 1
  if( n_distinct(dset[,indexKey])<2 ){
    
    # One strata
    tabOverall<-CreateTableOne(vars = colnames(dset),
                               factorVars = fact,
                               data = dset,
                               test = FALSE,
                               includeNA = FALSE)
    tabMatOverall <- print(tabOverall, quote = FALSE, noSpaces = TRUE, printToggle = TRUE, exact = fact, nonnormal=nnorm, showAllLevels = TRUE)  
    tabImerKey<-tabMatOverall[(-2), c(1,2)]
    colnames(tabImerKey)<-c("Livelli", "Totali") 
  } else {
    
    # 2+ strata
    tab<-CreateTableOne(vars = colnames(dset),
                        factorVars = fact,
                        data = dset,
                        strata = colnames(dset)[indexKey],
                        test = TRUE,
                        includeNA = FALSE)
    tabMat <- print(tab, quote = FALSE, noSpaces = TRUE, printToggle = TRUE, exact = fact, showAllLevels = TRUE)
    
    tabOverall<-CreateTableOne(vars = colnames(dset),
                               factorVars = fact,
                               data = dset,
                               test = FALSE,
                               includeNA = FALSE)
    tabMatOverall <- print(tabOverall, quote = FALSE, noSpaces = TRUE, printToggle = TRUE, exact = fact, nonnormal=nnorm, showAllLevels = TRUE)
    
    tabImerKey<-cbind(tabMat[c(-2,-3,-4,-5), c(1,3,2,4,5)], tabMatOverall[c(-2,-3,-4,-5), c(2)], tabMat[c(-2,-3,-4,-5), c(6)])
    
    colnames(tabImerKey)<-c("Livelli", "Isolate", "Cromosomiche", "Multiple", "Sindromiche", "Totali", "p-value")  
  }
  
  
  return(tabImerKey)
}

# Function dataSummary ----
# @description
#
# @param df: IMER data frame
# @param group_var: grouping variable
# @param sum_var: summary variable
# @return: a table with summary statistics by grouping variable
dataSummary <- function(df, group_var, sum_var) {
  
  group_var<-ensym(group_var)
  sum_var<-ensym(sum_var)
  
  is_categorical <- 
    is.character(eval(expr(`$`(df, !!sum_var)))) |
    is.factor(eval(expr(`$`(df, !!sum_var)))) 
  
  category_lbls <- c("Cromsomiche (n)"="val_C",
                     "Cardiache (n)"="val_H",
                     "Isolate (n)"="val_I",
                     "Multiple (n)"="val_M",
                     "Condizioni note (n)"="val_S",
                     "Cromosomiche (%)"="pct_C",
                     "Cardiache (%)"="pct_H",
                     "Isolate (%)"="pct_I",
                     "Multiple (%)"="pct_M",
                     "Condizioni note (%)"="pct_S"
                     ) 
  
  if (is_categorical) {
    
    df_out <-
      df |>
      dplyr::group_by(!!group_var)  |> 
      dplyr::mutate(N = dplyr::n()) |> 
      dplyr::ungroup() |> 
      dplyr::group_by(!!group_var, !!sum_var) |> 
      dplyr::summarize(
        val = dplyr::n(),
        pct = dplyr::n()/mean(N),
        .groups = "drop"
      ) |> 
      tidyr::pivot_wider(
        id_cols = !!sum_var, names_from = !!group_var,
        values_from = c(val, pct)
      ) |> 
      dplyr::rename(all_of(category_lbls))
      
    
  } else {
    
    print("Not yet implemented for numerical variables")
    return(NULL)
    
     # category_lbl <-
     #   sprintf(
     #     "%s (%s)",
     #     attr(eval(expr(`$`(df, !!sum_var))), "label"),
     #     attr(eval(expr(`$`(df, !!sum_var))), "units")
     #   )
     # 
     # df_out <-
     #   df |>
     #   dplyr::group_by(!!group_var) |>
     #   dplyr::summarize(
     #     n = sum(!is.na(!!sum_var)),
     #     mean = mean(!!sum_var, na.rm = TRUE),
     #     sd = sd(!!sum_var, na.rm = TRUE),
     #     median = median(!!sum_var, na.rm = TRUE),
     #     min = min(!!sum_var, na.rm = TRUE),
     #     max = max(!!sum_var, na.rm = TRUE),
     #     min_max = NA,
     #     .groups = "drop"
     #   ) |>
     #   tidyr::pivot_longer(
     #     cols = c(n, mean, median, min_max),
     #     names_to = "label",
     #     values_to = "val"
     #   ) |>
     #   dplyr::mutate(
     #     sd = ifelse(label == "mean", sd, NA),
     #     max = ifelse(label == "min_max", max, NA),
     #     min = ifelse(label == "min_max", min, NA),
     #     label = dplyr::recode(
     #       label,
     #       "mean" = "Mean (SD)",
     #       "min_max" = "Min - Max",
     #       "median" = "Median"
     #     )
     #   ) |>
     #   tidyr::pivot_wider(
     #     id_cols = label,
     #     names_from = !!group_var,
     #     values_from = c(val, sd, min, max)
     #   )
  }
  
  return(df_out)
}
#Function getPPoints ----
# @description
# @param tmp:
# @param group:
# @param index:
# @return:
getPPoints<-function(tmp, group, index){
  tt<-as.numeric(tmp["Totali", index])
  pp<-as.numeric(tmp["Popolazione", index])
  PrevTot=round(tt/pp*10000, 2)
  conf.ll<-round((1.96/2 - sqrt(tt + 0.02))^2/pp*10000,2)
  conf.ul<-round((1.96/2 + sqrt(tt + 0.96))^2/pp*10000,2)
  pps<-data.frame(Anno=tmp["Anno", index],
                  PrevTot=PrevTot,
                  Pll=conf.ll,
                  Pul=conf.ul,
                  group=group)
  return(pps)
}
# Function calcPrev ----
# @description
# @param oc: observed cases
# @param rp: reference population
# @return: a list containing prevalence (x10000) and its 95% confidence interval
calcPrev<-function(oc, rp){
  PrevTot=round(oc/rp*10000, 2)
  conf.ll<-round((1.96/2 - sqrt(oc + 0.02))^2/rp*10000,2)
  conf.ul<-round((1.96/2 + sqrt(oc + 0.96))^2/rp*10000,2)  
  return(list(prev=PrevTot, ll=conf.ll, ul=conf.ul))
}