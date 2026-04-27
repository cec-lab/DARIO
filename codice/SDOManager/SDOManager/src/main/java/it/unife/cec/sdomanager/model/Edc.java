/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package it.unife.cec.sdomanager.model;

/**
 *
 * @author utente
 */
import javafx.beans.property.*;

public class Edc {

    public IntegerProperty id = new SimpleIntegerProperty();
    public StringProperty isValid = new SimpleStringProperty();
    private StringProperty record_id = new SimpleStringProperty();
    private StringProperty redcap_data_access_group = new SimpleStringProperty();
    private StringProperty birth_date = new SimpleStringProperty();
    private StringProperty record_validation = new SimpleStringProperty();
    private StringProperty centre = new SimpleStringProperty();
    private StringProperty numloc = new SimpleStringProperty();
    private StringProperty sdo_number = new SimpleStringProperty();
    private StringProperty mother_name = new SimpleStringProperty();
    private StringProperty mother_surname = new SimpleStringProperty();
    private StringProperty gestlength = new SimpleStringProperty();
    private StringProperty nbrbaby = new SimpleStringProperty();
    private StringProperty sp_twin = new SimpleStringProperty();
    private StringProperty nbrmalf = new SimpleStringProperty();
    private StringProperty sex = new SimpleStringProperty();
    private StringProperty type = new SimpleStringProperty();
    private StringProperty newborn_name = new SimpleStringProperty();
    private StringProperty newborn_surname = new SimpleStringProperty();
    private StringProperty civreg = new SimpleStringProperty();
    private StringProperty weight = new SimpleStringProperty();
    private StringProperty survival = new SimpleStringProperty();
    private StringProperty death_date = new SimpleStringProperty();
    private StringProperty mocitizenship = new SimpleStringProperty();
    private StringProperty resmo = new SimpleStringProperty();
    private StringProperty extra_er_resmo = new SimpleStringProperty();
    private StringProperty datemo = new SimpleStringProperty();
    private StringProperty agemo = new SimpleStringProperty();
    private StringProperty bmi = new SimpleStringProperty();
    private StringProperty totpreg = new SimpleStringProperty();
    private StringProperty whendisc = new SimpleStringProperty();
    private StringProperty agedisc = new SimpleStringProperty();
    private StringProperty condisc = new SimpleStringProperty();
    private StringProperty firstpre = new SimpleStringProperty();
    private StringProperty sp_firstpre = new SimpleStringProperty();
    private StringProperty karyo = new SimpleStringProperty();
    private StringProperty sp_cario = new SimpleStringProperty();
    private StringProperty gentest = new SimpleStringProperty();
    private StringProperty sp_gentest = new SimpleStringProperty();
    private StringProperty surgery = new SimpleStringProperty();
    private StringProperty pm = new SimpleStringProperty();
    private StringProperty pm_notes = new SimpleStringProperty();
    private StringProperty diagnosis_syndrome = new SimpleStringProperty();
    private StringProperty presyn = new SimpleStringProperty();
    private StringProperty diagnosis_malformation_1 = new SimpleStringProperty();
    private StringProperty premal1 = new SimpleStringProperty();
    private StringProperty diagnosis_malformation_2 = new SimpleStringProperty();
    private StringProperty premal2 = new SimpleStringProperty();
    private StringProperty diagnosis_malformation_3 = new SimpleStringProperty();
    private StringProperty premal3 = new SimpleStringProperty();
    private StringProperty diagnosis_malformation_4 = new SimpleStringProperty();
    private StringProperty premal4 = new SimpleStringProperty();
    private StringProperty diagnosis_malformation_5 = new SimpleStringProperty();
    private StringProperty premal5 = new SimpleStringProperty();
    private StringProperty diagnosis_malformation_6 = new SimpleStringProperty();
    private StringProperty premal6 = new SimpleStringProperty();
    private StringProperty diagnosis_malformation_7 = new SimpleStringProperty();
    private StringProperty premal7 = new SimpleStringProperty();
    private StringProperty diagnosis_malformation_8 = new SimpleStringProperty();
    private StringProperty premal8 = new SimpleStringProperty();
    private StringProperty valid_case = new SimpleStringProperty();
    private StringProperty validation_notes = new SimpleStringProperty();
    private StringProperty imer_key = new SimpleStringProperty();
    private StringProperty syndrome = new SimpleStringProperty();
    private StringProperty syndrome_desc_detail = new SimpleStringProperty();
    private StringProperty sp_syndrome = new SimpleStringProperty();
    private StringProperty omim = new SimpleStringProperty();
    private StringProperty orpha = new SimpleStringProperty();
    private StringProperty malfo1 = new SimpleStringProperty();
    private StringProperty malf1_desc_detail = new SimpleStringProperty();
    private StringProperty sp_malfo1 = new SimpleStringProperty();
    private StringProperty malfo2 = new SimpleStringProperty();
    private StringProperty malfo2_desc_detail = new SimpleStringProperty();
    private StringProperty sp_malfo2 = new SimpleStringProperty();
    private StringProperty malfo3 = new SimpleStringProperty();
    private StringProperty malfo_3_desc_detail = new SimpleStringProperty();
    private StringProperty sp_malfo3 = new SimpleStringProperty();
    private StringProperty malfo4 = new SimpleStringProperty();
    private StringProperty malfo4_desc_detail = new SimpleStringProperty();
    private StringProperty sp_malfo4 = new SimpleStringProperty();
    private StringProperty malfo5 = new SimpleStringProperty();
    private StringProperty malfo5_desc_detail = new SimpleStringProperty();
    private StringProperty sp_malfo5 = new SimpleStringProperty();
    private StringProperty malfo6 = new SimpleStringProperty();
    private StringProperty malfo6_desc_detail = new SimpleStringProperty();
    private StringProperty sp_malfo6 = new SimpleStringProperty();
    private StringProperty malfo7 = new SimpleStringProperty();
    private StringProperty malfo7_desc_detail = new SimpleStringProperty();
    private StringProperty sp_malfo7 = new SimpleStringProperty();
    private StringProperty malfo8 = new SimpleStringProperty();
    private StringProperty malf8_desc_detail = new SimpleStringProperty();
    private StringProperty sp_malfo8 = new SimpleStringProperty();
    private StringProperty notes = new SimpleStringProperty();
    private StringProperty assconcept = new SimpleStringProperty();
    private StringProperty agefa = new SimpleStringProperty();
    private StringProperty socf = new SimpleStringProperty();
    private StringProperty occupmo = new SimpleStringProperty();
    private StringProperty matdiab = new SimpleStringProperty();
    private StringProperty illbef1 = new SimpleStringProperty();
    private StringProperty sp_illbef1 = new SimpleStringProperty();
    private StringProperty icd9illbef1 = new SimpleStringProperty();
    private StringProperty illbef2 = new SimpleStringProperty();
    private StringProperty sp_illbef2 = new SimpleStringProperty();
    private StringProperty icd9illbef2 = new SimpleStringProperty();
    private StringProperty illdur1 = new SimpleStringProperty();
    private StringProperty sp_illdur1 = new SimpleStringProperty();
    private StringProperty icd9illdur1 = new SimpleStringProperty();
    private StringProperty illdur2 = new SimpleStringProperty();
    private StringProperty sp_illdur2 = new SimpleStringProperty();
    private StringProperty icd9illdur2 = new SimpleStringProperty();
    private StringProperty folic_g14 = new SimpleStringProperty();
    private StringProperty extra_drugs = new SimpleStringProperty();
    private StringProperty firsttri = new SimpleStringProperty();
    private StringProperty drugs1 = new SimpleStringProperty();
    private StringProperty sp_ifnotlisted_medication = new SimpleStringProperty();
    private StringProperty sp_drugs = new SimpleStringProperty();
    private StringProperty drugs2 = new SimpleStringProperty();
    private StringProperty sp_ifnotlisted_medication_2 = new SimpleStringProperty();
    private StringProperty sp_drugs_2 = new SimpleStringProperty();
    private StringProperty drugs3 = new SimpleStringProperty();
    private StringProperty sp_ifnotlisted_medication_3 = new SimpleStringProperty();
    private StringProperty sp_drugs_3 = new SimpleStringProperty();
    private StringProperty drugs4 = new SimpleStringProperty();
    private StringProperty sp_ifnotlisted_medication_4 = new SimpleStringProperty();
    private StringProperty sp_drugs_4 = new SimpleStringProperty();
    private StringProperty drugs5 = new SimpleStringProperty();
    private StringProperty sp_ifnotlisted_medication_5 = new SimpleStringProperty();
    private StringProperty sp_drugs_5 = new SimpleStringProperty();
    private StringProperty inf_cov_test = new SimpleStringProperty();
    private StringProperty imm_cov_test = new SimpleStringProperty();
    private StringProperty oth_cov_test = new SimpleStringProperty();
    private StringProperty sp_oth_cov_test = new SimpleStringProperty();
    private StringProperty start_cov = new SimpleStringProperty();
    private StringProperty cov_severity = new SimpleStringProperty();
    private StringProperty consang = new SimpleStringProperty();
    private StringProperty sp_consang = new SimpleStringProperty();
    private StringProperty sibanom = new SimpleStringProperty();
    private StringProperty sp_sibanom = new SimpleStringProperty();
    private StringProperty prevsib = new SimpleStringProperty();
    private StringProperty sib1 = new SimpleStringProperty();
    private StringProperty sib2 = new SimpleStringProperty();
    private StringProperty sib3 = new SimpleStringProperty();
    private StringProperty moanom = new SimpleStringProperty();
    private StringProperty sp_moanom = new SimpleStringProperty();
    private StringProperty faanom = new SimpleStringProperty();
    private StringProperty sp_faanom = new SimpleStringProperty();
    private StringProperty matedu = new SimpleStringProperty();
    private StringProperty socm = new SimpleStringProperty();
    private StringProperty migrant = new SimpleStringProperty();
    private StringProperty genrem = new SimpleStringProperty();
    private StringProperty imer_key_factor = new SimpleStringProperty();
    private StringProperty syndrome_factor = new SimpleStringProperty();
    private StringProperty malfo1_factor = new SimpleStringProperty();
    private StringProperty malfo2_factor = new SimpleStringProperty();
    private StringProperty malfo3_factor = new SimpleStringProperty();
    private StringProperty malfo4_factor = new SimpleStringProperty();
    private StringProperty malfo5_factor = new SimpleStringProperty();
    private StringProperty malfo6_factor = new SimpleStringProperty();
    private StringProperty malfo7_factor = new SimpleStringProperty();
    private StringProperty malfo8_factor = new SimpleStringProperty();
    private StringProperty illbef1_factor = new SimpleStringProperty();
    private StringProperty illbef2_factor = new SimpleStringProperty();
    private StringProperty illdur1_factor = new SimpleStringProperty();
    private StringProperty illdur2_factor = new SimpleStringProperty();
    private StringProperty cohort = new SimpleStringProperty();
    private StringProperty birthCenter = new SimpleStringProperty();
    private StringProperty sdo_number_std = new SimpleStringProperty();
    private StringProperty data_source = new SimpleStringProperty();
    private StringProperty linkageKey = new SimpleStringProperty();
    private StringProperty cedap_linked = new SimpleStringProperty();
    
     public Edc () {
    }

    
    // GETTER E SETTER


    public IntegerProperty getId() {
        return id;
    }

    public void setId(IntegerProperty id) {
        this.id = id;
    }

    public StringProperty getIsValid() {
        return isValid;
    }

    public void setIsValid(StringProperty isValid) {
        this.isValid = isValid;
    }
     
    public StringProperty getRecord_id() {
        return record_id;
    }

    public void setRecord_id(StringProperty record_id) {
        this.record_id = record_id;
    }

    public StringProperty getRedcap_data_access_group() {
        return redcap_data_access_group;
    }

    public void setRedcap_data_access_group(StringProperty redcap_data_access_group) {
        this.redcap_data_access_group = redcap_data_access_group;
    }

    public StringProperty getBirth_date() {
        return birth_date;
    }

    public void setBirth_date(StringProperty birth_date) {
        this.birth_date = birth_date;
    }

    public StringProperty getRecord_validation() {
        return record_validation;
    }

    public void setRecord_validation(StringProperty record_validation) {
        this.record_validation = record_validation;
    }

    public StringProperty getCentre() {
        return centre;
    }

    public void setCentre(StringProperty centre) {
        this.centre = centre;
    }

    public StringProperty getNumloc() {
        return numloc;
    }

    public void setNumloc(StringProperty numloc) {
        this.numloc = numloc;
    }

    public StringProperty getSdo_number() {
        return sdo_number;
    }

    public void setSdo_number(StringProperty sdo_number) {
        this.sdo_number = sdo_number;
    }

    public StringProperty getMother_name() {
        return mother_name;
    }

    public void setMother_name(StringProperty mother_name) {
        this.mother_name = mother_name;
    }

    public StringProperty getMother_surname() {
        return mother_surname;
    }

    public void setMother_surname(StringProperty mother_surname) {
        this.mother_surname = mother_surname;
    }

    public StringProperty getGestlength() {
        return gestlength;
    }

    public void setGestlength(StringProperty gestlength) {
        this.gestlength = gestlength;
    }

    public StringProperty getNbrbaby() {
        return nbrbaby;
    }

    public void setNbrbaby(StringProperty nbrbaby) {
        this.nbrbaby = nbrbaby;
    }

    public StringProperty getSp_twin() {
        return sp_twin;
    }

    public void setSp_twin(StringProperty sp_twin) {
        this.sp_twin = sp_twin;
    }

    public StringProperty getNbrmalf() {
        return nbrmalf;
    }

    public void setNbrmalf(StringProperty nbrmalf) {
        this.nbrmalf = nbrmalf;
    }

    public StringProperty getSex() {
        return sex;
    }

    public void setSex(StringProperty sex) {
        this.sex = sex;
    }

    public StringProperty getType() {
        return type;
    }

    public void setType(StringProperty type) {
        this.type = type;
    }

    public StringProperty getNewborn_name() {
        return newborn_name;
    }

    public void setNewborn_name(StringProperty newborn_name) {
        this.newborn_name = newborn_name;
    }

    public StringProperty getNewborn_surname() {
        return newborn_surname;
    }

    public void setNewborn_surname(StringProperty newborn_surname) {
        this.newborn_surname = newborn_surname;
    }

    public StringProperty getCivreg() {
        return civreg;
    }

    public void setCivreg(StringProperty civreg) {
        this.civreg = civreg;
    }

    public StringProperty getWeight() {
        return weight;
    }

    public void setWeight(StringProperty weight) {
        this.weight = weight;
    }

    public StringProperty getSurvival() {
        return survival;
    }

    public void setSurvival(StringProperty survival) {
        this.survival = survival;
    }

    public StringProperty getDeath_date() {
        return death_date;
    }

    public void setDeath_date(StringProperty death_date) {
        this.death_date = death_date;
    }

    public StringProperty getMocitizenship() {
        return mocitizenship;
    }

    public void setMocitizenship(StringProperty mocitizenship) {
        this.mocitizenship = mocitizenship;
    }

    public StringProperty getResmo() {
        return resmo;
    }

    public void setResmo(StringProperty resmo) {
        this.resmo = resmo;
    }

    public StringProperty getExtra_er_resmo() {
        return extra_er_resmo;
    }

    public void setExtra_er_resmo(StringProperty extra_er_resmo) {
        this.extra_er_resmo = extra_er_resmo;
    }

    public StringProperty getDatemo() {
        return datemo;
    }

    public void setDatemo(StringProperty datemo) {
        this.datemo = datemo;
    }

    public StringProperty getAgemo() {
        return agemo;
    }

    public void setAgemo(StringProperty agemo) {
        this.agemo = agemo;
    }

    public StringProperty getBmi() {
        return bmi;
    }

    public void setBmi(StringProperty bmi) {
        this.bmi = bmi;
    }

    public StringProperty getTotpreg() {
        return totpreg;
    }

    public void setTotpreg(StringProperty totpreg) {
        this.totpreg = totpreg;
    }

    public StringProperty getWhendisc() {
        return whendisc;
    }

    public void setWhendisc(StringProperty whendisc) {
        this.whendisc = whendisc;
    }

    public StringProperty getAgedisc() {
        return agedisc;
    }

    public void setAgedisc(StringProperty agedisc) {
        this.agedisc = agedisc;
    }

    public StringProperty getCondisc() {
        return condisc;
    }

    public void setCondisc(StringProperty condisc) {
        this.condisc = condisc;
    }

    public StringProperty getFirstpre() {
        return firstpre;
    }

    public void setFirstpre(StringProperty firstpre) {
        this.firstpre = firstpre;
    }

    public StringProperty getSp_firstpre() {
        return sp_firstpre;
    }

    public void setSp_firstpre(StringProperty sp_firstpre) {
        this.sp_firstpre = sp_firstpre;
    }

    public StringProperty getKaryo() {
        return karyo;
    }

    public void setKaryo(StringProperty karyo) {
        this.karyo = karyo;
    }

    public StringProperty getSp_cario() {
        return sp_cario;
    }

    public void setSp_cario(StringProperty sp_cario) {
        this.sp_cario = sp_cario;
    }

    public StringProperty getGentest() {
        return gentest;
    }

    public void setGentest(StringProperty gentest) {
        this.gentest = gentest;
    }

    public StringProperty getSp_gentest() {
        return sp_gentest;
    }

    public void setSp_gentest(StringProperty sp_gentest) {
        this.sp_gentest = sp_gentest;
    }

    public StringProperty getSurgery() {
        return surgery;
    }

    public void setSurgery(StringProperty surgery) {
        this.surgery = surgery;
    }

    public StringProperty getPm() {
        return pm;
    }

    public void setPm(StringProperty pm) {
        this.pm = pm;
    }

    public StringProperty getPm_notes() {
        return pm_notes;
    }

    public void setPm_notes(StringProperty pm_notes) {
        this.pm_notes = pm_notes;
    }

    public StringProperty getDiagnosis_syndrome() {
        return diagnosis_syndrome;
    }

    public void setDiagnosis_syndrome(StringProperty diagnosis_syndrome) {
        this.diagnosis_syndrome = diagnosis_syndrome;
    }

    public StringProperty getPresyn() {
        return presyn;
    }

    public void setPresyn(StringProperty presyn) {
        this.presyn = presyn;
    }

    public StringProperty getDiagnosis_malformation_1() {
        return diagnosis_malformation_1;
    }

    public void setDiagnosis_malformation_1(StringProperty diagnosis_malformation_1) {
        this.diagnosis_malformation_1 = diagnosis_malformation_1;
    }

    public StringProperty getPremal1() {
        return premal1;
    }

    public void setPremal1(StringProperty premal1) {
        this.premal1 = premal1;
    }

    public StringProperty getDiagnosis_malformation_2() {
        return diagnosis_malformation_2;
    }

    public void setDiagnosis_malformation_2(StringProperty diagnosis_malformation_2) {
        this.diagnosis_malformation_2 = diagnosis_malformation_2;
    }

    public StringProperty getPremal2() {
        return premal2;
    }

    public void setPremal2(StringProperty premal2) {
        this.premal2 = premal2;
    }

    public StringProperty getDiagnosis_malformation_3() {
        return diagnosis_malformation_3;
    }

    public void setDiagnosis_malformation_3(StringProperty diagnosis_malformation_3) {
        this.diagnosis_malformation_3 = diagnosis_malformation_3;
    }

    public StringProperty getPremal3() {
        return premal3;
    }

    public void setPremal3(StringProperty premal3) {
        this.premal3 = premal3;
    }

    public StringProperty getDiagnosis_malformation_4() {
        return diagnosis_malformation_4;
    }

    public void setDiagnosis_malformation_4(StringProperty diagnosis_malformation_4) {
        this.diagnosis_malformation_4 = diagnosis_malformation_4;
    }

    public StringProperty getPremal4() {
        return premal4;
    }

    public void setPremal4(StringProperty premal4) {
        this.premal4 = premal4;
    }

    public StringProperty getDiagnosis_malformation_5() {
        return diagnosis_malformation_5;
    }

    public void setDiagnosis_malformation_5(StringProperty diagnosis_malformation_5) {
        this.diagnosis_malformation_5 = diagnosis_malformation_5;
    }

    public StringProperty getPremal5() {
        return premal5;
    }

    public void setPremal5(StringProperty premal5) {
        this.premal5 = premal5;
    }

    public StringProperty getDiagnosis_malformation_6() {
        return diagnosis_malformation_6;
    }

    public void setDiagnosis_malformation_6(StringProperty diagnosis_malformation_6) {
        this.diagnosis_malformation_6 = diagnosis_malformation_6;
    }

    public StringProperty getPremal6() {
        return premal6;
    }

    public void setPremal6(StringProperty premal6) {
        this.premal6 = premal6;
    }

    public StringProperty getDiagnosis_malformation_7() {
        return diagnosis_malformation_7;
    }

    public void setDiagnosis_malformation_7(StringProperty diagnosis_malformation_7) {
        this.diagnosis_malformation_7 = diagnosis_malformation_7;
    }

    public StringProperty getPremal7() {
        return premal7;
    }

    public void setPremal7(StringProperty premal7) {
        this.premal7 = premal7;
    }

    public StringProperty getDiagnosis_malformation_8() {
        return diagnosis_malformation_8;
    }

    public void setDiagnosis_malformation_8(StringProperty diagnosis_malformation_8) {
        this.diagnosis_malformation_8 = diagnosis_malformation_8;
    }

    public StringProperty getPremal8() {
        return premal8;
    }

    public void setPremal8(StringProperty premal8) {
        this.premal8 = premal8;
    }

    public StringProperty getValid_case() {
        return valid_case;
    }

    public void setValid_case(StringProperty valid_case) {
        this.valid_case = valid_case;
    }

    public StringProperty getValidation_notes() {
        return validation_notes;
    }

    public void setValidation_notes(StringProperty validation_notes) {
        this.validation_notes = validation_notes;
    }

    public StringProperty getImer_key() {
        return imer_key;
    }

    public void setImer_key(StringProperty imer_key) {
        this.imer_key = imer_key;
    }

    public StringProperty getSyndrome() {
        return syndrome;
    }

    public void setSyndrome(StringProperty syndrome) {
        this.syndrome = syndrome;
    }

    public StringProperty getSyndrome_desc_detail() {
        return syndrome_desc_detail;
    }

    public void setSyndrome_desc_detail(StringProperty syndrome_desc_detail) {
        this.syndrome_desc_detail = syndrome_desc_detail;
    }

    public StringProperty getSp_syndrome() {
        return sp_syndrome;
    }

    public void setSp_syndrome(StringProperty sp_syndrome) {
        this.sp_syndrome = sp_syndrome;
    }

    public StringProperty getOmim() {
        return omim;
    }

    public void setOmim(StringProperty omim) {
        this.omim = omim;
    }

    public StringProperty getOrpha() {
        return orpha;
    }

    public void setOrpha(StringProperty orpha) {
        this.orpha = orpha;
    }

    public StringProperty getMalfo1() {
        return malfo1;
    }

    public void setMalfo1(StringProperty malfo1) {
        this.malfo1 = malfo1;
    }

    public StringProperty getMalf1_desc_detail() {
        return malf1_desc_detail;
    }

    public void setMalf1_desc_detail(StringProperty malf1_desc_detail) {
        this.malf1_desc_detail = malf1_desc_detail;
    }

    public StringProperty getSp_malfo1() {
        return sp_malfo1;
    }

    public void setSp_malfo1(StringProperty sp_malfo1) {
        this.sp_malfo1 = sp_malfo1;
    }

    public StringProperty getMalfo2() {
        return malfo2;
    }

    public void setMalfo2(StringProperty malfo2) {
        this.malfo2 = malfo2;
    }

    public StringProperty getMalfo2_desc_detail() {
        return malfo2_desc_detail;
    }

    public void setMalfo2_desc_detail(StringProperty malfo2_desc_detail) {
        this.malfo2_desc_detail = malfo2_desc_detail;
    }

    public StringProperty getSp_malfo2() {
        return sp_malfo2;
    }

    public void setSp_malfo2(StringProperty sp_malfo2) {
        this.sp_malfo2 = sp_malfo2;
    }

    public StringProperty getMalfo3() {
        return malfo3;
    }

    public void setMalfo3(StringProperty malfo3) {
        this.malfo3 = malfo3;
    }

    public StringProperty getMalfo_3_desc_detail() {
        return malfo_3_desc_detail;
    }

    public void setMalfo_3_desc_detail(StringProperty malfo_3_desc_detail) {
        this.malfo_3_desc_detail = malfo_3_desc_detail;
    }

    public StringProperty getSp_malfo3() {
        return sp_malfo3;
    }

    public void setSp_malfo3(StringProperty sp_malfo3) {
        this.sp_malfo3 = sp_malfo3;
    }

    public StringProperty getMalfo4() {
        return malfo4;
    }

    public void setMalfo4(StringProperty malfo4) {
        this.malfo4 = malfo4;
    }

    public StringProperty getMalfo4_desc_detail() {
        return malfo4_desc_detail;
    }

    public void setMalfo4_desc_detail(StringProperty malfo4_desc_detail) {
        this.malfo4_desc_detail = malfo4_desc_detail;
    }

    public StringProperty getSp_malfo4() {
        return sp_malfo4;
    }

    public void setSp_malfo4(StringProperty sp_malfo4) {
        this.sp_malfo4 = sp_malfo4;
    }

    public StringProperty getMalfo5() {
        return malfo5;
    }

    public void setMalfo5(StringProperty malfo5) {
        this.malfo5 = malfo5;
    }

    public StringProperty getMalfo5_desc_detail() {
        return malfo5_desc_detail;
    }

    public void setMalfo5_desc_detail(StringProperty malfo5_desc_detail) {
        this.malfo5_desc_detail = malfo5_desc_detail;
    }

    public StringProperty getSp_malfo5() {
        return sp_malfo5;
    }

    public void setSp_malfo5(StringProperty sp_malfo5) {
        this.sp_malfo5 = sp_malfo5;
    }

    public StringProperty getMalfo6() {
        return malfo6;
    }

    public void setMalfo6(StringProperty malfo6) {
        this.malfo6 = malfo6;
    }

    public StringProperty getMalfo6_desc_detail() {
        return malfo6_desc_detail;
    }

    public void setMalfo6_desc_detail(StringProperty malfo6_desc_detail) {
        this.malfo6_desc_detail = malfo6_desc_detail;
    }

    public StringProperty getSp_malfo6() {
        return sp_malfo6;
    }

    public void setSp_malfo6(StringProperty sp_malfo6) {
        this.sp_malfo6 = sp_malfo6;
    }

    public StringProperty getMalfo7() {
        return malfo7;
    }

    public void setMalfo7(StringProperty malfo7) {
        this.malfo7 = malfo7;
    }

    public StringProperty getMalfo7_desc_detail() {
        return malfo7_desc_detail;
    }

    public void setMalfo7_desc_detail(StringProperty malfo7_desc_detail) {
        this.malfo7_desc_detail = malfo7_desc_detail;
    }

    public StringProperty getSp_malfo7() {
        return sp_malfo7;
    }

    public void setSp_malfo7(StringProperty sp_malfo7) {
        this.sp_malfo7 = sp_malfo7;
    }

    public StringProperty getMalfo8() {
        return malfo8;
    }

    public void setMalfo8(StringProperty malfo8) {
        this.malfo8 = malfo8;
    }

    public StringProperty getMalf8_desc_detail() {
        return malf8_desc_detail;
    }

    public void setMalf8_desc_detail(StringProperty malf8_desc_detail) {
        this.malf8_desc_detail = malf8_desc_detail;
    }

    public StringProperty getSp_malfo8() {
        return sp_malfo8;
    }

    public void setSp_malfo8(StringProperty sp_malfo8) {
        this.sp_malfo8 = sp_malfo8;
    }

    public StringProperty getNotes() {
        return notes;
    }

    public void setNotes(StringProperty notes) {
        this.notes = notes;
    }

    public StringProperty getAssconcept() {
        return assconcept;
    }

    public void setAssconcept(StringProperty assconcept) {
        this.assconcept = assconcept;
    }

    public StringProperty getAgefa() {
        return agefa;
    }

    public void setAgefa(StringProperty agefa) {
        this.agefa = agefa;
    }

    public StringProperty getSocf() {
        return socf;
    }

    public void setSocf(StringProperty socf) {
        this.socf = socf;
    }

    public StringProperty getOccupmo() {
        return occupmo;
    }

    public void setOccupmo(StringProperty occupmo) {
        this.occupmo = occupmo;
    }

    public StringProperty getMatdiab() {
        return matdiab;
    }

    public void setMatdiab(StringProperty matdiab) {
        this.matdiab = matdiab;
    }

    public StringProperty getIllbef1() {
        return illbef1;
    }

    public void setIllbef1(StringProperty illbef1) {
        this.illbef1 = illbef1;
    }

    public StringProperty getSp_illbef1() {
        return sp_illbef1;
    }

    public void setSp_illbef1(StringProperty sp_illbef1) {
        this.sp_illbef1 = sp_illbef1;
    }

    public StringProperty getIcd9illbef1() {
        return icd9illbef1;
    }

    public void setIcd9illbef1(StringProperty icd9illbef1) {
        this.icd9illbef1 = icd9illbef1;
    }

    public StringProperty getIllbef2() {
        return illbef2;
    }

    public void setIllbef2(StringProperty illbef2) {
        this.illbef2 = illbef2;
    }

    public StringProperty getSp_illbef2() {
        return sp_illbef2;
    }

    public void setSp_illbef2(StringProperty sp_illbef2) {
        this.sp_illbef2 = sp_illbef2;
    }

    public StringProperty getIcd9illbef2() {
        return icd9illbef2;
    }

    public void setIcd9illbef2(StringProperty icd9illbef2) {
        this.icd9illbef2 = icd9illbef2;
    }

    public StringProperty getIlldur1() {
        return illdur1;
    }

    public void setIlldur1(StringProperty illdur1) {
        this.illdur1 = illdur1;
    }

    public StringProperty getSp_illdur1() {
        return sp_illdur1;
    }

    public void setSp_illdur1(StringProperty sp_illdur1) {
        this.sp_illdur1 = sp_illdur1;
    }

    public StringProperty getIcd9illdur1() {
        return icd9illdur1;
    }

    public void setIcd9illdur1(StringProperty icd9illdur1) {
        this.icd9illdur1 = icd9illdur1;
    }

    public StringProperty getIlldur2() {
        return illdur2;
    }

    public void setIlldur2(StringProperty illdur2) {
        this.illdur2 = illdur2;
    }

    public StringProperty getSp_illdur2() {
        return sp_illdur2;
    }

    public void setSp_illdur2(StringProperty sp_illdur2) {
        this.sp_illdur2 = sp_illdur2;
    }

    public StringProperty getIcd9illdur2() {
        return icd9illdur2;
    }

    public void setIcd9illdur2(StringProperty icd9illdur2) {
        this.icd9illdur2 = icd9illdur2;
    }

    public StringProperty getFolic_g14() {
        return folic_g14;
    }

    public void setFolic_g14(StringProperty folic_g14) {
        this.folic_g14 = folic_g14;
    }

    public StringProperty getExtra_drugs() {
        return extra_drugs;
    }

    public void setExtra_drugs(StringProperty extra_drugs) {
        this.extra_drugs = extra_drugs;
    }

    public StringProperty getFirsttri() {
        return firsttri;
    }

    public void setFirsttri(StringProperty firsttri) {
        this.firsttri = firsttri;
    }

    public StringProperty getDrugs1() {
        return drugs1;
    }

    public void setDrugs1(StringProperty drugs1) {
        this.drugs1 = drugs1;
    }

    public StringProperty getSp_ifnotlisted_medication() {
        return sp_ifnotlisted_medication;
    }

    public void setSp_ifnotlisted_medication(StringProperty sp_ifnotlisted_medication) {
        this.sp_ifnotlisted_medication = sp_ifnotlisted_medication;
    }

    public StringProperty getSp_drugs() {
        return sp_drugs;
    }

    public void setSp_drugs(StringProperty sp_drugs) {
        this.sp_drugs = sp_drugs;
    }

    public StringProperty getDrugs2() {
        return drugs2;
    }

    public void setDrugs2(StringProperty drugs2) {
        this.drugs2 = drugs2;
    }

    public StringProperty getSp_ifnotlisted_medication_2() {
        return sp_ifnotlisted_medication_2;
    }

    public void setSp_ifnotlisted_medication_2(StringProperty sp_ifnotlisted_medication_2) {
        this.sp_ifnotlisted_medication_2 = sp_ifnotlisted_medication_2;
    }

    public StringProperty getSp_drugs_2() {
        return sp_drugs_2;
    }

    public void setSp_drugs_2(StringProperty sp_drugs_2) {
        this.sp_drugs_2 = sp_drugs_2;
    }

    public StringProperty getDrugs3() {
        return drugs3;
    }

    public void setDrugs3(StringProperty drugs3) {
        this.drugs3 = drugs3;
    }

    public StringProperty getSp_ifnotlisted_medication_3() {
        return sp_ifnotlisted_medication_3;
    }

    public void setSp_ifnotlisted_medication_3(StringProperty sp_ifnotlisted_medication_3) {
        this.sp_ifnotlisted_medication_3 = sp_ifnotlisted_medication_3;
    }

    public StringProperty getSp_drugs_3() {
        return sp_drugs_3;
    }

    public void setSp_drugs_3(StringProperty sp_drugs_3) {
        this.sp_drugs_3 = sp_drugs_3;
    }

    public StringProperty getDrugs4() {
        return drugs4;
    }

    public void setDrugs4(StringProperty drugs4) {
        this.drugs4 = drugs4;
    }

    public StringProperty getSp_ifnotlisted_medication_4() {
        return sp_ifnotlisted_medication_4;
    }

    public void setSp_ifnotlisted_medication_4(StringProperty sp_ifnotlisted_medication_4) {
        this.sp_ifnotlisted_medication_4 = sp_ifnotlisted_medication_4;
    }

    public StringProperty getSp_drugs_4() {
        return sp_drugs_4;
    }

    public void setSp_drugs_4(StringProperty sp_drugs_4) {
        this.sp_drugs_4 = sp_drugs_4;
    }

    public StringProperty getDrugs5() {
        return drugs5;
    }

    public void setDrugs5(StringProperty drugs5) {
        this.drugs5 = drugs5;
    }

    public StringProperty getSp_ifnotlisted_medication_5() {
        return sp_ifnotlisted_medication_5;
    }

    public void setSp_ifnotlisted_medication_5(StringProperty sp_ifnotlisted_medication_5) {
        this.sp_ifnotlisted_medication_5 = sp_ifnotlisted_medication_5;
    }

    public StringProperty getSp_drugs_5() {
        return sp_drugs_5;
    }

    public void setSp_drugs_5(StringProperty sp_drugs_5) {
        this.sp_drugs_5 = sp_drugs_5;
    }

    public StringProperty getInf_cov_test() {
        return inf_cov_test;
    }

    public void setInf_cov_test(StringProperty inf_cov_test) {
        this.inf_cov_test = inf_cov_test;
    }

    public StringProperty getImm_cov_test() {
        return imm_cov_test;
    }

    public void setImm_cov_test(StringProperty imm_cov_test) {
        this.imm_cov_test = imm_cov_test;
    }

    public StringProperty getOth_cov_test() {
        return oth_cov_test;
    }

    public void setOth_cov_test(StringProperty oth_cov_test) {
        this.oth_cov_test = oth_cov_test;
    }

    public StringProperty getSp_oth_cov_test() {
        return sp_oth_cov_test;
    }

    public void setSp_oth_cov_test(StringProperty sp_oth_cov_test) {
        this.sp_oth_cov_test = sp_oth_cov_test;
    }

    public StringProperty getStart_cov() {
        return start_cov;
    }

    public void setStart_cov(StringProperty start_cov) {
        this.start_cov = start_cov;
    }

    public StringProperty getCov_severity() {
        return cov_severity;
    }

    public void setCov_severity(StringProperty cov_severity) {
        this.cov_severity = cov_severity;
    }

    public StringProperty getConsang() {
        return consang;
    }

    public void setConsang(StringProperty consang) {
        this.consang = consang;
    }

    public StringProperty getSp_consang() {
        return sp_consang;
    }

    public void setSp_consang(StringProperty sp_consang) {
        this.sp_consang = sp_consang;
    }

    public StringProperty getSibanom() {
        return sibanom;
    }

    public void setSibanom(StringProperty sibanom) {
        this.sibanom = sibanom;
    }

    public StringProperty getSp_sibanom() {
        return sp_sibanom;
    }

    public void setSp_sibanom(StringProperty sp_sibanom) {
        this.sp_sibanom = sp_sibanom;
    }

    public StringProperty getPrevsib() {
        return prevsib;
    }

    public void setPrevsib(StringProperty prevsib) {
        this.prevsib = prevsib;
    }

    public StringProperty getSib1() {
        return sib1;
    }

    public void setSib1(StringProperty sib1) {
        this.sib1 = sib1;
    }

    public StringProperty getSib2() {
        return sib2;
    }

    public void setSib2(StringProperty sib2) {
        this.sib2 = sib2;
    }

    public StringProperty getSib3() {
        return sib3;
    }

    public void setSib3(StringProperty sib3) {
        this.sib3 = sib3;
    }

    public StringProperty getMoanom() {
        return moanom;
    }

    public void setMoanom(StringProperty moanom) {
        this.moanom = moanom;
    }

    public StringProperty getSp_moanom() {
        return sp_moanom;
    }

    public void setSp_moanom(StringProperty sp_moanom) {
        this.sp_moanom = sp_moanom;
    }

    public StringProperty getFaanom() {
        return faanom;
    }

    public void setFaanom(StringProperty faanom) {
        this.faanom = faanom;
    }

    public StringProperty getSp_faanom() {
        return sp_faanom;
    }

    public void setSp_faanom(StringProperty sp_faanom) {
        this.sp_faanom = sp_faanom;
    }

    public StringProperty getMatedu() {
        return matedu;
    }

    public void setMatedu(StringProperty matedu) {
        this.matedu = matedu;
    }

    public StringProperty getSocm() {
        return socm;
    }

    public void setSocm(StringProperty socm) {
        this.socm = socm;
    }

    public StringProperty getMigrant() {
        return migrant;
    }

    public void setMigrant(StringProperty migrant) {
        this.migrant = migrant;
    }

    public StringProperty getGenrem() {
        return genrem;
    }

    public void setGenrem(StringProperty genrem) {
        this.genrem = genrem;
    }

    public StringProperty getCohort() {
        return cohort;
    }

    public void setCohort(StringProperty cohort) {
        this.cohort = cohort;
    }

    public StringProperty getBirthCenter() {
        return birthCenter;
    }

    public void setBirthCenter(StringProperty birthCenter) {
        this.birthCenter = birthCenter;
    }

    public StringProperty getSdo_number_std() {
        return sdo_number_std;
    }

    public void setSdo_number_std(StringProperty sdo_number_std) {
        this.sdo_number_std = sdo_number_std;
    }

    public StringProperty getData_source() {
        return data_source;
    }

    public void setData_source(StringProperty data_source) {
        this.data_source = data_source;
    }

    public StringProperty getLinkageKey() {
        return linkageKey;
    }

    public void setLinkageKey(StringProperty linkageKey) {
        this.linkageKey = linkageKey;
    }

    public StringProperty getCedap_linked() {
        return cedap_linked;
    }

    public void setCedap_linked(StringProperty cedap_linked) {
        this.cedap_linked = cedap_linked;
    }

    public StringProperty getImer_key_factor() {
        return imer_key_factor;
    }

    public void setImer_key_factor(StringProperty imer_key_factor) {
        this.imer_key_factor = imer_key_factor;
    }

    public StringProperty getSyndrome_factor() {
        return syndrome_factor;
    }

    public void setSyndrome_factor(StringProperty syndrome_factor) {
        this.syndrome_factor = syndrome_factor;
    }

    public StringProperty getMalfo1_factor() {
        return malfo1_factor;
    }

    public void setMalfo1_factor(StringProperty malfo1_factor) {
        this.malfo1_factor = malfo1_factor;
    }

    public StringProperty getMalfo2_factor() {
        return malfo2_factor;
    }

    public void setMalfo2_factor(StringProperty malfo2_factor) {
        this.malfo2_factor = malfo2_factor;
    }

    public StringProperty getMalfo3_factor() {
        return malfo3_factor;
    }

    public void setMalfo3_factor(StringProperty malfo3_factor) {
        this.malfo3_factor = malfo3_factor;
    }

    public StringProperty getMalfo4_factor() {
        return malfo4_factor;
    }

    public void setMalfo4_factor(StringProperty malfo4_factor) {
        this.malfo4_factor = malfo4_factor;
    }

    public StringProperty getMalfo5_factor() {
        return malfo5_factor;
    }

    public void setMalfo5_factor(StringProperty malfo5_factor) {
        this.malfo5_factor = malfo5_factor;
    }

    public StringProperty getMalfo6_factor() {
        return malfo6_factor;
    }

    public void setMalfo6_factor(StringProperty malfo6_factor) {
        this.malfo6_factor = malfo6_factor;
    }

    public StringProperty getMalfo7_factor() {
        return malfo7_factor;
    }

    public void setMalfo7_factor(StringProperty malfo7_factor) {
        this.malfo7_factor = malfo7_factor;
    }

    public StringProperty getMalfo8_factor() {
        return malfo8_factor;
    }

    public void setMalfo8_factor(StringProperty malfo8_factor) {
        this.malfo8_factor = malfo8_factor;
    }

    public StringProperty getIllbef1_factor() {
        return illbef1_factor;
    }

    public void setIllbef1_factor(StringProperty illbef1_factor) {
        this.illbef1_factor = illbef1_factor;
    }

    public StringProperty getIllbef2_factor() {
        return illbef2_factor;
    }

    public void setIllbef2_factor(StringProperty illbef2_factor) {
        this.illbef2_factor = illbef2_factor;
    }

    public StringProperty getIlldur1_factor() {
        return illdur1_factor;
    }

    public void setIlldur1_factor(StringProperty illdur1_factor) {
        this.illdur1_factor = illdur1_factor;
    }

    public StringProperty getIlldur2_factor() {
        return illdur2_factor;
    }

    public void setIlldur2_factor(StringProperty illdur2_factor) {
        this.illdur2_factor = illdur2_factor;
    }
    
    
    
    // END CLASS

    @Override
    public String toString() {
        return super.toString(); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }
   
}