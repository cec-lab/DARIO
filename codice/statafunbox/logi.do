/*  DIFFERENZE DI GENERE ALLA DIAGNOSI DI ACROMEGALIA

	REGRESSION ANALYSIS
    
	GNU GPLv3

    Copyright (C) 2024  Marco Manfrini,PhD


     This program is free software: you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
     the Free Software Foundation, either version 3 of the License, or
     (at your option) any later version.

     This program is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.

     You should have received a copy of the GNU General Public License
     along with this program.  If not, see <https://www.gnu.org/licenses/>.

     marco.manfrini@unife.it
*/

/* CLEAR ENV */

// clear

/* PATH */

local wd I:\Drive condivisi\Lavori in corso\cristilli
display "`wd'"
cd "`wd'"

local indir `wd'\preprocess
display "`indir'"

local outdir `wd'\out\regression
display "`outdir'"

/* DATA LOAD */

pwd
 use "`indir'\cohort.dta"

/* UNIVARIABLE NUMERO VISITE

tabulate center, summarize(number_of_visit_before_diagnosis)


local regressors center i.center age sex cluster
display "`regressors'"

putexcel set "`outdir'\lm_uni_numero_visite.xlsx", replace
foreach v in `regressors' {
	putexcel set "`outdir'\lm_uni_numero_visite.xlsx", sheet("`v'") modify
	display "`v'"
	regress number_of_visit_before_diagnosis `v'
	putexcel (A1) = etable
}*/

/* UNIVARIABLE TERAPIA MED/CHIR 

local regressors center i.center age sex cluster
display "`regressors'"

putexcel set "`outdir'\logi_uni_surgery.xlsx", replace
foreach v in `regressors' {
	putexcel set "`outdir'\logi_uni_surgery.xlsx", sheet("`v'") modify
	display "`v'"
	logistic surgery `v'
	putexcel (A1) = etable
}*/

/* UNIVARIABLE RISPOSTA ALLA TERAPIA Healing_after_surgery 

local regressors center i.center age sex cluster
display "`regressors'"

putexcel set "`outdir'\logi_uni_healing_after_surgery.xlsx", replace
foreach v in `regressors' {
	putexcel set "`outdir'\logi_uni_healing_after_surgery.xlsx", sheet("`v'") modify
	display "`v'"
	logistic healing_after_surgery `v'
	putexcel (A1) = etable
}*/

/* UNIVARIABLE RITARDO DIAGNOSI */

tabulate center, summarize(years_symptoms_diagnosis)


local regressors center i.center age sex cluster
display "`regressors'"

putexcel set "`outdir'\lm_uni_years_symptoms_diagnosis.xlsx", replace
foreach v in `regressors' {
	putexcel set "`outdir'\lm_uni_years_symptoms_diagnosis.xlsx", sheet("`v'") modify
	display "`v'"
	regress years_symptoms_diagnosis `v'
	putexcel (A1) = etable
}

/* COLLECT 

NON SCRIVE IL DOCX

putdocx clear
putdocx begin
foreach v in `regressors' {
	logistic AKI_binary `v', cformat(%6.3f) 
	collect get _r_b _r_lb _r_ci
	collect label levels result _r_b "OR", modify
	collect label levels result _r_lb "95% l.b.", modify
	collect label levels result _r_ub "95% u.b.", modify
	putdocx collect
	
}

collect layout (colname) (result) (cmdset)

putdocx save "I:\Drive condivisi\Lavori in corso\VitC\2024\out\logi.docx", replace */