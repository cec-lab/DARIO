/*  DIFFERENZE DI GENERE NELLA DIAGNOSI E CURA DI ACROMEGALIA

	DATA MANAGEMENT
    
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


// DATA LOAD

use "I:\Drive condivisi\Lavori in corso\cristilli\preprocess\cohort.dta"

// LABELLING

label define noyes 0 "No" 1 "Yes"

label define sex 0 "Female" 1 "Male"
label values sex sex

label define education 0 "Lower education" 1 "Middle education" 2 "Higher education" 3 "University education"
label values education education

label define occupation 1 "legislatori, imprenditori, alta dirigenza" 2 "professioni intellettuali, scientifiche e di elevata specilizzazione" 3 "professioni tecniche" 4 "professioni esecutive nel lavoro d'ufficio" 5 "professioni qualificate nelle attività commerciali e nei servizi" 6 "artigiani, operai specilizzati e agricoltori" 7 "conduttori di impianti, operai di macchinari fissi e mobili, conducenti di veicoli"
8 "professioni non qualificate" 9 "forze armate" 10 "casalinghe" 11 "pensionato" 12 "disoccupato" 13 "studente"

label values occupation occupation

label values parttime noyes

label values economic_balance noyes

label values house_management noyes

label define civil_status 0 "Married" 1 "Single/Unmarried" 2 "Divorced" 3 "Widower"
label values civil_status civil_status

label values caregiver noyes

label values physical_exercise noyes

label values smoke noyes

label values alcohol noyes

label values menopause noyes

label values hyperprolactinemia noyes

label values hypopituitarism noyes

label define deficient_hormon 0 "None" 1 "ACTH" 2 "TSH" 3 "LH/FSH" 4 "ACTH and TSH and LH/FSH" 5 "ACTH and LH/FSH " 6 "ACTH and TSH"
label values deficient_hormon deficient_hormon

label values diabetes_insipidus noyes

label define adenoma_size 0 "No" 1 "Microadenoma" 2 "Macroadenoma"

label values adenoma_size_class adenoma_size

label values surgery noyes

label values radiotherapy noyes

label values healing_after_surgery noyes

label define first_line_medical_therapy 1 "SSTA" 2 "PAS" 3 "PEG" 4 "CAB" 5 "SSTA and PAS" 6 "SSTA and CAB"

label values first_line_medical_therapy first_line_medical_therapy

label values adenomatous_tissue noyes

label values medical_therapy_at_last_follow noyes

label define medical_therapy_spec_at_last_fol 1 "SSTA Analoghi " 2 "PAS" 3 "PEG" 4 "CAB" 5 "SSTA and PAS" 6 "SSTA and CAB" 7 "PEG and CAB" 8 "PAS and PEG" 9 "SSTA and PEG" 10 "PAS and CAB" 11 "SSTA and PEG and CAB

label values medical_therapy_spec_at_last_fol medical_therapy_spec_at_last_fol

label values headache noyes

label values enlargement_of_hands_feet noyes

label values asthenia noyes

label values facial_changes noyes

label values prognathism noyes

label values front_drafts noyes

label values thickened_lips noyes

label values saddle_nose noyes

label values head_circumference noyes

label values snoring noyes

label values paresthesia_of_hands_feet noyes

label values macroglossia noyes

label values turbinate_hypertrophy noyes

label values hyper_diaphoresis noyes

label values arthralgias noyes

label define menstruation 0 "Normal" 1 "Oligomenorrhea" 2 "Amenorrhea" 3 "Polymenorrhea" 4 "Dysmenorrhea" 5 "Menorrhagia" 6 "Menopause"

label values menstruation menstruation

label values menstruation menstruation

label values weight_gain noyes

label values edema noyes

label values constipation noyes

label values hoarse_voice noyes

label values hirsutism_acne noyes

label values tinnitus_hearing_reduction noyes

label values skin_thickening_acanthosis_nigri noyes

label values myalgias noyes

label values dyspnea noyes

label values chest_pain noyes

label values compression_symptoms_dysphagia_g noyes

label values galactorrhea_males_gynecomastia noyes

label values jaw_joint_dental_problems noyes

label values visual_problems noyes

label values cognitive_symptoms noyes

label values echo_thyroid noyes

label values thyroid_nodules noyes

label values colonoscopy noyes

label values colon_polyps noyes

label values colon_cancer noyes

label values egds noyes

label values gastric_polyps noyes

label values gastric_cancer noyes

label values emg_eng noyes

label values carpal_tunnel_neuropathies_myopa noyes

label values mammography_breast_ultrasound noyes

label values breast_nodules noyes

label values breast_fibroadenoma noyes

label values breast_cancer noyes

label values pa noyes

label values hypertension noyes

label values ecg noyes

label values arrhythmias noyes

label values echocardio noyes

label values cardiological_evaluation noyes

label values pneumological_evaluation noyes

label values bpco noyes

label values asthma noyes

label values lung_nodules noyes

label values osas noyes

label values osas_drowsiness noyes

label values urological_evaluation noyes

label values de_iief_survey noyes

label values prostatic_hypertrophy_prostatiti noyes

label values prostate_cancer noyes

label values dexa noyes

label define dexa_result 0 "Normal" 1 "Osteoporosis" 2 "Osteopenia"

label values dexa_result dexa_result

label values morphometric_xray noyes

label values vertebral_collapses noyes

label values kyphoscoliosis noyes

label values visit_ultrasound_ginecology noyes

label values pcos noyes

label values uterus_polyps noyes

label values endometrial_cancer noyes

label values ovary_masses noyes

label values ovarian_cancer noyes

label values metabolism_cap noyes

label define metabolism_cap_result 0 "Normal" 1 "IPP" 2 "IPS" 3 "IPPS"

label values metabolism_cap_result metabolism_cap_result

label define calcemia 2 "Hypercalcemia" 3 "Hypocalcemia"

label values calcaemia calcemia

label define phosphataemia 1 "Hyperphosphatemia" 2 "Hypophosphatemia"

label values phosphataemia phosphataemia

label values hypercalciuria noyes

label values glucidic_metabolism noyes

label define glucidic_metabolism_results 1 "DM" 2 "AG" 3 "RT" 4 "IP" 0 "Normal"

label values glucidic_metabolism_result glucidic_metabolism_results

label define psychiatric_visit_result 1 "Depression" 2 "Anxiety" 3 "Agoraphobia"

label values psychiatric_visit_result psychiatric_visit_result

label values eye_exam noyes

label values bitemporal_hemianopsia noyes

label values reduced_visual_acuity noyes

label values glaucoma noyes

label values cataract noyes

label values abdominal_ultrasound noyes

label values liver_cancer noyes

label values liver_nodules noyes

label values steatosis noyes

label values spleen_nodules noyes

label values spleen_cancer noyes

label values kidney_cancer noyes

label values kidney_lithiasis noyes

label values gallbladder_cancer noyes

label values gallbladder_lithiasis noyes

label values pancreatic_cancer noyes

label values pancreatic_nodules noyes

label values bladder_cancer noyes

label values bladder_polyps noyes

label values other_neoplasms noyes

label values genetic_test noyes

label define gender_profile 1 "Profile 1" 2 "Profile 2"

label values cluster gender_profile


// SAVE DSET.DTA
save "I:\Drive condivisi\Lavori in corso\cristilli\preprocess\cohort.dta"

// CODEBOOK

codebook, compact
