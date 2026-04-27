/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package it.unife.cec.sdomanager.database;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;

/**
 *
 * @author utente
 */
public class DbOperations {
    
    public static Connection getDbConnection () {
        Connection conn = null;
        
        try{
            conn = DatabaseConnection.connect();    
        } catch(Exception e) {
            System.err.println( e.getClass().getName() + ": " + e.getMessage() );
        }
        System.out.println("Opened database successfully");
        return(conn);
    }
    
    public static void createSdoTable(Connection conn) throws IOException {
        
    String sql = "CREATE TABLE IF NOT EXISTS sdo ("
                + "id_sdo INTEGER PRIMARY KEY AUTOINCREMENT,"
                + "revCode TEXT DEFAULT 9,"
                + "cedap_linked TEXT,"
                + "COD_RG TEXT,"
                + "COD_PRES TEXT,"
                + "AA_SDO TEXT,"
                + "PROG_SDO TEXT,"
                + "AA_DIM TEXT,"
                + "COD_AZI TEXT,"
                + "COM_RES TEXT,"
                + "dt_amm TEXT,"
                + "dt_dim TEXT,"
                + "COD_DISD TEXT,"
                + "DRG_RG TEXT,"
                + " TIPO_DRG TEXT,"
                + "ETA TEXT,"
                + "ETA_GG TEXT,"
                + "GG_DEG TEXT,"
                + "GG_DEGOP TEXT,"
                + "MOD_DIM TEXT,"
                + "MPR TEXT,"
                + "NEO_TRASF TEXT,"
                + "COD_PAT1 TEXT,"
                + "FLAG_PAT TEXT,"
                + "PESO_GR TEXT,"
                + "PROV_RES TEXT,"
                + "REGIME_R TEXT,"
                + "RG_RES TEXT,"
                + "SEX TEXT,"
                + "SUB_COD TEXT,"
                + "PROG_PAZ TEXT,"
                + "patol2 TEXT,"
                + "patol3 TEXT,"
                + "patol4 TEXT,"
                + "patol5 TEXT,"
                + "patol6 TEXT,"
                + "interv1 TEXT,"
                + "interv2 TEXT,"
                + "interv3 TEXT,"
                + "interv4 TEXT,"
                + "interv5 TEXT,"
                + "interv6 TEXT,"
                + "interv7 TEXT,"
                + "interv8 TEXT,"
                + "interv9 TEXT,"
                + "interv10 TEXT,"
                + "interv11 TEXT,"
                + "ospedale TEXT,"
                + "dt_nasc TEXT,"
                + "dt_decesso TEXT,"
                + "cohort TEXT,"
                + "daysAfterDelivery TEXT,"
                + "validated TEXT,"
                + "validation_type TEXT,"
                + "eta_gestazionale TEXT,"
                + "CIRCONFERENZA_CRANICA TEXT,"
                + "CONCEPIMENTI_PRECEDENTI TEXT,"
                + "violazione_filtro TEXT,"
                + "malformazione_tipo TEXT,"
                + "score TEXT,"
                + "sds_cc TEXT,"
                + "COD_STAB TEXT,"
                + "SDO_MADRE TEXT,"
                + "SDO_NEO TEXT,"
                + "prog_paz_m TEXT,"
                + "nati_femmine TEXT,"
                + "nati_maschi TEXT,"
                + "riscontro_autoptico TEXT,"
                + "Genere_del_parto TEXT,"
                + "data_nascita_padre TEXT,"
                + "ALTRA_MALATTIA_DELLA_MADRE TEXT,"
                + "STATO_CIVILE_MADRE TEXT,"
                + "MALATTIA_PRINCIPALE_DELLA_MADRE TEXT,"
                + "metodi_PMA TEXT,"
                + "ECOGRAFIA_OLTRE22SETTIMANE TEXT,"
                + "FETOSCOPIA TEXT,"
                + "VILLOCENTESI TEXT,"
                + "AMNIOCENTESI TEXT,"
                + "TEST_COMBINATO TEXT,"
                + "CITTADINANZA_M TEXT,"
                + "VITALITA TEXT,"
                + "NUMERO_ECOGRAFIE TEXT,"
                + "CONSANGUINEITA TEXT,"
                + "dt_nas_m TEXT,"
                + "PESO_MADRE_AL_PARTO TEXT,"
                + "PESO_MADRE_PREGRAVIDICO TEXT,"
                + "ALTEZZA_MADRE TEXT,"
                + "ABITUDINE_AL_FUMO TEXT,"
                + "MALATTIE_INSORTE_IN_GRAVIDANZA_1 TEXT,"
                + "MALATTIE_INSORTE_IN_GRAVIDANZA_2 TEXT,"
                + "MALFORMAZIONI_MADRE TEXT,"
                + "MALFORMAZIONI_PADRE TEXT,"
                + "MALFORMAZIONI_GENITORI_MADRE TEXT,"
                + "MALFORMAZIONI_GENITORI_PADRE TEXT,"
                + "MALFORMAZIONI_PARENTI_MADRE TEXT,"
                + "MALFORMAZIONI_PARENTI_PADRE TEXT,"
                + "MALFORMAZIONI_FRATELLI_SORELLE TEXT,"
                + "ETA_GESTAZIONALE_ALLA_DIAGNOSI TEXT,"
                + "CARIOTIPO_DEL_NATO TEXT,"
                + "CONDIZIONE_PROF_PADRE TEXT,"
                + "TITOLO_DI_STUDIO_PADRE TEXT,"
                + "CONDIZIONE_PROF_MADRE TEXT,"
                + "TITOLO_DI_STUDIO_MADRE TEXT,"
                + "COD_PAT1_label TEXT,"
                + "patol2_label TEXT,"
                + "patol3_label TEXT,"
                + "patol4_label TEXT,"
                + "patol5_label TEXT,"
                + "patol6_label TEXT,"
                + "interv1_label TEXT,"
                + "interv2_label TEXT,"
                + "interv3_label TEXT,"
                + "interv4_label TEXT,"
                + "interv5_label TEXT,"
                + "interv6_label TEXT,"
                + "interv7_label TEXT,"
                + "interv8_label TEXT,"
                + "interv9_label TEXT,"
                + "interv10_label TEXT,"
                + "interv11_label TEXT,"
                + "COD_PAT1_code_icd10 TEXT,"
                + "patol2_code_icd10 TEXT,"
                + "patol3_code_icd10 TEXT,"
                + "patol4_code_icd10 TEXT,"
                + "patol5_code_icd10 TEXT,"
                + "patol6_code_icd10 TEXT,"
                + "COD_PAT1_label_icd10 TEXT,"
                + "patol2_label_icd10 TEXT,"
                + "patol3_label_icd10 TEXT,"
                + "patol4_label_icd10 TEXT,"
                + "patol5_label_icd10 TEXT,"
                + "patol6_label_icd10 TEXT,"
                + "alreadyRecorded TEXT,"
                + "note TEXT"
            +")";

        try (
             Statement stmt = conn.createStatement()) {
            stmt.execute(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("SDO Table created!");    
    }
    
    public static void createEdcTable(Connection conn) throws IOException {
    
        String sql = "CREATE TABLE IF NOT EXISTS edc ("
        + "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        + "isValid TEXT DEFAULT 'Yes',"
        + "record_id TEXT,"
        + "redcap_data_access_group TEXT,"
        + "birth_date TEXT,"
        + "record_validation TEXT,"
        + "centre TEXT,"
        + "numloc TEXT,"
        + "sdo_number TEXT,"
        + "mother_name TEXT,"
        + "mother_surname TEXT,"
        + "gestlength TEXT,"
        + "nbrbaby TEXT,"
        + "sp_twin TEXT,"
        + "nbrmalf TEXT,"
        + "sex TEXT,"
        + "type TEXT,"
        + "newborn_name TEXT,"
        + "newborn_surname TEXT,"
        + "civreg TEXT,"
        + "weight TEXT,"
        + "survival TEXT,"
        + "death_date TEXT,"
        + "mocitizenship TEXT,"
        + "resmo TEXT,"
        + "extra_er_resmo TEXT,"
        + "datemo TEXT,"
        + "agemo TEXT,"
        + "bmi TEXT,"
        + "totpreg TEXT,"
        + "whendisc TEXT,"
        + "agedisc TEXT,"
        + "condisc TEXT,"
        + "firstpre TEXT,"
        + "sp_firstpre TEXT,"
        + "karyo TEXT,"
        + "sp_cario TEXT,"
        + "gentest TEXT,"
        + "sp_gentest TEXT,"
        + "surgery TEXT,"
        + "pm TEXT,"
        + "pm_notes TEXT,"
        + "diagnosis_syndrome TEXT,"
        + "presyn TEXT,"
        + "diagnosis_malformation_1 TEXT,"
        + "premal1 TEXT,"
        + "diagnosis_malformation_2 TEXT,"
        + "premal2 TEXT,"
        + "diagnosis_malformation_3 TEXT,"
        + "premal3 TEXT,"
        + "diagnosis_malformation_4 TEXT,"
        + "premal4 TEXT,"
        + "diagnosis_malformation_5 TEXT,"
        + "premal5 TEXT,"
        + "diagnosis_malformation_6 TEXT,"
        + "premal6 TEXT,"
        + "diagnosis_malformation_7 TEXT,"
        + "premal7 TEXT,"
        + "diagnosis_malformation_8 TEXT,"
        + "premal8 TEXT,"
        + "valid_case TEXT,"
        + "validation_notes TEXT,"
        + "imer_key TEXT,"
        + "syndrome TEXT,"
        + "syndrome_desc_detail TEXT,"
        + "sp_syndrome TEXT,"
        + "omim TEXT,"
        + "orpha TEXT,"
        + "malfo1 TEXT,"
        + "malf1_desc_detail TEXT,"
        + "sp_malfo1 TEXT,"
        + "malfo2 TEXT,"
        + "malfo2_desc_detail TEXT,"
        + "sp_malfo2 TEXT,"
        + "malfo3 TEXT,"
        + "malfo_3_desc_detail TEXT,"
        + "sp_malfo3 TEXT,"
        + "malfo4 TEXT,"
        + "malfo4_desc_detail TEXT,"
        + "sp_malfo4 TEXT,"
        + "malfo5 TEXT,"
        + "malfo5_desc_detail TEXT,"
        + "sp_malfo5 TEXT,"
        + "malfo6 TEXT,"
        + "malfo6_desc_detail TEXT,"
        + "sp_malfo6 TEXT,"
        + "malfo7 TEXT,"
        + "malfo7_desc_detail TEXT,"
        + "sp_malfo7 TEXT,"
        + "malfo8 TEXT,"
        + "malf8_desc_detail TEXT,"
        + "sp_malfo8 TEXT,"
        + "notes TEXT,"
        + "assconcept TEXT,"
        + "agefa TEXT,"
        + "socf TEXT,"
        + "occupmo TEXT,"
        + "matdiab TEXT,"
        + "illbef1 TEXT,"
        + "sp_illbef1 TEXT,"
        + "icd9illbef1 TEXT,"
        + "illbef2 TEXT,"
        + "sp_illbef2 TEXT,"
        + "icd9illbef2 TEXT,"
        + "illdur1 TEXT,"
        + "sp_illdur1 TEXT,"
        + "icd9illdur1 TEXT,"
        + "illdur2 TEXT,"
        + "sp_illdur2 TEXT,"
        + "icd9illdur2 TEXT,"
        + "folic_g14 TEXT,"
        + "extra_drugs TEXT,"
        + "firsttri TEXT,"
        + "drugs1 TEXT,"
        + "sp_ifnotlisted_medication TEXT,"
        + "sp_drugs TEXT,"
        + "drugs2 TEXT,"
        + "sp_ifnotlisted_medication_2 TEXT,"
        + "sp_drugs_2 TEXT,"
        + "drugs3 TEXT,"
        + "sp_ifnotlisted_medication_3 TEXT,"
        + "sp_drugs_3 TEXT,"
        + "drugs4 TEXT,"
        + "sp_ifnotlisted_medication_4 TEXT,"
        + "sp_drugs_4 TEXT,"
        + "drugs5 TEXT,"
        + "sp_ifnotlisted_medication_5 TEXT,"
        + "sp_drugs_5 TEXT,"
        + "inf_cov_test TEXT,"
        + "imm_cov_test TEXT,"
        + "oth_cov_test TEXT,"
        + "sp_oth_cov_test TEXT,"
        + "start_cov TEXT,"
        + "cov_severity TEXT,"
        + "consang TEXT,"
        + "sp_consang TEXT,"
        + "sibanom TEXT,"
        + "sp_sibanom TEXT,"
        + "prevsib TEXT,"
        + "sib1 TEXT,"
        + "sib2 TEXT,"
        + "sib3 TEXT,"
        + "moanom TEXT,"
        + "sp_moanom TEXT,"
        + "faanom TEXT,"
        + "sp_faanom TEXT,"
        + "matedu TEXT,"
        + "socm TEXT,"
        + "migrant TEXT,"
        + "genrem TEXT,"
        + "imer_key_factor TEXT,"
        + "syndrome_factor TEXT,"
        + "malfo1_factor TEXT,"
        + "malfo2_factor TEXT,"
        + "malfo3_factor TEXT,"
        + "malfo4_factor TEXT,"
        + "malfo5_factor TEXT,"
        + "malfo6_factor TEXT,"
        + "malfo7_factor TEXT,"
        + "malfo8_factor TEXT,"
        + "illbef1_factor TEXT,"
        + "illbef2_factor TEXT,"
        + "illdur1_factor TEXT,"
        + "illdur2_factor TEXT,"
        + "cohort TEXT,"
        + "birthCenter TEXT,"
        + "sdo_number_std TEXT,"
        + "data_source TEXT,"
        + "linkageKey TEXT,"
        + "cedap_linked TEXT"
        + ");";

        try (
             Statement stmt = conn.createStatement()) {
            stmt.execute(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("EDC Table created!");     
    }
    
    public static void clearEdcTable(Connection conn) throws IOException {
        
        String sql = "DELETE FROM edc";

        try (
             Statement stmt = conn.createStatement()) {
            stmt.execute(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("EDC Table created!");     
    }
    
    public static void deleteEdcTable(Connection conn) throws IOException {
        
        String sql = "DROP TABLE edc";

        try (
             Statement stmt = conn.createStatement()) {
            stmt.execute(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("EDC Table created!");     
    }
    
    public static void deleteSdoTable(Connection conn) throws IOException {
        
        String sql = "DROP TABLE sdo";

        try (
             Statement stmt = conn.createStatement()) {
            stmt.execute(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("EDC Table created!");     
    }
    
    public static void clearSdoTable(Connection conn) throws IOException {
        
        String sql = "DELETE FROM sdo";

        try (
             Statement stmt = conn.createStatement()) {
            stmt.execute(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("EDC Table created!");     
    }
    
    public static void initDatabase(Connection conn) throws IOException {
        createEdcTable(conn);
        createSdoTable(conn);
    }
    
    public static void clearTables(Connection conn) throws IOException {
        clearEdcTable(conn);
        clearSdoTable(conn);
    }
}
