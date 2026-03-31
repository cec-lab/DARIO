/* DATA ANALISYS */
/* Marco Manfrini */
/* 26/07/2024 */

/* CLEAR ENV */

clear

/* PATH */

local wd G:\Il mio Drive\lavori_in_corso\VIS\studio_revideo\Raccolta Dati\Raccolta Dati
display "`wd'"
cd "`wd'"

local indir `wd'\preprocess
display "`indir'"

local outdir `wd'\out
display "`outdir'"

/* DATA LOAD */

pwd
use "`indir'\dset.dta"
local fileName `outdir'\table1.xlsx
display "`fileName'"

*encode ID_paziente, generate(n_ID_paziente)

/* DISTRIBUTION NUMERIC */
/*
local numericVars MD_OD_dB MD_OS_dB PSD_OD_dB PSD_OS_dB RNFL_OD_um RNFL_OS_um CUP_DISC_OD CUP_DISC_OS

tempname memhold 
tempfile results
postfile `memhold' str12 varname pvalue using "`results'"
ds, has(type numeric)
return list
foreach v in `numericVars' {
	display "`v'"
	swilk `v'
	post `memhold' ("`v'") (r(p))
}
postclose `memhold'
use "`results'", clear
describe

export excel using "`outdir'/\/swilk.xlsx", firstrow(varlabels) replace

use "`indir'\dset.dta"

local numericVars MD_OD_dB MD_OS_dB PSD_OD_dB PSD_OS_dB RNFL_OD_um RNFL_OS_um CUP_DISC_OD CUP_DISC_OS

foreach v in `numericVars' {
	display "`v'"
	histogram `v',
	graph export "`outdir'/\/`v'.jpg", replace
}
 

/* TABLE 1 */

dtable MD_OD_dB MD_OS_dB i.n_MD_ODP i.n_MD_OSP PSD_OD_dB PSD_OS_dB i.n_PSD_ODP i.n_PSD_OSP RNFL_OD_um RNFL_OS_um CUP_DISC_OD CUP_DISC_OS, ///
continuous(`numericVars', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) sformat("[%s]" iqi) ///
by(TIME, nototals tests) /// 
title(Table 1. Summary by group.) ///
note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
note(Frequency (%): p-value from Pearson test.) ///
export("`outdir'/table1.docx", replace)
*/
/* CHANGE ANALISYS W_BASELINE */

/* DATA LOAD */

pwd
use "`indir'\dset.dta"
local fileName `outdir'\table1.xlsx
display "`fileName'"

mixed MD_OS_dB_delta i.TIME MD_OS_dB_baseline if TIME !=0, || n_ID_paziente:, covariance(exchangeable) vce(robust)

 anova MD_OS_dB_delta c.MD_OS_dB_baseline TIME


/* LINE PLOT */
/*
line MD_OD_dB MD_OS_dB TIME, by(n_ID_paziente, note("")) title("MD_dB")
graph export "`outdir'/MD_dB_by_patient.jpg", replace

line PSD_OD_dB PSD_OS_dB TIME, by(n_ID_paziente, note("")) title("PSD_dB")
graph export "`outdir'/PSD_dB_by_patient.jpg", replace

line RNFL_OD_um RNFL_OS_um TIME, by(n_ID_paziente, note("")) title("RNFL_um")
graph export "`outdir'/RNFL_um_by_patient.jpg", replace

line CUP_DISC_OD CUP_DISC_OS TIME, by(n_ID_paziente, note("")) title("CUP_DISC")
graph export "`outdir'/CUP_DISC_by_patient.jpg", replace

/* BAR PLOT */

graph bar (count), over(MD_ODP) by(n_ID_paziente, note("")) title("MD_ODP")
graph export "`outdir'/MD_ODP_by_patient.jpg", replace

graph bar (count), over(MD_OSP) by(n_ID_paziente, note("")) title("MD_OSP")
graph export "`outdir'/MD_OSP_by_patient.jpg", replace

graph bar (count), over(PSD_ODP) by(n_ID_paziente, note("")) title("MD_OSP")
graph export "`outdir'/PSD_ODP_by_patient.jpg", replace

graph bar (count), over(PSD_OSP) by(n_ID_paziente, note("")) title("MD_OSP")
graph export "`outdir'/PSD_OSP_by_patient.jpg", replace
*/
/* VFQ25 */

/* DATA LOAD 

pwd
use "`indir'\WFQ25_wscore.avg.dta"
local fileName `outdir'\table2.xlsx
display "`fileName'"

/* TABLE 2 */

dtable mean, ///
continuous(`numericVars', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) sformat("[%s]" iqi) ///
by(time, nototals tests) /// 
title(Table 2. VFQ25 SCORE by time.) ///
note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
note(Frequency (%): p-value from Pearson test.) ///
export("`outdir'/table2.docx", replace)

/* LINE PLOT */

line mean time, by(n_ID_paziente, title("VFQ25 SCORE") note("")) 
graph export "`outdir'/VFQ25_SCORE_by_patient.jpg", replace

*/

/* DATA LOAD */

/*pwd
use "`indir'\subscaleDataset.dta"
local fileName `outdir'\table3.xlsx
display "`fileName'"*/

/* LINE PLOT 

line mean time if subscale=="General Health", by(n_ID_paziente, title("VFQ25 SCORE General Health") note("")) 
graph export "`outdir'/VFQ25_SCORE_General_Health.jpg", replace

line mean time if subscale=="General Health"


line mean time if subscale=="General Vision", by(n_ID_paziente, title("VFQ25 SCORE General Vision") note("")) 
graph export "`outdir'/VFQ25_SCORE_General_Vision.jpg", replace

line mean time if subscale=="Ocular Pain", by(n_ID_paziente, title("VFQ25 SCORE Ocular Pain") note("")) 
graph export "`outdir'/VFQ25_SCORE_Ocular_Pain.jpg", replace

line mean time if subscale=="Near Activities", by(n_ID_paziente, title("VFQ25 SCORE Near Activities") note("")) 
graph export "`outdir'/VFQ25_SCORE_Near_Activities.jpg", replace

line mean time if subscale=="Near Activities", by(n_ID_paziente, title("VFQ25 SCORE Near Activities") note("")) 
graph export "`outdir'/VFQ25_SCORE_Near_Activities.jpg", replace

line mean time if subscale=="Distance Activities", by(n_ID_paziente, title("VFQ25 SCORE Distance Activities") note("")) 
graph export "`outdir'/VFQ25_SCORE_Distance_Activities.jpg", replace

line mean time if subscale=="Social Functioning", by(n_ID_paziente, title("VFQ25 SCORE Social Functioning") note("")) 
graph export "`outdir'/VFQ25_SCORE_Social_Functioning.jpg", replace 

line mean time if subscale=="Mental Health", by(n_ID_paziente, title("VFQ25 Mental Health") note("")) 
graph export "`outdir'/VFQ25_SCORE_Mental_Health.jpg", replace

/* line mean time if subscale=="Role Difficulties", by(n_ID_paziente, title("VFQ25 SCORE Role Difficulties") note("")) 
graph export "`outdir'/VFQ25_SCORE_Role_Difficulties.jpg", replace

line mean time if subscale=="Dependency", by(n_ID_paziente, title("VFQ25 SCORE Dependency") note("")) 
graph export "`outdir'/VFQ25_SCORE_Dependency.jpg", replace

line mean time if subscale=="Driving", by(n_ID_paziente, title("VFQ25 SCORE Driving") note("")) 
graph export "`outdir'/VFQ25_SCORE_Driving.jpg", replace

line mean time if subscale=="Color Vision", by(n_ID_paziente, title("VFQ25 SCORE Color Vision") note("")) 
graph export "`outdir'/VFQ25_SCORE_Color Vision.jpg", replace

line mean time if subscale=="Peripheral Vision", by(n_ID_paziente, title("VFQ25 SCORE Peripheral Vision") note("")) 
graph export "`outdir'/VFQ25_SCORE_Peripheral Vision.jpg", replace */

/* MODEL */

/*clear
use "`indir'\VFQ25_wscore.avg.dta"


putexcel set mixed_vfq25, replace
mixed mean time || n_ID_paziente:, vce(robust)
putexcel (A1) = etable */

/* General Health 

clear
use "`indir'\subscaleDataset.dta"
drop if subscale!="General Health"

putexcel set mixed_general_health, replace
mixed mean time || n_ID_paziente:, vce(robust)
putexcel (A1) = etable

/* General Vision */

clear
use "`indir'\subscaleDataset.dta"
drop if subscale!="General Vision"

putexcel set mixed_general_vision, replace
mixed mean time || n_ID_paziente:, vce(robust)
putexcel (A1) = etable

/* Ocular Pain */

clear
use "`indir'\subscaleDataset.dta"
drop if subscale!="Ocular Pain"

putexcel set mixed_ocular_pain, replace
mixed mean time || n_ID_paziente:, vce(robust)
putexcel (A1) = etable

/* Near Activities */

clear
use "`indir'\subscaleDataset.dta"
drop if subscale!="Near Activities"

putexcel set mixed_near_activities, replace
mixed mean time || n_ID_paziente:, vce(robust)
putexcel (A1) = etable

/* Distance Activities */

clear
use "`indir'\subscaleDataset.dta"
drop if subscale!="Distance Activities"

putexcel set mixed_distance_activities, replace
mixed mean time || n_ID_paziente:, vce(robust)
putexcel (A1) = etable

/* Social Functioning */

clear
use "`indir'\subscaleDataset.dta"
drop if subscale!="Social Functioning"

putexcel set mixed_social_functioning, replace
mixed mean time || n_ID_paziente:, vce(robust)
putexcel (A1) = etable

/* Mental Health */

clear
use "`indir'\subscaleDataset.dta"
drop if subscale!="Mental Health"

putexcel set mixed_mental_health, replace
mixed mean time || n_ID_paziente:, vce(robust)
putexcel (A1) = etable

/* Role Difficulties */

clear
use "`indir'\subscaleDataset.dta"
drop if subscale!="Role Difficulties"

putexcel set mixed_role_difficulties, replace
mixed mean time || n_ID_paziente:, vce(robust)
putexcel (A1) = etable

/* Dependency */

clear
use "`indir'\subscaleDataset.dta"
drop if subscale!="Dependency"

putexcel set mixed_dependency, replace
mixed mean time || n_ID_paziente:, vce(robust)
putexcel (A1) = etable

/* Driving */

clear
use "`indir'\subscaleDataset.dta"
drop if subscale!="Driving"

putexcel set mixed_driving, replace
mixed mean time || n_ID_paziente:, vce(robust)
putexcel (A1) = etable

/* Color Vision */

clear
use "`indir'\subscaleDataset.dta"
drop if subscale!="Color Vision"

putexcel set mixed_color_vision, replace
mixed mean time || n_ID_paziente:, vce(robust)
putexcel (A1) = etable

/* Peripheral Vision */

clear
use "`indir'\subscaleDataset.dta"
drop if subscale!="Peripheral Vision"

putexcel set mixed_peripheral_vision, replace
mixed mean time || n_ID_paziente:, vce(robust)
putexcel (A1) = etable */

