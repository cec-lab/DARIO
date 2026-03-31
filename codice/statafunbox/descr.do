/*  DIFFERENZE DI GENERE ALLA DIAGNOSI DI ACROMEGALIA

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

local wd I:\Drive condivisi\Lavori in corso\cristilli
display "`wd'"
cd "`wd'"

local indir `wd'\preprocess
display "`indir'"

local outdir `wd'\out\descriptive
display "`outdir'"

/* DATA LOAD */

pwd
// use "`indir'\cohort.dta"

/* DISTRIBUTION NUMERIC */
/*
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
*/

/* COHORT BASELINE CHARCTERISTICS */

/* TABLE Cohort by center*/

cd "`outdir'"
local nonNormal age_at_diagnosis bmi igf1 normal_igf1_max gh gh_nadir

dtable i.sex age age_at_diagnosis i.education i.occupation i.parttime hours_day i.economic_balance i.house_management i.civil_status i.caregiver i.physical_exercise bmi i.smoke i.alcohol i.menopause igf1 normal_igf1_max igf1_uln gh gh_nadir i.hyperprolactinemia i.hypopituitarism i.deficient_hormon i.diabetes_insipidus i.adenoma_size_class, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(center, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Cohort by center.) ///
export("Cohort_by_center.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE Cohort by sex*/

cd "`outdir'"
local nonNormal age_at_diagnosis bmi igf1 normal_igf1_max gh gh_nadir

dtable age age_at_diagnosis i.education i.occupation i.parttime hours_day i.economic_balance i.house_management i.civil_status i.caregiver i.physical_exercise bmi i.smoke i.alcohol i.menopause igf1 normal_igf1_max igf1_uln gh gh_nadir i.hyperprolactinemia i.hypopituitarism i.deficient_hormon i.diabetes_insipidus i.adenoma_size_class, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(sex, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Cohort by sex.) ///
export("Cohort_by_sex.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE Cohort by gender*/

cd "`outdir'"
local nonNormal age_at_diagnosis bmi igf1 normal_igf1_max gh gh_nadir

dtable i.sex age age_at_diagnosis i.education i.occupation i.parttime hours_day i.economic_balance i.house_management i.civil_status i.caregiver i.physical_exercise bmi i.smoke i.alcohol i.menopause igf1 normal_igf1_max igf1_uln gh gh_nadir i.hyperprolactinemia i.hypopituitarism i.deficient_hormon i.diabetes_insipidus i.adenoma_size_class, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(cluster, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Cohort by gender.) ///
export("Cohort_by_gender.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///


/* TABLE Diagnosis by center*/

cd "`outdir'"
local nonNormal number_of_visit_before_diagnosis years_symptoms_diagnosis

dtable number_of_visit_before_diagnosis years_symptoms_diagnosis, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(center, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Diagnosis by center.) ///
export("Diagnosis_by_center.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE Diagnosis by sex*/

cd "`outdir'"
local nonNormal number_of_visit_before_diagnosis years_symptoms_diagnosis

dtable number_of_visit_before_diagnosis years_symptoms_diagnosis, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(sex, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Diagnosis by sex.) ///
export("Diagnosis_by_sex.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE Diagnosis by gender */

cd "`outdir'"
local nonNormal number_of_visit_before_diagnosis years_symptoms_diagnosis

dtable number_of_visit_before_diagnosis years_symptoms_diagnosis, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(cluster, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Diagnosis by gender.) ///
export("Diagnosis_by_gender.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///


/* TABLE Symptoms by center */

cd "`outdir'"
local nonNormal 

dtable i.headache i.enlargement_of_hands_feet i.asthenia i.facial_changes i.prognathism i.front_drafts i.thickened_lips i.saddle_nose i.head_circumference i.snoring i.paresthesia_of_hands_feet i.macroglossia i.turbinate_hypertrophy i.hyper_diaphoresis i.arthralgias i.menstruation i.weight_gain i.edema i.constipation i.hoarse_voice i.hirsutism_acne i.tinnitus_hearing_reduction i.skin_thickening_acanthosis_nigri i.myalgias i.dyspnea i.chest_pain i.compression_symptoms_dysphagia_g i.galactorrhea_males_gynecomastia i.jaw_joint_dental_problems i.visual_problems i.cognitive_symptoms, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(center, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Symptoms by center.) ///
export("Symptoms_by_center.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE Symptoms by sex */

cd "`outdir'"
local nonNormal 

dtable i.headache i.enlargement_of_hands_feet i.asthenia i.facial_changes i.prognathism i.front_drafts i.thickened_lips i.saddle_nose i.head_circumference i.snoring i.paresthesia_of_hands_feet i.macroglossia i.turbinate_hypertrophy i.hyper_diaphoresis i.arthralgias i.menstruation i.weight_gain i.edema i.constipation i.hoarse_voice i.hirsutism_acne i.tinnitus_hearing_reduction i.skin_thickening_acanthosis_nigri i.myalgias i.dyspnea i.chest_pain i.compression_symptoms_dysphagia_g i.galactorrhea_males_gynecomastia i.jaw_joint_dental_problems i.visual_problems i.cognitive_symptoms, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(sex, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Symptoms by sex.) ///
export("Symptoms_by_sex.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE Symptoms by gender */

cd "`outdir'"
local nonNormal 

dtable i.headache i.enlargement_of_hands_feet i.asthenia i.facial_changes i.prognathism i.front_drafts i.thickened_lips i.saddle_nose i.head_circumference i.snoring i.paresthesia_of_hands_feet i.macroglossia i.turbinate_hypertrophy i.hyper_diaphoresis i.arthralgias i.menstruation i.weight_gain i.edema i.constipation i.hoarse_voice i.hirsutism_acne i.tinnitus_hearing_reduction i.skin_thickening_acanthosis_nigri i.myalgias i.dyspnea i.chest_pain i.compression_symptoms_dysphagia_g i.galactorrhea_males_gynecomastia i.jaw_joint_dental_problems i.visual_problems i.cognitive_symptoms, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(cluster, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Symptoms by gender.) ///
export("Symptoms_by_gender.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///


/* TABLE Intervention by center*/

cd "`outdir'"
local nonNormal 

dtable i.surgery i.number_surgical_treatment i.radiotherapy i.healing_after_surgery i.first_line_medical_therapy, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(center, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Intervention by center.) ///
export("Intervention_by_center.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE Intervention by sex */

cd "`outdir'"
local nonNormal 

dtable i.surgery i.number_surgical_treatment i.radiotherapy i.healing_after_surgery i.first_line_medical_therapy, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(sex, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Intervention by sex.) ///
export("Intervention_by_sex.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE Intervention by gender */

cd "`outdir'"
local nonNormal 

dtable i.surgery i.number_surgical_treatment i.radiotherapy i.healing_after_surgery i.first_line_medical_therapy, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(cluster, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Intervention by gender.) ///
export("Intervention_by_gender.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE Follow up by center */

cd "`outdir'"
local nonNormal years_from_diagnosis igf1_ng_ml gh_ng_ml

dtable years_from_diagnosis i.adenomatous_tissue igf1_ng_ml gh_ng_ml i.medical_therapy_at_last_follow i.medical_therapy_spec_at_last_fol, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(center, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Follow up by center.) ///
export("Followup_by_center.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE Follow up by sex */

cd "`outdir'"
local nonNormal years_from_diagnosis igf1_ng_ml gh_ng_ml

dtable years_from_diagnosis i.adenomatous_tissue igf1_ng_ml gh_ng_ml i.medical_therapy_at_last_follow i.medical_therapy_spec_at_last_fol, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(sex, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Follow up by sex.) ///
export("Followup_by_sex.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE Follow up by gender */

cd "`outdir'"
local nonNormal years_from_diagnosis igf1_ng_ml gh_ng_ml

dtable years_from_diagnosis i.adenomatous_tissue igf1_ng_ml gh_ng_ml i.medical_therapy_at_last_follow i.medical_therapy_spec_at_last_fol, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(cluster, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Follow up by gender.) ///
export("Followup_by_gender.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///


/* TABLE Complication screening by center*/

cd "`outdir'"
local nonNormal 

dtable i.echo_thyroid i.colonoscopy i.egds i.emg_eng i.mammography_breast_ultrasound i.pa i.hypertension i.ecg i.echocardio i.cardiological_evaluation i.pneumological_evaluation i.osas i.urological_evaluation i.de_iief_survey i.dexa i.morphometric_xray i.visit_ultrasound_ginecology i.metabolism_cap i.glucidic_metabolism i.lipidic_profile i.psychiatric_visit i.abdominal_ultrasound i.genetic_test, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(center, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Complication screening by center.) ///
export("Complication_screening_by_center.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE Complication screening by sex */

cd "`outdir'"
local nonNormal 

dtable i.echo_thyroid i.colonoscopy i.egds i.emg_eng i.mammography_breast_ultrasound i.pa i.hypertension i.ecg i.echocardio i.cardiological_evaluation i.pneumological_evaluation i.osas i.urological_evaluation i.de_iief_survey i.dexa i.morphometric_xray i.visit_ultrasound_ginecology i.metabolism_cap i.glucidic_metabolism i.lipidic_profile i.psychiatric_visit i.abdominal_ultrasound i.genetic_test, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(sex, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Complication screening by sex.) ///
export("Complication_screening_by_sex.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE Complication screening by gender */

cd "`outdir'"
local nonNormal 

dtable i.echo_thyroid i.colonoscopy i.egds i.emg_eng i.mammography_breast_ultrasound i.pa i.hypertension i.ecg i.echocardio i.cardiological_evaluation i.pneumological_evaluation i.osas i.urological_evaluation i.de_iief_survey i.dexa i.morphometric_xray i.visit_ultrasound_ginecology i.metabolism_cap i.glucidic_metabolism i.lipidic_profile i.psychiatric_visit i.abdominal_ultrasound i.genetic_test, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(cluster, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Complication screening by gender.) ///
export("Complication_screening_by_gender.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE Complication by center */

cd "`outdir'"
local nonNormal 

dtable i.thyroid_nodules i.colon_polyps i.colon_cancer i.gastric_polyps i.gastric_cancer i.carpal_tunnel_neuropathies_myopa i.breast_nodules i.breast_fibroadenoma i.breast_cancer i.arrhythmias i.bpco i.asthma i.lung_nodules i.osas_drowsiness i.prostatic_hypertrophy_prostatiti i.prostate_cancer i.dexa_result i.vertebral_collapses i.kyphoscoliosis i.pcos i.uterus_polyps i.endometrial_cancer i.ovary_masses i.ovarian_cancer i.metabolism_cap_result i.calcaemia i.phosphataemia i.hypercalciuria i.glucidic_metabolism_result i.dyslipidemia i.psychiatric_visit_result i.eye_exam i.bitemporal_hemianopsia i.reduced_visual_acuity i.glaucoma i.cataract i.liver_cancer i.liver_nodules i.steatosis i.spleen_nodules i.spleen_cancer i.kidney_cancer i.kidney_lithiasis i.gallbladder_cancer i.gallbladder_lithiasis i.pancreatic_cancer i.pancreatic_nodules i.bladder_cancer i.bladder_polyps i.other_neoplasms, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(center, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Complication by center.) ///
export("Complication_by_center.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE Complication by sex */

cd "`outdir'"
local nonNormal 

dtable i.thyroid_nodules i.colon_polyps i.colon_cancer i.gastric_polyps i.gastric_cancer i.carpal_tunnel_neuropathies_myopa i.breast_nodules i.breast_fibroadenoma i.breast_cancer i.arrhythmias i.bpco i.asthma i.lung_nodules i.osas_drowsiness i.prostatic_hypertrophy_prostatiti i.prostate_cancer i.dexa_result i.vertebral_collapses i.kyphoscoliosis i.pcos i.uterus_polyps i.endometrial_cancer i.ovary_masses i.ovarian_cancer i.metabolism_cap_result i.calcaemia i.phosphataemia i.hypercalciuria i.glucidic_metabolism_result i.dyslipidemia i.psychiatric_visit_result i.eye_exam i.bitemporal_hemianopsia i.reduced_visual_acuity i.glaucoma i.cataract i.liver_cancer i.liver_nodules i.steatosis i.spleen_nodules i.spleen_cancer i.kidney_cancer i.kidney_lithiasis i.gallbladder_cancer i.gallbladder_lithiasis i.pancreatic_cancer i.pancreatic_nodules i.bladder_cancer i.bladder_polyps i.other_neoplasms, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(sex, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Complication by sex.) ///
export("Complication_by_sex.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE Complication by gender */

cd "`outdir'"
local nonNormal 

dtable i.thyroid_nodules i.colon_polyps i.colon_cancer i.gastric_polyps i.gastric_cancer i.carpal_tunnel_neuropathies_myopa i.breast_nodules i.breast_fibroadenoma i.breast_cancer i.arrhythmias i.bpco i.asthma i.lung_nodules i.osas_drowsiness i.prostatic_hypertrophy_prostatiti i.prostate_cancer i.dexa_result i.vertebral_collapses i.kyphoscoliosis i.pcos i.uterus_polyps i.endometrial_cancer i.ovary_masses i.ovarian_cancer i.metabolism_cap_result i.calcaemia i.phosphataemia i.hypercalciuria i.glucidic_metabolism_result i.dyslipidemia i.psychiatric_visit_result i.eye_exam i.bitemporal_hemianopsia i.reduced_visual_acuity i.glaucoma i.cataract i.liver_cancer i.liver_nodules i.steatosis i.spleen_nodules i.spleen_cancer i.kidney_cancer i.kidney_lithiasis i.gallbladder_cancer i.gallbladder_lithiasis i.pancreatic_cancer i.pancreatic_nodules i.bladder_cancer i.bladder_polyps i.other_neoplasms, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(cluster, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Complication by gender.) ///
export("Complication_by_gender.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE  complicanze cardiache by gender */

cd "`outdir'"
local nonNormal 

dtable i.cardiopatiapresente_cardio i.ipertrofiaventricolare_cardio i.valvulopatia_cardio i.rid_frazionedieiezione_cardio i.cardiopatiadilatativa_cardio i.valvulopatianonspecificata_cardi i.insufficienzamitralica_cardio i.cardiopatianonspecificata_cardio, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(cluster, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Cardiac complication by gender.) ///
export("Cardiac_complication_by_gender.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE  complicanze cardiache by sex */

cd "`outdir'"
local nonNormal 

dtable i.cardiopatiapresente_cardio i.ipertrofiaventricolare_cardio i.valvulopatia_cardio i.rid_frazionedieiezione_cardio i.cardiopatiadilatativa_cardio i.valvulopatianonspecificata_cardi i.insufficienzamitralica_cardio i.cardiopatianonspecificata_cardio, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(sex, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Cardiac complication by sex.) ///
export("Cardiac_complication_by_sex.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE  complicanze cardiache by center */

cd "`outdir'"
local nonNormal 

dtable i.cardiopatiapresente_cardio i.ipertrofiaventricolare_cardio i.valvulopatia_cardio i.rid_frazionedieiezione_cardio i.cardiopatiadilatativa_cardio i.valvulopatianonspecificata_cardi i.insufficienzamitralica_cardio i.cardiopatianonspecificata_cardio, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(center, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Cardiac complication by center.) ///
export("Cardiac_complication_by_center.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE  Medico Diagnosi by center */

cd "`outdir'"
local nonNormal 

dtable i.mmg_diag i.endocrinologo_diag i.neurologo_diag i.neurochirurgo_diag i.orl_diag i.oculista_diag i.cardiologo_diag i.ginecologo_diag i.ortopedico_diag i.internista_diag i.medicodips_diag i.diabetologo_diag i.pneumologo_diag i.reumatologo_diag i.altro_diag i.multi_diag, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(center, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Medical specialist - diagnosis by center.) ///
export("Medical_specialist_diagnosi_by_center.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE  Medico Diagnosi by sex */

cd "`outdir'"
local nonNormal 

dtable i.mmg_diag i.endocrinologo_diag i.neurologo_diag i.neurochirurgo_diag i.orl_diag i.oculista_diag i.cardiologo_diag i.ginecologo_diag i.ortopedico_diag i.internista_diag i.medicodips_diag i.diabetologo_diag i.pneumologo_diag i.reumatologo_diag i.altro_diag i.multi_diag, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(sex, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Medical specialist - diagnosis by sex.) ///
export("Medical_specialist_diagnosi_by_sex.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE  Medico Diagnosi by gender */

cd "`outdir'"
local nonNormal 

dtable i.mmg_diag i.endocrinologo_diag i.neurologo_diag i.neurochirurgo_diag i.orl_diag i.oculista_diag i.cardiologo_diag i.ginecologo_diag i.ortopedico_diag i.internista_diag i.medicodips_diag i.diabetologo_diag i.pneumologo_diag i.reumatologo_diag i.altro_diag i.multi_diag, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(cluster, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Medical specialist - diagnosis by gender.) ///
export("Medical_specialist_diagnosi_by_gender.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE  Medico specialista  by center */

cd "`outdir'"
local nonNormal 

dtable i.mmg_spc i.endocrinologo_spc i.neurologo_spc i.neurochirurgo_spc i.orl_spc i.oculista_spc i.cardiologo_spc i.ginecologo_spc i.ortopedico_spc i.internista_spc i.medicodips_spc i.diabetologo_spc i.pneumologo_spc i.reumatologo_spc i.altro_spc, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(center, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Medical specialist - before diagnosis by center.) ///
export("Medical_specialist_before_diagnosi_by_center.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE  Medico specialista by sex */

cd "`outdir'"
local nonNormal 

dtable i.mmg_spc i.endocrinologo_spc i.neurologo_spc i.neurochirurgo_spc i.orl_spc i.oculista_spc i.cardiologo_spc i.ginecologo_spc i.ortopedico_spc i.internista_spc i.medicodips_spc i.diabetologo_spc i.pneumologo_spc i.reumatologo_spc i.altro_spc, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(sex, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Medical specialist - before diagnosis by sex.) ///
export("Medical_specialist_before_diagnosi_by_sex.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE  Medico specialista by gender */

cd "`outdir'"
local nonNormal 

dtable i.mmg_spc i.endocrinologo_spc i.neurologo_spc i.neurochirurgo_spc i.orl_spc i.oculista_spc i.cardiologo_spc i.ginecologo_spc i.ortopedico_spc i.internista_spc i.medicodips_spc i.diabetologo_spc i.pneumologo_spc i.reumatologo_spc i.altro_spc, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(cluster, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Medical specialist - before diagnosis by gender.) ///
export("Medical_specialist_before_diagnosi_by_gender.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE  Motivo visita by center */

cd "`outdir'"
local nonNormal 

dtable i.cefalea_visita i.alterazionisomatiche_visita i.alterazionimestruali_visita i.tireopatia_visita i.iperdiaforesi_visita i.artralgie_visita i.russamento_visita i.deficitvisivi_visita i.astenia_visita i.incrementoponderale_visita i.patologiecardiovascolari_visita i.alterazprofiloglucidico_visita i.disturbineurologici_visita i.casuale_visita, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(center, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Reason for visit by center.) ///
export("Reason_visit_by_center.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE  Motivo visita by sex */

cd "`outdir'"
local nonNormal 

dtable i.cefalea_visita i.alterazionisomatiche_visita i.alterazionimestruali_visita i.tireopatia_visita i.iperdiaforesi_visita i.artralgie_visita i.russamento_visita i.deficitvisivi_visita i.astenia_visita i.incrementoponderale_visita i.patologiecardiovascolari_visita i.alterazprofiloglucidico_visita i.disturbineurologici_visita i.casuale_visita, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(sex, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Reason for visit by sex.) ///
export("Reason_visit_by_sex.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///

/* TABLE  Motivo visita by gender */

cd "`outdir'"
local nonNormal 

dtable i.cefalea_visita i.alterazionisomatiche_visita i.alterazionimestruali_visita i.tireopatia_visita i.iperdiaforesi_visita i.artralgie_visita i.russamento_visita i.deficitvisivi_visita i.astenia_visita i.incrementoponderale_visita i.patologiecardiovascolari_visita i.alterazprofiloglucidico_visita i.disturbineurologici_visita i.casuale_visita, ///
continuous(`nonNormal', statistics(q2 iqi) test(kwallis)) ///
define(iqi = q1 q3) /// 
sformat("[%s]" iqi) ///
nformat(%7.2f) ///
by(cluster, totals tests) /// 
column(test("p-value") total("Overall")) ///
title(Table xx. Reason for visit by gender.) ///
export("Reason_visit_by_gender.docx", replace)

// note(Mediam [IQR]: p-value from a Kruskall-Wallis test.) ///
// note(Frequency (%): p-value from Pearson test.) ///


/* BARPLOT motivo visita */

// graph bar (), over(MD_ODP) by(n_ID_paziente, note("")) title("MD_ODP")
// graph export "`outdir'/MD_ODP_by_patient.jpg", replace

