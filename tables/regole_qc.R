regole <- c(
  "is.na(centre)",
  "is.na(numloc)",
  
  "survival == 2 & ((is.na(death_date) | death_date == '' | is.na(birth_date) | birth_date == '') | (ymd(death_date) - ymd(birth_date) < -7 | ymd(death_date) - ymd(birth_date) > 7))",
  
  "sex == 3 & !(grepl('^Q56', malfo1) | grepl('^Q56', malfo2) | grepl('^Q56', malfo3) | grepl('^Q56', malfo4) | grepl('^Q56', malfo5) | grepl('^Q56', malfo6) | grepl('^Q56', malfo7) | grepl('^Q56', malfo8))",
  "sex == 9 & (type %in% c(1,2))",
  "sex == 9 & !(pm %in% c(3,4,9))",
  
  "nbrbaby > 1 & nbrbaby != 9 & is.na(nbrmalf)",
  "nbrbaby > 1 & nbrbaby != 9 & nbrmalf == 9",
  "nbrbaby > 1 & nbrbaby < 8 & nbrmalf > 0 & nbrmalf < 9 & nbrmalf > nbrbaby",
  "nbrbaby >= 2 & nbrbaby != 9 & (is.na(sp_twin) | sp_twin == '')",
  
  "is.na(type)",
  "type == 4 & !(whendisc %in% c(6,9))",
  "type == 4 & presyn == 2",
  "type == 2 & gestlength < 20",
  "type == 1 & pm %in% c(1,2,4) & !(is.na(death_date) | death_date == '')",
  
  "is.na(civreg)",
  "is.na(weight)",
  "is.na(gestlength)",
  
  "firstpre == 1 & !is.na(agedisc) & agedisc != 99 & agedisc >= 14",
  "firstpre == 3 & !is.na(agedisc) & agedisc != 99 & agedisc < 22",
  "firstpre == 2 & !is.na(agedisc) & agedisc != 99 & (agedisc < 14 | agedisc > 21)",
  
  "survival == 2 & (is.na(death_date) | death_date == '') & type == 1",
  "survival == 9 & (is.na(death_date) | death_date == '')",
  
  "!is.na(agemo) & agemo != 99 & (agemo < 10 | agemo > 60)",
  "!is.na(bmi) & bmi != 99 & (bmi < 15 | bmi > 50)",
  "is.na(residmo)",
  "!is.na(totpreg) & !(totpreg %in% c(0:12,99))",
  
  "whendisc == 6 & presyn != 1 & !(is.na(syndrome) | syndrome == '')",
  "is.na(whendisc)",
  
  "whendisc == 6 & (is.na(syndrome) | syndrome == '') & (!(premal1 %in% c(2,9)) | !(premal2 %in% c(2,9)) | !(premal3 %in% c(2,9)) | !(premal4 %in% c(2,9)) | !(premal5 %in% c(2,9)) | !(premal6 %in% c(2,9)) | !(premal7 %in% c(2,9)) | !(premal8 %in% c(2,9)))",
  
  "whendisc == 7 & survival == 1",
  "whendisc == 6 & condisc != 1",
  "whendisc == 7 & condisc != 2",
  "whendisc == 6 & firstpre %in% c(8,9,10)",
  "whendisc == 7 & !(type %in% c(3,4))",
  
  "condisc == 2 & survival %in% c(1,3)",
  "condisc == 2 & (is.na(death_date) | death_date == 'xxxx/xx/xx')",
  
  "firstpre %in% c(1:7,11) & presyn != 1",
  "firstpre %in% c(1:7,11) & !(premal1 == 1 | premal2 == 1 | premal3 == 1 | premal4 == 1 | premal5 == 1 | premal6 == 1 | premal7 == 1 | premal8 == 1)",
  "firstpre %in% c(1:7,11) & condisc == 2",
  "firstpre == 7 & (is.na(sp_firstpre) | sp_firstpre == '')",
  "firstpre %in% c(6,11) & karyo == 3",
  "karyo == 1 & (is.na(sp_karyo) | sp_karyo == '')",
  "presyn == 1 & karyo == 3 & gentest == 3",
  
  "(is.na(syndrome) | syndrome == '') & (is.na(malfo1) | malfo1 == '')",
  "!(is.na(omim) | omim == '') & (is.na(syndrome) | syndrome == '')",
  
  "nbrbaby == 2 & nbrmalf == 2 & (is.na(prevsib) | prevsib != 1)",
  
  "firsttri %in% c(2,9) & !(is.na(drugs1) | drugs1 == '')",
  "firsttri %in% c(2,9) & !(is.na(drugs2) | drugs2 == '')",
  "firsttri %in% c(2,9) & !(is.na(drugs3) | drugs3 == '')",
  "firsttri %in% c(2,9) & !(is.na(drugs4) | drugs4 == '')",
  "firsttri %in% c(2,9) & !(is.na(drugs5) | drugs5 == '')",
  "firsttri %in% c(2,9) & !(is.na(extra_drugs) | extra_drugs == '')",
  
  "!(is.na(malfo1) | malfo1 == '') & (is.na(sp_malfo1) | sp_malfo1 == '')",
  "!(is.na(malfo2) | malfo2 == '') & (is.na(sp_malfo2) | sp_malfo2 == '')",
  "!(is.na(malfo3) | malfo3 == '') & (is.na(sp_malfo3) | sp_malfo3 == '')",
  "!(is.na(malfo4) | malfo4 == '') & (is.na(sp_malfo4) | sp_malfo4 == '')",
  "!(is.na(malfo5) | malfo5 == '') & (is.na(sp_malfo5) | sp_malfo5 == '')",
  "!(is.na(malfo6) | malfo6 == '') & (is.na(sp_malfo6) | sp_malfo6 == '')",
  "!(is.na(malfo7) | malfo7 == '') & (is.na(sp_malfo7) | sp_malfo7 == '')",
  "!(is.na(malfo8) | malfo8 == '') & (is.na(sp_malfo8) | sp_malfo8 == '')",
  
  "!is.na(moanom) & moanom %in% c(1,2,3) & (is.na(sp_moanom) | sp_moanom == '')",
  "!is.na(sibanom) & sibanom %in% c(1,2,3) & (is.na(sp_sibanom) | sp_sibanom == '')",
  "!(is.na(syndrome) | syndrome == '') & (is.na(sp_syndrome) | sp_syndrome == '')",
  "gentest == 7 & (is.na(sp_gentest) | sp_gentest == '')",
  "consang == 1 & (is.na(sp_consang) | sp_consang == '')",
  "!is.na(faanom) & faanom %in% c(1,2,3) & (is.na(sp_faanom) | sp_faanom == '')",
  
  "whendisc == 6 & condisc == 2 & !(type %in% c(2,3))",
  
  "survival == 2 & !(is.na(death_date) | death_date == '') & !(is.na(birth_date) | birth_date == '') & !grepl('x', death_date) & !grepl('x', birth_date) & abs(as.Date(death_date, '%d/%m/%Y') - as.Date(birth_date, '%d/%m/%Y')) > 7",
  
  "!is.na(agemo) & totpreg != 99 & ((agemo <= 15 & totpreg > 1) | (agemo >= 16 & agemo <= 19 & totpreg > 2))",
  
  "!(is.na(illdur1) | illdur1 == '') & nchar(illdur1) > 4",
  "!(is.na(illdur2) | illdur2 == '') & nchar(illdur2) > 4",
  
  "survival == 1 & type != 1",
  "survival == 3 & type != 1",
  
  "(!is.na(sex) & !(sex %in% c(1,2,3,9)))",
  "(!is.na(type) & !(type %in% c(1,2,3,4,9)))",
  "(!is.na(civreg) & !(civreg %in% c(1,2,3,9)))",
  "(!is.na(survival) & !(survival %in% c(1,2,3,9)))",
  "(!is.na(whendisc) & !(whendisc %in% c(1,2,3,4,5,6,7,9,10)))",
  "(!is.na(condisc) & !(condisc %in% c(1,2,9)))",
  "(!is.na(firstpre) & !(firstpre %in% c(1:11)))",
  "(!is.na(karyo) & !(karyo %in% c(1,2,3,4,8,9)))",
  "(!is.na(gentest) & !(gentest %in% c(1,2,3,9)))",
  "(!is.na(pm) & !(pm %in% c(1,2,3,4,9)))",
  "(!is.na(presyn) & !(presyn %in% c(1,2,9)))",
  "(!is.na(consang) & !(consang %in% c(0,1,9)))",
  "(!is.na(sibanom) & !(sibanom %in% c(1,2,3,4,9)))",
  "(!is.na(moanom) & !(moanom %in% c(1,2,3,4,9)))",
  "(!is.na(faanom) & !(faanom %in% c(1,2,3,4,9)))",
  "(!is.na(nbrbaby) & !(nbrbaby %in% c(1:9)))",
  "!(is.na(nbrmalf) | nbrmalf == '') & !(nbrmalf %in% c(1:6,9))",
  "(!is.na(firsttri) & !(firsttri %in% c(1,2,4,9)))",
"whendisc == 6 & !(is.na(agedisc) | agedisc == 99)",
"nbrbaby != 1 & !(is.na(nbrmalf) | nbrmalf == '')",
"nbrbaby != 1 & !(is.na(sp_twin) | sp_twin == '')",
"whendisc != 1 & !(premal1 %in% c(1) | premal2 %in% c(1) | premal3 %in% c(1) | premal4 %in% c(1) | premal5 %in% c(1) | premal6 %in% c(1) | premal7 %in% c(1) | premal8 %in% c(1))",
"!is.na(sp_karyo) & grepl('xy', tolower(sp_karyo)) & sex != 2",
"!is.na(sp_karyo) & grepl('xx', tolower(sp_karyo)) & sex != 1")