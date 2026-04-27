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

public class Sdo {

    public IntegerProperty id_sdo = new SimpleIntegerProperty();
    public StringProperty revCode = new SimpleStringProperty();
    public StringProperty cedap_linked = new SimpleStringProperty();
    public StringProperty COD_RG = new SimpleStringProperty();
    public StringProperty COD_PRES = new SimpleStringProperty();
    public StringProperty AA_SDO = new SimpleStringProperty();
    public StringProperty PROG_SDO = new SimpleStringProperty();
    public StringProperty AA_DIM = new SimpleStringProperty();
    public StringProperty COD_AZI = new SimpleStringProperty();
    public StringProperty COM_RES = new SimpleStringProperty();
    public StringProperty dt_amm = new SimpleStringProperty();
    public StringProperty dt_dim = new SimpleStringProperty();
    public StringProperty COD_DISD = new SimpleStringProperty();
    public StringProperty DRG_RG = new SimpleStringProperty();
    public StringProperty TIPO_DRG = new SimpleStringProperty();
    public StringProperty ETA = new SimpleStringProperty();
    public StringProperty ETA_GG = new SimpleStringProperty();
    public StringProperty GG_DEG = new SimpleStringProperty();
    public StringProperty GG_DEGOP = new SimpleStringProperty();
    public StringProperty MOD_DIM = new SimpleStringProperty();
    public StringProperty MPR = new SimpleStringProperty();
    public StringProperty NEO_TRASF = new SimpleStringProperty();
    public StringProperty COD_PAT1 = new SimpleStringProperty();
    public StringProperty FLAG_PAT = new SimpleStringProperty();
    public StringProperty PESO_GR = new SimpleStringProperty();
    public StringProperty PROV_RES = new SimpleStringProperty();
    public StringProperty REGIME_R = new SimpleStringProperty();
    public StringProperty RG_RES = new SimpleStringProperty();
    public StringProperty SEX = new SimpleStringProperty();
    public StringProperty SUB_COD = new SimpleStringProperty();
    public StringProperty PROG_PAZ = new SimpleStringProperty();
    public StringProperty patol2 = new SimpleStringProperty();
    public StringProperty patol3 = new SimpleStringProperty();
    public StringProperty patol4 = new SimpleStringProperty();
    public StringProperty patol5 = new SimpleStringProperty();
    public StringProperty patol6 = new SimpleStringProperty();
    public StringProperty interv1 = new SimpleStringProperty();
    public StringProperty interv2 = new SimpleStringProperty();
    public StringProperty interv3 = new SimpleStringProperty();
    public StringProperty interv4 = new SimpleStringProperty();
    public StringProperty interv5 = new SimpleStringProperty();
    public StringProperty interv6 = new SimpleStringProperty();
    public StringProperty interv7 = new SimpleStringProperty();
    public StringProperty interv8 = new SimpleStringProperty();
    public StringProperty interv9 = new SimpleStringProperty();
    public StringProperty interv10 = new SimpleStringProperty();
    public StringProperty interv11 = new SimpleStringProperty();
    public StringProperty ospedale = new SimpleStringProperty();
    public StringProperty dt_nasc = new SimpleStringProperty();
    public StringProperty dt_decesso = new SimpleStringProperty();
    public StringProperty cohort = new SimpleStringProperty();
    public StringProperty daysAfterDelivery = new SimpleStringProperty();
    public StringProperty validated = new SimpleStringProperty();
    public StringProperty validation_type = new SimpleStringProperty();
    public StringProperty eta_gestazionale = new SimpleStringProperty();
    public StringProperty CIRCONFERENZA_CRANICA = new SimpleStringProperty();
    public StringProperty CONCEPIMENTI_PRECEDENTI = new SimpleStringProperty();
    public StringProperty violazione_filtro = new SimpleStringProperty();
    public StringProperty malformazione_tipo = new SimpleStringProperty();
    public StringProperty score = new SimpleStringProperty();
    public StringProperty sds_cc = new SimpleStringProperty();
    public StringProperty COD_STAB = new SimpleStringProperty();
    public StringProperty SDO_MADRE = new SimpleStringProperty();
    public StringProperty SDO_NEO = new SimpleStringProperty();
    public StringProperty prog_paz_m = new SimpleStringProperty();
    public StringProperty nati_femmine = new SimpleStringProperty();
    public StringProperty nati_maschi = new SimpleStringProperty();
    public StringProperty riscontro_autoptico = new SimpleStringProperty();
    public StringProperty Genere_del_parto = new SimpleStringProperty();
    public StringProperty data_nascita_padre = new SimpleStringProperty();
    public StringProperty ALTRA_MALATTIA_DELLA_MADRE = new SimpleStringProperty();
    public StringProperty STATO_CIVILE_MADRE = new SimpleStringProperty();
    public StringProperty MALATTIA_PRINCIPALE_DELLA_MADRE = new SimpleStringProperty();
    public StringProperty metodi_PMA = new SimpleStringProperty();
    public StringProperty ECOGRAFIA_OLTRE22SETTIMANE = new SimpleStringProperty();
    public StringProperty FETOSCOPIA = new SimpleStringProperty();
    public StringProperty VILLOCENTESI = new SimpleStringProperty();
    public StringProperty AMNIOCENTESI = new SimpleStringProperty();
    public StringProperty TEST_COMBINATO = new SimpleStringProperty();
    public StringProperty CITTADINANZA_M = new SimpleStringProperty();
    public StringProperty VITALITA = new SimpleStringProperty();
    public StringProperty NUMERO_ECOGRAFIE = new SimpleStringProperty();
    public StringProperty CONSANGUINEITA = new SimpleStringProperty();
    public StringProperty dt_nas_m = new SimpleStringProperty();
    public StringProperty PESO_MADRE_AL_PARTO = new SimpleStringProperty();
    public StringProperty PESO_MADRE_PREGRAVIDICO = new SimpleStringProperty();
    public StringProperty ALTEZZA_MADRE = new SimpleStringProperty();
    public StringProperty ABITUDINE_AL_FUMO = new SimpleStringProperty();
    public StringProperty MALATTIE_INSORTE_IN_GRAVIDANZA_1 = new SimpleStringProperty();
    public StringProperty MALATTIE_INSORTE_IN_GRAVIDANZA_2 = new SimpleStringProperty();
    public StringProperty MALFORMAZIONI_MADRE = new SimpleStringProperty();
    public StringProperty MALFORMAZIONI_PADRE = new SimpleStringProperty();
    public StringProperty MALFORMAZIONI_GENITORI_MADRE = new SimpleStringProperty();
    public StringProperty MALFORMAZIONI_GENITORI_PADRE = new SimpleStringProperty();
    public StringProperty MALFORMAZIONI_PARENTI_MADRE = new SimpleStringProperty();
    public StringProperty MALFORMAZIONI_PARENTI_PADRE = new SimpleStringProperty();
    public StringProperty MALFORMAZIONI_FRATELLI_SORELLE = new SimpleStringProperty();
    public StringProperty ETA_GESTAZIONALE_ALLA_DIAGNOSI = new SimpleStringProperty();
    public StringProperty CARIOTIPO_DEL_NATO = new SimpleStringProperty();
    public StringProperty CONDIZIONE_PROF_PADRE = new SimpleStringProperty();
    public StringProperty TITOLO_DI_STUDIO_PADRE = new SimpleStringProperty();
    public StringProperty CONDIZIONE_PROF_MADRE = new SimpleStringProperty();
    public StringProperty TITOLO_DI_STUDIO_MADRE = new SimpleStringProperty();
    public StringProperty COD_PAT1_label = new SimpleStringProperty();
    public StringProperty patol2_label = new SimpleStringProperty();
    public StringProperty patol3_label = new SimpleStringProperty();
    public StringProperty patol4_label = new SimpleStringProperty();
    public StringProperty patol5_label = new SimpleStringProperty();
    public StringProperty patol6_label = new SimpleStringProperty();
    public StringProperty interv1_label = new SimpleStringProperty();
    public StringProperty interv2_label = new SimpleStringProperty();
    public StringProperty interv3_label = new SimpleStringProperty();
    public StringProperty interv4_label = new SimpleStringProperty();
    public StringProperty interv5_label = new SimpleStringProperty(); 
    public StringProperty interv6_label = new SimpleStringProperty();
    public StringProperty interv7_label = new SimpleStringProperty();
    public StringProperty interv8_label = new SimpleStringProperty();
    public StringProperty interv9_label = new SimpleStringProperty();
    public StringProperty interv10_label = new SimpleStringProperty();
    public StringProperty interv11_label = new SimpleStringProperty();
    public StringProperty COD_PAT1_code_icd10 = new SimpleStringProperty();
    public StringProperty patol2_code_icd10 = new SimpleStringProperty();
    public StringProperty patol3_code_icd10 = new SimpleStringProperty();
    public StringProperty patol4_code_icd10 = new SimpleStringProperty();
    public StringProperty patol5_code_icd10 = new SimpleStringProperty();
    public StringProperty patol6_code_icd10 = new SimpleStringProperty();
    public StringProperty COD_PAT1_label_icd10 = new SimpleStringProperty();
    public StringProperty patol2_label_icd10 = new SimpleStringProperty();
    public StringProperty patol3_label_icd10 = new SimpleStringProperty();
    public StringProperty patol4_label_icd10 = new SimpleStringProperty();
    public StringProperty patol5_label_icd10 = new SimpleStringProperty();
    public StringProperty patol6_label_icd10 = new SimpleStringProperty();
    public StringProperty alreadyRecorded = new SimpleStringProperty();
    public StringProperty note = new SimpleStringProperty();

    
    public Sdo() {
    }
    
    // GETTERS AND SETTERS
    
    public IntegerProperty getId() {
        return  id_sdo;
    }

    public void setId(IntegerProperty id) {
        this.id_sdo = id;
    }

    public StringProperty getRevCode() {
        return revCode;
    }

    public void setRevCode(StringProperty revCode) {
        this.revCode = revCode;
    }

    public StringProperty getCedap_linked() {
        return cedap_linked;
    }

    public void setCedap_linked(StringProperty cedap_linked) {
        this.cedap_linked = cedap_linked;
    }

    public StringProperty getCOD_RG() {
        return COD_RG;
    }

    public void setCOD_RG(StringProperty COD_RG) {
        this.COD_RG = COD_RG;
    }

    public StringProperty getCOD_PRES() {
        return COD_PRES;
    }

    public void setCOD_PRES(StringProperty COD_PRES) {
        this.COD_PRES = COD_PRES;
    }

    public StringProperty getAA_SDO() {
        return AA_SDO;
    }

    public void setAA_SDO(StringProperty AA_SDO) {
        this.AA_SDO = AA_SDO;
    }

    public StringProperty getPROG_SDO() {
        return PROG_SDO;
    }

    public void setPROG_SDO(StringProperty PROG_SDO) {
        this.PROG_SDO = PROG_SDO;
    }

    public StringProperty getAA_DIM() {
        return AA_DIM;
    }

    public void setAA_DIM(StringProperty AA_DIM) {
        this.AA_DIM = AA_DIM;
    }

    public StringProperty getCOD_AZI() {
        return COD_AZI;
    }

    public void setCOD_AZI(StringProperty COD_AZI) {
        this.COD_AZI = COD_AZI;
    }

    public StringProperty getCOM_RES() {
        return COM_RES;
    }

    public void setCOM_RES(StringProperty COM_RES) {
        this.COM_RES = COM_RES;
    }

    public StringProperty getDt_amm() {
        return dt_amm;
    }

    public void setDt_amm(StringProperty dt_amm) {
        this.dt_amm = dt_amm;
    }

    public StringProperty getDt_dim() {
        return dt_dim;
    }

    public void setDt_dim(StringProperty dt_dim) {
        this.dt_dim = dt_dim;
    }

    public StringProperty getCOD_DISD() {
        return COD_DISD;
    }

    public void setCOD_DISD(StringProperty COD_DISD) {
        this.COD_DISD = COD_DISD;
    }

    public StringProperty getDRG_RG() {
        return DRG_RG;
    }

    public void setDRG_RG(StringProperty DRG_RG) {
        this.DRG_RG = DRG_RG;
    }

    public StringProperty getTIPO_DRG() {
        return TIPO_DRG;
    }

    public void setTIPO_DRG(StringProperty TIPO_DRG) {
        this.TIPO_DRG = TIPO_DRG;
    }

    public StringProperty getETA() {
        return ETA;
    }

    public void setETA(StringProperty ETA) {
        this.ETA = ETA;
    }

    public StringProperty getETA_GG() {
        return ETA_GG;
    }

    public void setETA_GG(StringProperty ETA_GG) {
        this.ETA_GG = ETA_GG;
    }

    public StringProperty getGG_DEG() {
        return GG_DEG;
    }

    public void setGG_DEG(StringProperty GG_DEG) {
        this.GG_DEG = GG_DEG;
    }

    public StringProperty getGG_DEGOP() {
        return GG_DEGOP;
    }

    public void setGG_DEGOP(StringProperty GG_DEGOP) {
        this.GG_DEGOP = GG_DEGOP;
    }

    public StringProperty getMOD_DIM() {
        return MOD_DIM;
    }

    public void setMOD_DIM(StringProperty MOD_DIM) {
        this.MOD_DIM = MOD_DIM;
    }

    public StringProperty getMPR() {
        return MPR;
    }

    public void setMPR(StringProperty MPR) {
        this.MPR = MPR;
    }

    public StringProperty getNEO_TRASF() {
        return NEO_TRASF;
    }

    public void setNEO_TRASF(StringProperty NEO_TRASF) {
        this.NEO_TRASF = NEO_TRASF;
    }

    public StringProperty getCOD_PAT1() {
        return COD_PAT1;
    }

    public void setCOD_PAT1(StringProperty COD_PAT1) {
        this.COD_PAT1 = COD_PAT1;
    }

    public StringProperty getFLAG_PAT() {
        return FLAG_PAT;
    }

    public void setFLAG_PAT(StringProperty FLAG_PAT) {
        this.FLAG_PAT = FLAG_PAT;
    }

    public StringProperty getPESO_GR() {
        return PESO_GR;
    }

    public void setPESO_GR(StringProperty PESO_GR) {
        this.PESO_GR = PESO_GR;
    }

    public StringProperty getPROV_RES() {
        return PROV_RES;
    }

    public void setPROV_RES(StringProperty PROV_RES) {
        this.PROV_RES = PROV_RES;
    }

    public StringProperty getREGIME_R() {
        return REGIME_R;
    }

    public void setREGIME_R(StringProperty REGIME_R) {
        this.REGIME_R = REGIME_R;
    }

    public StringProperty getRG_RES() {
        return RG_RES;
    }

    public void setRG_RES(StringProperty RG_RES) {
        this.RG_RES = RG_RES;
    }

    public StringProperty getSEX() {
        return SEX;
    }

    public void setSEX(StringProperty SEX) {
        this.SEX = SEX;
    }

    public StringProperty getSUB_COD() {
        return SUB_COD;
    }

    public void setSUB_COD(StringProperty SUB_COD) {
        this.SUB_COD = SUB_COD;
    }

    public StringProperty getPROG_PAZ() {
        return PROG_PAZ;
    }

    public void setPROG_PAZ(StringProperty PROG_PAZ) {
        this.PROG_PAZ = PROG_PAZ;
    }

    public StringProperty getPatol2() {
        return patol2;
    }

    public void setPatol2(StringProperty patol2) {
        this.patol2 = patol2;
    }

    public StringProperty getPatol3() {
        return patol3;
    }

    public void setPatol3(StringProperty patol3) {
        this.patol3 = patol3;
    }

    public StringProperty getPatol4() {
        return patol4;
    }

    public void setPatol4(StringProperty patol4) {
        this.patol4 = patol4;
    }

    public StringProperty getPatol5() {
        return patol5;
    }

    public void setPatol5(StringProperty patol5) {
        this.patol5 = patol5;
    }

    public StringProperty getPatol6() {
        return patol6;
    }

    public void setPatol6(StringProperty patol6) {
        this.patol6 = patol6;
    }

    public StringProperty getInterv1() {
        return interv1;
    }

    public void setInterv1(StringProperty interv1) {
        this.interv1 = interv1;
    }

    public StringProperty getInterv2() {
        return interv2;
    }

    public void setInterv2(StringProperty interv2) {
        this.interv2 = interv2;
    }

    public StringProperty getInterv3() {
        return interv3;
    }

    public void setInterv3(StringProperty interv3) {
        this.interv3 = interv3;
    }

    public StringProperty getInterv4() {
        return interv4;
    }

    public void setInterv4(StringProperty interv4) {
        this.interv4 = interv4;
    }

    public StringProperty getInterv5() {
        return interv5;
    }

    public void setInterv5(StringProperty interv5) {
        this.interv5 = interv5;
    }

    public StringProperty getInterv6() {
        return interv6;
    }

    public void setInterv6(StringProperty interv6) {
        this.interv6 = interv6;
    }

    public StringProperty getInterv7() {
        return interv7;
    }

    public void setInterv7(StringProperty interv7) {
        this.interv7 = interv7;
    }

    public StringProperty getInterv8() {
        return interv8;
    }

    public void setInterv8(StringProperty interv8) {
        this.interv8 = interv8;
    }

    public StringProperty getInterv9() {
        return interv9;
    }

    public void setInterv9(StringProperty interv9) {
        this.interv9 = interv9;
    }

    public StringProperty getInterv10() {
        return interv10;
    }

    public void setInterv10(StringProperty interv10) {
        this.interv10 = interv10;
    }

    public StringProperty getInterv11() {
        return interv11;
    }

    public void setInterv11(StringProperty interv11) {
        this.interv11 = interv11;
    }

    public StringProperty getOspedale() {
        return ospedale;
    }

    public void setOspedale(StringProperty ospedale) {
        this.ospedale = ospedale;
    }

    public StringProperty getDt_nasc() {
        return dt_nasc;
    }

    public void setDt_nasc(StringProperty dt_nasc) {
        this.dt_nasc = dt_nasc;
    }

    public StringProperty getDt_decesso() {
        return dt_decesso;
    }

    public void setDt_decesso(StringProperty dt_decesso) {
        this.dt_decesso = dt_decesso;
    }

    public StringProperty getCohort() {
        return cohort;
    }

    public void setCohort(StringProperty cohort) {
        this.cohort = cohort;
    }

    public StringProperty getDaysAfterDelivery() {
        return daysAfterDelivery;
    }

    public void setDaysAfterDelivery(StringProperty daysAfterDelivery) {
        this.daysAfterDelivery = daysAfterDelivery;
    }

    public StringProperty getValidated() {
        return validated;
    }

    public void setValidated(StringProperty validated) {
        this.validated = validated;
    }

    public StringProperty getValidation_type() {
        return validation_type;
    }

    public void setValidation_type(StringProperty validation_type) {
        this.validation_type = validation_type;
    }

    public StringProperty getEta_gestazionale() {
        return eta_gestazionale;
    }

    public void setEta_gestazionale(StringProperty eta_gestazionale) {
        this.eta_gestazionale = eta_gestazionale;
    }

    public StringProperty getCIRCONFERENZA_CRANICA() {
        return CIRCONFERENZA_CRANICA;
    }

    public void setCIRCONFERENZA_CRANICA(StringProperty CIRCONFERENZA_CRANICA) {
        this.CIRCONFERENZA_CRANICA = CIRCONFERENZA_CRANICA;
    }

    public StringProperty getCONCEPIMENTI_PRECEDENTI() {
        return CONCEPIMENTI_PRECEDENTI;
    }

    public void setCONCEPIMENTI_PRECEDENTI(StringProperty CONCEPIMENTI_PRECEDENTI) {
        this.CONCEPIMENTI_PRECEDENTI = CONCEPIMENTI_PRECEDENTI;
    }

    public StringProperty getViolazione_filtro() {
        return violazione_filtro;
    }

    public void setViolazione_filtro(StringProperty violazione_filtro) {
        this.violazione_filtro = violazione_filtro;
    }

    public StringProperty getMalformazione_tipo() {
        return malformazione_tipo;
    }

    public void setMalformazione_tipo(StringProperty malformazione_tipo) {
        this.malformazione_tipo = malformazione_tipo;
    }

    public StringProperty getScore() {
        return score;
    }

    public void setScore(StringProperty score) {
        this.score = score;
    }

    public StringProperty getSds_cc() {
        return sds_cc;
    }

    public void setSds_cc(StringProperty sds_cc) {
        this.sds_cc = sds_cc;
    }

    public StringProperty getCOD_STAB() {
        return COD_STAB;
    }

    public void setCOD_STAB(StringProperty COD_STAB) {
        this.COD_STAB = COD_STAB;
    }

    public StringProperty getSDO_MADRE() {
        return SDO_MADRE;
    }

    public void setSDO_MADRE(StringProperty SDO_MADRE) {
        this.SDO_MADRE = SDO_MADRE;
    }

    public StringProperty getSDO_NEO() {
        return SDO_NEO;
    }

    public void setSDO_NEO(StringProperty SDO_NEO) {
        this.SDO_NEO = SDO_NEO;
    }

    public StringProperty getProg_paz_m() {
        return prog_paz_m;
    }

    public void setProg_paz_m(StringProperty prog_paz_m) {
        this.prog_paz_m = prog_paz_m;
    }

    public StringProperty getNati_femmine() {
        return nati_femmine;
    }

    public void setNati_femmine(StringProperty nati_femmine) {
        this.nati_femmine = nati_femmine;
    }

    public StringProperty getNati_maschi() {
        return nati_maschi;
    }

    public void setNati_maschi(StringProperty nati_maschi) {
        this.nati_maschi = nati_maschi;
    }

    public StringProperty getRiscontro_autoptico() {
        return riscontro_autoptico;
    }

    public void setRiscontro_autoptico(StringProperty riscontro_autoptico) {
        this.riscontro_autoptico = riscontro_autoptico;
    }

    public StringProperty getGenere_del_parto() {
        return Genere_del_parto;
    }

    public void setGenere_del_parto(StringProperty Genere_del_parto) {
        this.Genere_del_parto = Genere_del_parto;
    }

    public StringProperty getData_nascita_padre() {
        return data_nascita_padre;
    }

    public void setData_nascita_padre(StringProperty data_nascita_padre) {
        this.data_nascita_padre = data_nascita_padre;
    }

    public StringProperty getALTRA_MALATTIA_DELLA_MADRE() {
        return ALTRA_MALATTIA_DELLA_MADRE;
    }

    public void setALTRA_MALATTIA_DELLA_MADRE(StringProperty ALTRA_MALATTIA_DELLA_MADRE) {
        this.ALTRA_MALATTIA_DELLA_MADRE = ALTRA_MALATTIA_DELLA_MADRE;
    }

    public StringProperty getSTATO_CIVILE_MADRE() {
        return STATO_CIVILE_MADRE;
    }

    public void setSTATO_CIVILE_MADRE(StringProperty STATO_CIVILE_MADRE) {
        this.STATO_CIVILE_MADRE = STATO_CIVILE_MADRE;
    }

    public StringProperty getMALATTIA_PRINCIPALE_DELLA_MADRE() {
        return MALATTIA_PRINCIPALE_DELLA_MADRE;
    }

    public void setMALATTIA_PRINCIPALE_DELLA_MADRE(StringProperty MALATTIA_PRINCIPALE_DELLA_MADRE) {
        this.MALATTIA_PRINCIPALE_DELLA_MADRE = MALATTIA_PRINCIPALE_DELLA_MADRE;
    }

    public StringProperty getMetodi_PMA() {
        return metodi_PMA;
    }

    public void setMetodi_PMA(StringProperty metodi_PMA) {
        this.metodi_PMA = metodi_PMA;
    }

    public StringProperty getECOGRAFIA_OLTRE22SETTIMANE() {
        return ECOGRAFIA_OLTRE22SETTIMANE;
    }

    public void setECOGRAFIA_OLTRE22SETTIMANE(StringProperty ECOGRAFIA_OLTRE22SETTIMANE) {
        this.ECOGRAFIA_OLTRE22SETTIMANE = ECOGRAFIA_OLTRE22SETTIMANE;
    }

    public StringProperty getFETOSCOPIA() {
        return FETOSCOPIA;
    }

    public void setFETOSCOPIA(StringProperty FETOSCOPIA) {
        this.FETOSCOPIA = FETOSCOPIA;
    }

    public StringProperty getVILLOCENTESI() {
        return VILLOCENTESI;
    }

    public void setVILLOCENTESI(StringProperty VILLOCENTESI) {
        this.VILLOCENTESI = VILLOCENTESI;
    }

    public StringProperty getAMNIOCENTESI() {
        return AMNIOCENTESI;
    }

    public void setAMNIOCENTESI(StringProperty AMNIOCENTESI) {
        this.AMNIOCENTESI = AMNIOCENTESI;
    }

    public StringProperty getTEST_COMBINATO() {
        return TEST_COMBINATO;
    }

    public void setTEST_COMBINATO(StringProperty TEST_COMBINATO) {
        this.TEST_COMBINATO = TEST_COMBINATO;
    }

    public StringProperty getCITTADINANZA_M() {
        return CITTADINANZA_M;
    }

    public void setCITTADINANZA_M(StringProperty CITTADINANZA_M) {
        this.CITTADINANZA_M = CITTADINANZA_M;
    }

    public StringProperty getVITALITA() {
        return VITALITA;
    }

    public void setVITALITA(StringProperty VITALITA) {
        this.VITALITA = VITALITA;
    }

    public StringProperty getNUMERO_ECOGRAFIE() {
        return NUMERO_ECOGRAFIE;
    }

    public void setNUMERO_ECOGRAFIE(StringProperty NUMERO_ECOGRAFIE) {
        this.NUMERO_ECOGRAFIE = NUMERO_ECOGRAFIE;
    }

    public StringProperty getCONSANGUINEITA() {
        return CONSANGUINEITA;
    }

    public void setCONSANGUINEITA(StringProperty CONSANGUINEITA) {
        this.CONSANGUINEITA = CONSANGUINEITA;
    }

    public StringProperty getDt_nas_m() {
        return dt_nas_m;
    }

    public void setDt_nas_m(StringProperty dt_nas_m) {
        this.dt_nas_m = dt_nas_m;
    }

    public StringProperty getPESO_MADRE_AL_PARTO() {
        return PESO_MADRE_AL_PARTO;
    }

    public void setPESO_MADRE_AL_PARTO(StringProperty PESO_MADRE_AL_PARTO) {
        this.PESO_MADRE_AL_PARTO = PESO_MADRE_AL_PARTO;
    }

    public StringProperty getPESO_MADRE_PREGRAVIDICO() {
        return PESO_MADRE_PREGRAVIDICO;
    }

    public void setPESO_MADRE_PREGRAVIDICO(StringProperty PESO_MADRE_PREGRAVIDICO) {
        this.PESO_MADRE_PREGRAVIDICO = PESO_MADRE_PREGRAVIDICO;
    }

    public StringProperty getALTEZZA_MADRE() {
        return ALTEZZA_MADRE;
    }

    public void setALTEZZA_MADRE(StringProperty ALTEZZA_MADRE) {
        this.ALTEZZA_MADRE = ALTEZZA_MADRE;
    }

    public StringProperty getABITUDINE_AL_FUMO() {
        return ABITUDINE_AL_FUMO;
    }

    public void setABITUDINE_AL_FUMO(StringProperty ABITUDINE_AL_FUMO) {
        this.ABITUDINE_AL_FUMO = ABITUDINE_AL_FUMO;
    }

    public StringProperty getMALATTIE_INSORTE_IN_GRAVIDANZA_1() {
        return MALATTIE_INSORTE_IN_GRAVIDANZA_1;
    }

    public void setMALATTIE_INSORTE_IN_GRAVIDANZA_1(StringProperty MALATTIE_INSORTE_IN_GRAVIDANZA_1) {
        this.MALATTIE_INSORTE_IN_GRAVIDANZA_1 = MALATTIE_INSORTE_IN_GRAVIDANZA_1;
    }

    public StringProperty getMALATTIE_INSORTE_IN_GRAVIDANZA_2() {
        return MALATTIE_INSORTE_IN_GRAVIDANZA_2;
    }

    public void setMALATTIE_INSORTE_IN_GRAVIDANZA_2(StringProperty MALATTIE_INSORTE_IN_GRAVIDANZA_2) {
        this.MALATTIE_INSORTE_IN_GRAVIDANZA_2 = MALATTIE_INSORTE_IN_GRAVIDANZA_2;
    }

    public StringProperty getMALFORMAZIONI_MADRE() {
        return MALFORMAZIONI_MADRE;
    }

    public void setMALFORMAZIONI_MADRE(StringProperty MALFORMAZIONI_MADRE) {
        this.MALFORMAZIONI_MADRE = MALFORMAZIONI_MADRE;
    }

    public StringProperty getMALFORMAZIONI_PADRE() {
        return MALFORMAZIONI_PADRE;
    }

    public void setMALFORMAZIONI_PADRE(StringProperty MALFORMAZIONI_PADRE) {
        this.MALFORMAZIONI_PADRE = MALFORMAZIONI_PADRE;
    }

    public StringProperty getMALFORMAZIONI_GENITORI_MADRE() {
        return MALFORMAZIONI_GENITORI_MADRE;
    }

    public void setMALFORMAZIONI_GENITORI_MADRE(StringProperty MALFORMAZIONI_GENITORI_MADRE) {
        this.MALFORMAZIONI_GENITORI_MADRE = MALFORMAZIONI_GENITORI_MADRE;
    }

    public StringProperty getMALFORMAZIONI_GENITORI_PADRE() {
        return MALFORMAZIONI_GENITORI_PADRE;
    }

    public void setMALFORMAZIONI_GENITORI_PADRE(StringProperty MALFORMAZIONI_GENITORI_PADRE) {
        this.MALFORMAZIONI_GENITORI_PADRE = MALFORMAZIONI_GENITORI_PADRE;
    }

    public StringProperty getMALFORMAZIONI_PARENTI_MADRE() {
        return MALFORMAZIONI_PARENTI_MADRE;
    }

    public void setMALFORMAZIONI_PARENTI_MADRE(StringProperty MALFORMAZIONI_PARENTI_MADRE) {
        this.MALFORMAZIONI_PARENTI_MADRE = MALFORMAZIONI_PARENTI_MADRE;
    }

    public StringProperty getMALFORMAZIONI_PARENTI_PADRE() {
        return MALFORMAZIONI_PARENTI_PADRE;
    }

    public void setMALFORMAZIONI_PARENTI_PADRE(StringProperty MALFORMAZIONI_PARENTI_PADRE) {
        this.MALFORMAZIONI_PARENTI_PADRE = MALFORMAZIONI_PARENTI_PADRE;
    }

    public StringProperty getMALFORMAZIONI_FRATELLI_SORELLE() {
        return MALFORMAZIONI_FRATELLI_SORELLE;
    }

    public void setMALFORMAZIONI_FRATELLI_SORELLE(StringProperty MALFORMAZIONI_FRATELLI_SORELLE) {
        this.MALFORMAZIONI_FRATELLI_SORELLE = MALFORMAZIONI_FRATELLI_SORELLE;
    }

    public StringProperty getETA_GESTAZIONALE_ALLA_DIAGNOSI() {
        return ETA_GESTAZIONALE_ALLA_DIAGNOSI;
    }

    public void setETA_GESTAZIONALE_ALLA_DIAGNOSI(StringProperty ETA_GESTAZIONALE_ALLA_DIAGNOSI) {
        this.ETA_GESTAZIONALE_ALLA_DIAGNOSI = ETA_GESTAZIONALE_ALLA_DIAGNOSI;
    }

    public StringProperty getCARIOTIPO_DEL_NATO() {
        return CARIOTIPO_DEL_NATO;
    }

    public void setCARIOTIPO_DEL_NATO(StringProperty CARIOTIPO_DEL_NATO) {
        this.CARIOTIPO_DEL_NATO = CARIOTIPO_DEL_NATO;
    }

    public StringProperty getCONDIZIONE_PROF_PADRE() {
        return CONDIZIONE_PROF_PADRE;
    }

    public void setCONDIZIONE_PROF_PADRE(StringProperty CONDIZIONE_PROF_PADRE) {
        this.CONDIZIONE_PROF_PADRE = CONDIZIONE_PROF_PADRE;
    }

    public StringProperty getTITOLO_DI_STUDIO_PADRE() {
        return TITOLO_DI_STUDIO_PADRE;
    }

    public void setTITOLO_DI_STUDIO_PADRE(StringProperty TITOLO_DI_STUDIO_PADRE) {
        this.TITOLO_DI_STUDIO_PADRE = TITOLO_DI_STUDIO_PADRE;
    }

    public StringProperty getCONDIZIONE_PROF_MADRE() {
        return CONDIZIONE_PROF_MADRE;
    }

    public void setCONDIZIONE_PROF_MADRE(StringProperty CONDIZIONE_PROF_MADRE) {
        this.CONDIZIONE_PROF_MADRE = CONDIZIONE_PROF_MADRE;
    }

    public StringProperty getTITOLO_DI_STUDIO_MADRE() {
        return TITOLO_DI_STUDIO_MADRE;
    }

    public void setTITOLO_DI_STUDIO_MADRE(StringProperty TITOLO_DI_STUDIO_MADRE) {
        this.TITOLO_DI_STUDIO_MADRE = TITOLO_DI_STUDIO_MADRE;
    }

    public StringProperty getCOD_PAT1_label() {
        return COD_PAT1_label;
    }

    public void setCOD_PAT1_label(StringProperty COD_PAT1_label) {
        this.COD_PAT1_label = COD_PAT1_label;
    }

    public StringProperty getPatol2_label() {
        return patol2_label;
    }

    public void setPatol2_label(StringProperty patol2_label) {
        this.patol2_label = patol2_label;
    }

    public StringProperty getPatol3_label() {
        return patol3_label;
    }

    public void setPatol3_label(StringProperty patol3_label) {
        this.patol3_label = patol3_label;
    }

    public StringProperty getPatol4_label() {
        return patol4_label;
    }

    public void setPatol4_label(StringProperty patol4_label) {
        this.patol4_label = patol4_label;
    }

    public StringProperty getPatol5_label() {
        return patol5_label;
    }

    public void setPatol5_label(StringProperty patol5_label) {
        this.patol5_label = patol5_label;
    }

    public StringProperty getPatol6_label() {
        return patol6_label;
    }

    public void setPatol6_label(StringProperty patol6_label) {
        this.patol6_label = patol6_label;
    }

    public StringProperty getInterv1_label() {
        return interv1_label;
    }

    public void setInterv1_label(StringProperty interv1_label) {
        this.interv1_label = interv1_label;
    }

    public StringProperty getInterv2_label() {
        return interv2_label;
    }

    public void setInterv2_label(StringProperty interv2_label) {
        this.interv2_label = interv2_label;
    }

    public StringProperty getInterv3_label() {
        return interv3_label;
    }

    public void setInterv3_label(StringProperty interv3_label) {
        this.interv3_label = interv3_label;
    }

    public StringProperty getInterv4_label() {
        return interv4_label;
    }

    public void setInterv4_label(StringProperty interv4_label) {
        this.interv4_label = interv4_label;
    }

    public StringProperty getInterv5_label() {
        return interv5_label;
    }

    public void setInterv5_label(StringProperty interv5_label) {
        this.interv5_label = interv5_label;
    }

    public StringProperty getInterv6_label() {
        return interv6_label;
    }

    public void setInterv6_label(StringProperty interv6_label) {
        this.interv6_label = interv6_label;
    }

    public StringProperty getInterv7_label() {
        return interv7_label;
    }

    public void setInterv7_label(StringProperty interv7_label) {
        this.interv7_label = interv7_label;
    }

    public StringProperty getInterv8_label() {
        return interv8_label;
    }

    public void setInterv8_label(StringProperty interv8_label) {
        this.interv8_label = interv8_label;
    }

    public StringProperty getInterv9_label() {
        return interv9_label;
    }

    public void setInterv9_label(StringProperty interv9_label) {
        this.interv9_label = interv9_label;
    }

    public StringProperty getInterv10_label() {
        return interv10_label;
    }

    public void setInterv10_label(StringProperty interv10_label) {
        this.interv10_label = interv10_label;
    }

    public StringProperty getInterv11_label() {
        return interv11_label;
    }

    public void setInterv11_label(StringProperty interv11_label) {
        this.interv11_label = interv11_label;
    }

    public StringProperty getCOD_PAT1_code_icd10() {
        return COD_PAT1_code_icd10;
    }

    public void setCOD_PAT1_code_icd10(StringProperty COD_PAT1_code_icd10) {
        this.COD_PAT1_code_icd10 = COD_PAT1_code_icd10;
    }

    public StringProperty getPatol2_code_icd10() {
        return patol2_code_icd10;
    }

    public void setPatol2_code_icd10(StringProperty patol2_code_icd10) {
        this.patol2_code_icd10 = patol2_code_icd10;
    }

    public StringProperty getPatol3_code_icd10() {
        return patol3_code_icd10;
    }

    public void setPatol3_code_icd10(StringProperty patol3_code_icd10) {
        this.patol3_code_icd10 = patol3_code_icd10;
    }

    public StringProperty getPatol4_code_icd10() {
        return patol4_code_icd10;
    }

    public void setPatol4_code_icd10(StringProperty patol4_code_icd10) {
        this.patol4_code_icd10 = patol4_code_icd10;
    }

    public StringProperty getPatol5_code_icd10() {
        return patol5_code_icd10;
    }

    public void setPatol5_code_icd10(StringProperty patol5_code_icd10) {
        this.patol5_code_icd10 = patol5_code_icd10;
    }

    public StringProperty getPatol6_code_icd10() {
        return patol6_code_icd10;
    }

    public void setPatol6_code_icd10(StringProperty patol6_code_icd10) {
        this.patol6_code_icd10 = patol6_code_icd10;
    }

    public StringProperty getCOD_PAT1_label_icd10() {
        return COD_PAT1_label_icd10;
    }

    public void setCOD_PAT1_label_icd10(StringProperty COD_PAT1_label_icd10) {
        this.COD_PAT1_label_icd10 = COD_PAT1_label_icd10;
    }

    public StringProperty getPatol2_label_icd10() {
        return patol2_label_icd10;
    }

    public void setPatol2_label_icd10(StringProperty patol2_label_icd10) {
        this.patol2_label_icd10 = patol2_label_icd10;
    }

    public StringProperty getPatol3_label_icd10() {
        return patol3_label_icd10;
    }

    public void setPatol3_label_icd10(StringProperty patol3_label_icd10) {
        this.patol3_label_icd10 = patol3_label_icd10;
    }


    public StringProperty getPatol4_label_icd10() {
        return patol4_label_icd10;
    }

    public void setPatol4_label_icd10(StringProperty patol4_label_icd10) {
        this.patol4_label_icd10 = patol4_label_icd10;
    }

    public StringProperty getPatol5_label_icd10() {
        return patol5_label_icd10;
    }

    public void setPatol5_label_icd10(StringProperty patol5_label_icd10) {
        this.patol5_label_icd10 = patol5_label_icd10;
    }

    public StringProperty getPatol6_label_icd10() {
        return patol6_label_icd10;
    }

    public void setPatol6_label_icd10(StringProperty patol6_label_icd10) {
        this.patol6_label_icd10 = patol6_label_icd10;
    }

    public StringProperty getAlreadyRecorded() {
        return alreadyRecorded;
    }

    public void setAlreadyRecorded(StringProperty alreadyRecorded) {
        this.alreadyRecorded = alreadyRecorded;
    }
    
    public StringProperty getNote() {
        return alreadyRecorded;
    }

    public void setNote(StringProperty note) {
        this.alreadyRecorded = note;
    }

//    public Sdo (int id, String nome, String cognome,
//                   String dataNascita, double peso, String classeBmi) {
//
//        this.id.set(id);
//        this.nome.set(nome);
//        this.cognome.set(cognome);
//        this.dataNascita.set(dataNascita);
//        this.peso.set(peso);
//        this.classeBmi.set(classeBmi);
//    }


   
    
//    @Override
//    public String toString() {
//        return getId() + " " + getNome() + " " + getCognome();
//    }

    @Override
    public String toString() {
        return super.toString(); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }
}
