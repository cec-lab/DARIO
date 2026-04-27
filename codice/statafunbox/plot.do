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

local wd G:\Drive condivisi\Lavori in corso\cristilli
display "`wd'"
cd "`wd'"

local indir `wd'\preprocess
display "`indir'"

local outdir `wd'\out\plot
display "`outdir'"

/* DATA LOAD */

pwd
use "`indir'\cohort.dta"

/* complication by sex */

cd "`outdir'"

graph bar over(sex)

//graph bar (count) thyroid_nodules colon_polyps gastric_polyps breast_nodules uterus_polyps liver_nodules bpco osas_drowsiness carpal_tunnel_neuropathies_myopa prostatic_hypertrophy_prostatiti dexa_result vertebral_collapses, by(sex) title("Complication")
// graph export "`outdir'/MD_ODP_by_patient.jpg", replace

/* local nonNormal 

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
*/