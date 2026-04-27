/*  VIT C STUDY

	DESCRIPTIVE STATISTICS
    
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

local wd "I:\Drive condivisi\Lavori in corso\VitC\2024"
display "`wd'"
cd "`wd'"

local indir "`wd'\preprocess"
display "`indir'"

local outdir `wd'\out
display "`outdir'"

/* DATA LOAD */

pwd
use "`indir'\cohort_v2.dta"

/* DISTRIBUTION NUMERIC */

tempname memhold 
tempfile results
postfile `memhold' str12 varname pvalue using "`results'"
ds, has(type numeric)
foreach v of varlist `r(varlist)' {
	display "`v'"
	capture swilk `v'
	if c(rc) == 0 {
	 post `memhold' ("`v'") (r(p))	
	}
}
postclose `memhold'
use "`results'", clear
describe

export excel using "`outdir'\swilk.xlsx", firstrow(varlabels) replace

/* COHORT BASELINE CHARCTERISTICS */

/* TABLE 1 */

use "`indir'\cohort_v2.dta"

cd "`outdir'"
local nonNormal age_days weight bsa

dtable i.sex weight-bsa i.etnicity age_days i.complex_chd-single_ventricle  nephotoxic_meds_number rachs1 i.RACHS1_gt_3 CVP_gt_7_d1 CVP_gt_7_d2 CVP_gt_7_d3 i.CVP_gt_7_overall i.fo_5 i.fo_10 i.comorbidita_binary, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
by(AKI_binary, tests) /// 
column(test("p-value")) ///
nformat(%7.2f) ///
title(Table 1. Baseline characteristics by AKI event.) ///
export("cohort.docx", replace)


// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* Admission diagnosis */

cd "`outdir'"
// local nonNormal Age AgeAtDiagnosis bmi WorkHoursDay

dtable i.Atrial_Septal_Defect-Aortic_Dissection, ///
by(AKI_binary, tests) /// 
column(test("p-value")) ///
title(Table 1. Admission by AKI event.) ///
export("Admission.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* Comorbidity */

cd "`outdir'"

dtable i.comorbidita_1-comorbidita_binary, ///
by(AKI_binary, tests) /// 
column(test("p-value")) ///
title(Table 1. Comorbidity by AKI event.) ///
export("Comorbidity.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* Procedures */

cd "`outdir'"
local nonNormal duration_surgicalprocedure cpb_time crossclamp_time circulatory_arrest_time hypothermia creat_basal_umol_L eGFR_basal

dtable duration_surgicalprocedure i.type_correction cpb_time i.cpb_time_gt_120 i.aortic_crossclamp crossclamp_time i.circulatory_arrest circulatory_arrest_time hypothermia i.muf i.ca_duringprocedure ca_downtime_during creat_basal_umol_L eGFR_basal i.rrt, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(AKI_binary, tests) /// 
column(test("p-value")) ///
title(Table 1. Procedures variables by AKI event.) ///
export("Procedures.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* ECMO */

cd "`outdir'"
local nonNormal ecmo_duration ecmo_duration_afteradmission

dtable i.ECMO_h0 ecmo_duration i.ecmo_afteradmission ecmo_duration_afteradmission i.cardiac_arrest ca_episodes, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(AKI_binary, tests) /// 
column(test("p-value")) ///
title(Table 1. ECMO by AKI event.) ///
export("ECMO.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* EMO */

cd "`outdir'"
local nonNormal CVP_max CVP_min CVP_d1_max CVP_d1_min CVP_d2_max CVP_d2_min CVP_d3_max CVP_d3_min

dtable CVP_d1_median-CVP_d1_max CVP_d2_median-CVP_d2_max CVP_d3_median-CVP_d3_max CVP_min CVP_max CVP_median i.Hypotension_SBP_d1 i.MAP_lt_5pcle_d1 i.MAP_lt_50pcle_d1 i.CVP_gt_7_d1 i.OPP_lt_5pcle_d1 i.OPP_lt_50pcle_d1 i.Hypotension_SBP_d2 i.MAP_lt_5pcle_d2 i.MAP_lt_50pcle_d2 i.CVP_gt_7_d2 i.OPP_lt_5pcle_d2 i.OPP_lt_50pcle_d2 i.Hypotension_SBP_d3 i.MAP_lt_5pcle_d3 i.MAP_lt_50pcle_d3 i.CVP_gt_7_d3 i.OPP_lt_5pcle_d3 i.OPP_lt_50pcle_d3 i.MAP_lt_5pcle_overall i.MAP_lt_50pcle_overall i.OPP_lt_5pcle_overall i.OPP_lt_50pcle_overall i.hypotension_SBP_overall, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(AKI_binary, tests) /// 
column(test("p-value")) ///
title(Table 1. Hemodynamics by AKI event.) ///
export("Emo.docx", replace)

/* FLUID */

cd "`outdir'"
local nonNormal BUN_mmol_L_d1 BUN_mmol_L_d2 BUN_mmol_L_d3 fluid_overload_pc_d1 fluid_overload_pc_d2 fluid_overload_pc_d3 fluid_overload_sum_pc furosemide_dose_mg_kg_h_d1 furosemide_dose_mg_kg_h_d2 furosemide_dose_mg_kg_h_d3 furosemide_dose_mg_kg_h_min furosemide_dose_mg_kg_h_max furosemide_dose_mg_kg_h_median

dtable BUN_mmol_L_d1 BUN_mmol_L_d2 BUN_mmol_L_d3 fluid_overload_pc_d1 fluid_overload_pc_d2 fluid_overload_pc_d3 fluid_overload_sum_pc furosemide_dose_mg_kg_h_d1 furosemide_dose_mg_kg_h_d2 furosemide_dose_mg_kg_h_d3 furosemide_dose_mg_kg_h_min furosemide_dose_mg_kg_h_max furosemide_dose_mg_kg_h_median, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(AKI_binary, tests) /// 
column(test("p-value")) ///
title(Table 1. Fluid dynamics by AKI event.) ///
export("Fluid.docx", replace)

/* LCOS */

cd "`outdir'"

dtable i.LCOS_d1-LCOS_general, ///
by(AKI_binary, tests) /// 
column(test("p-value")) ///
title(Table 1. LCOS by AKI event.) ///
export("LCOS.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* VIS */

cd "`outdir'"
local nonNormal VIS_max_d1-VIS_max

dtable VIS_median_d1-VIS_max, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(AKI_binary, tests) /// 
column(test("p-value")) ///
title(Table 1. VIS by AKI event.) ///
export("VIS.docx", replace)

/* ESITI */

cd "`outdir'"
local nonNormal PICU_LOS HOSPITAL_LOS
//egen stdVFD = std(VFD)

dtable i.LCOS VFD PICU_LOS HOSPITAL_LOS i.AKD i.CKD i.DEATH i.AKI_stage_d1 i.AKI_stage_d2 i.AKI_stage_d3 i.AKI_stage_final, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(AKI_binary, tests) /// 
column(test("p-value")) ///
title(Table 1. Outcomes by AKI event.) ///
export("OUTCOMES.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

// END
