package it.unife.cec.sdomanager.controller;

import it.unife.cec.sdomanager.App;
import it.unife.cec.sdomanager.dao.EdcDAO;
import it.unife.cec.sdomanager.dao.SdoDAO;
import it.unife.cec.sdomanager.database.DatabaseConnection;
import it.unife.cec.sdomanager.database.DbOperations;
import it.unife.cec.sdomanager.model.Edc;
import it.unife.cec.sdomanager.model.Sdo;
import it.unife.cec.sdomanager.service.CsvEdcService;
import it.unife.cec.sdomanager.service.CsvSdoService;
import java.io.File;
import java.io.IOException;
import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import javafx.application.Platform;
import javafx.beans.property.BooleanProperty;
import javafx.beans.property.DoubleProperty;
import javafx.beans.property.IntegerProperty;
import javafx.beans.property.Property;
import javafx.beans.property.SimpleBooleanProperty;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.StringProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.concurrent.Task;
import javafx.event.Event;
import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.CheckBox;
import javafx.scene.control.Label;
import javafx.scene.control.ProgressIndicator;
import javafx.scene.control.Tab;
import javafx.scene.control.TabPane;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;
import javafx.scene.input.MouseEvent;
import javafx.stage.FileChooser;
import javafx.stage.Stage;
import javafx.util.converter.NumberStringConverter;

public class MainAppController {
    
    // CLASS MEMEBERS
    
    private Integer numberOfRecords = 0;
    
    private boolean loading = false;
    
//    private EdcDAO edcDao = new EdcDAO();
//    private ObservableList<Edc> listaEdc = FXCollections.observableArrayList();
    
    private SdoDAO sdoDao = new SdoDAO();
    
    private ObservableList<Sdo> listaSdo = FXCollections.observableArrayList();
    
//    private static Edc edcLoaded;
    
    private static Sdo selectedSdo;
    
    public static BooleanProperty formDirty = new SimpleBooleanProperty(false);
    
    private Map<TextField, Object> bindings = new HashMap<>();
    
    private Map<String, String> originalValues = new HashMap<>();
    
    // CLASS FXML MEMBERS
    
    @FXML
    private Button saveButton;
    
    @FXML
    private Label nRecords;
    
    @FXML
    private Label lblStatus;
    
    @FXML
    private ProgressIndicator spinner;
    
//    EDC TABLE
//    @FXML private TableView<Edc> tableEdc;

//    // EDC FORM
//    @FXML public IntegerProperty id_edc = new SimpleIntegerProperty();
//    @FXML public StringProperty isValid_edc = new SimpleStringProperty();
//    @FXML private StringProperty record_id = new SimpleStringProperty();
//    @FXML private StringProperty redcap_data_access_group = new SimpleStringProperty();
//    @FXML private StringProperty birth_date = new SimpleStringProperty();
//    @FXML private StringProperty record_validation = new SimpleStringProperty();
//    @FXML private StringProperty centre = new SimpleStringProperty();
//    @FXML private StringProperty numloc = new SimpleStringProperty();
//    @FXML private StringProperty sdo_number = new SimpleStringProperty();
//    @FXML private StringProperty mother_name = new SimpleStringProperty();
//    @FXML private StringProperty mother_surname = new SimpleStringProperty();
//    @FXML private StringProperty gestlength = new SimpleStringProperty();
//    @FXML private StringProperty nbrbaby = new SimpleStringProperty();
//    @FXML private StringProperty sp_twin = new SimpleStringProperty();
//    @FXML private StringProperty nbrmalf = new SimpleStringProperty();
//    @FXML private StringProperty sex = new SimpleStringProperty();
//    @FXML private StringProperty type = new SimpleStringProperty();
//    @FXML private StringProperty newborn_name = new SimpleStringProperty();
//    @FXML private StringProperty newborn_surname = new SimpleStringProperty();
//    @FXML private StringProperty civreg = new SimpleStringProperty();
//    @FXML private StringProperty weight = new SimpleStringProperty();
//    @FXML private StringProperty survival = new SimpleStringProperty();
//    @FXML private StringProperty death_date = new SimpleStringProperty();
//    @FXML private StringProperty mocitizenship = new SimpleStringProperty();
//    @FXML private StringProperty resmo = new SimpleStringProperty();
//    @FXML private StringProperty extra_er_resmo = new SimpleStringProperty();
//    @FXML private StringProperty datemo = new SimpleStringProperty();
//    @FXML private StringProperty agemo = new SimpleStringProperty();
//    @FXML private StringProperty bmi = new SimpleStringProperty();
//    @FXML private StringProperty totpreg = new SimpleStringProperty();
//    @FXML private StringProperty whendisc = new SimpleStringProperty();
//    @FXML private StringProperty agedisc = new SimpleStringProperty();
//    @FXML private StringProperty condisc = new SimpleStringProperty();
//    @FXML private StringProperty firstpre = new SimpleStringProperty();
//    @FXML private StringProperty sp_firstpre = new SimpleStringProperty();
//    @FXML private StringProperty karyo = new SimpleStringProperty();
//    @FXML private StringProperty sp_cario = new SimpleStringProperty();
//    @FXML private StringProperty gentest = new SimpleStringProperty();
//    @FXML private StringProperty sp_gentest = new SimpleStringProperty();
//    @FXML private StringProperty surgery = new SimpleStringProperty();
//    @FXML private StringProperty pm = new SimpleStringProperty();
//    @FXML private StringProperty pm_notes = new SimpleStringProperty();
//    @FXML private StringProperty diagnosis_syndrome = new SimpleStringProperty();
//    @FXML private StringProperty presyn = new SimpleStringProperty();
//    @FXML private StringProperty diagnosis_malformation_1 = new SimpleStringProperty();
//    @FXML private StringProperty premal1 = new SimpleStringProperty();
//    @FXML private StringProperty diagnosis_malformation_2 = new SimpleStringProperty();
//    @FXML private StringProperty premal2 = new SimpleStringProperty();
//    @FXML private StringProperty diagnosis_malformation_3 = new SimpleStringProperty();
//    @FXML private StringProperty premal3 = new SimpleStringProperty();
//    @FXML private StringProperty diagnosis_malformation_4 = new SimpleStringProperty();
//    @FXML private StringProperty premal4 = new SimpleStringProperty();
//    @FXML private StringProperty diagnosis_malformation_5 = new SimpleStringProperty();
//    @FXML private StringProperty premal5 = new SimpleStringProperty();
//    @FXML private StringProperty diagnosis_malformation_6 = new SimpleStringProperty();
//    @FXML private StringProperty premal6 = new SimpleStringProperty();
//    @FXML private StringProperty diagnosis_malformation_7 = new SimpleStringProperty();
//    @FXML private StringProperty premal7 = new SimpleStringProperty();
//    @FXML private StringProperty diagnosis_malformation_8 = new SimpleStringProperty();
//    @FXML private StringProperty premal8 = new SimpleStringProperty();
//    @FXML private StringProperty valid_case = new SimpleStringProperty();
//    @FXML private StringProperty validation_notes = new SimpleStringProperty();
//    @FXML private StringProperty imer_key = new SimpleStringProperty();
//    @FXML private StringProperty syndrome = new SimpleStringProperty();
//    @FXML private StringProperty syndrome_desc_detail = new SimpleStringProperty();
//    @FXML private StringProperty sp_syndrome = new SimpleStringProperty();
//    @FXML private StringProperty omim = new SimpleStringProperty();
//    @FXML private StringProperty orpha = new SimpleStringProperty();
//    @FXML private StringProperty malfo1 = new SimpleStringProperty();
//    @FXML private StringProperty malf1_desc_detail = new SimpleStringProperty();
//    @FXML private StringProperty sp_malfo1 = new SimpleStringProperty();
//    @FXML private StringProperty malfo2 = new SimpleStringProperty();
//    @FXML private StringProperty malfo2_desc_detail = new SimpleStringProperty();
//    @FXML private StringProperty sp_malfo2 = new SimpleStringProperty();
//    @FXML private StringProperty malfo3 = new SimpleStringProperty();
//    @FXML private StringProperty malfo_3_desc_detail = new SimpleStringProperty();
//    @FXML private StringProperty sp_malfo3 = new SimpleStringProperty();
//    @FXML private StringProperty malfo4 = new SimpleStringProperty();
//    @FXML private StringProperty malfo4_desc_detail = new SimpleStringProperty();
//    @FXML private StringProperty sp_malfo4 = new SimpleStringProperty();
//    @FXML private StringProperty malfo5 = new SimpleStringProperty();
//    @FXML private StringProperty malfo5_desc_detail = new SimpleStringProperty();
//    @FXML private StringProperty sp_malfo5 = new SimpleStringProperty();
//    @FXML private StringProperty malfo6 = new SimpleStringProperty();
//    @FXML private StringProperty malfo6_desc_detail = new SimpleStringProperty();
//    @FXML private StringProperty sp_malfo6 = new SimpleStringProperty();
//    @FXML private StringProperty malfo7 = new SimpleStringProperty();
//    @FXML private StringProperty malfo7_desc_detail = new SimpleStringProperty();
//    @FXML private StringProperty sp_malfo7 = new SimpleStringProperty();
//    @FXML private StringProperty malfo8 = new SimpleStringProperty();
//    @FXML private StringProperty malf8_desc_detail = new SimpleStringProperty();
//    @FXML private StringProperty sp_malfo8 = new SimpleStringProperty();
//    @FXML private StringProperty notes = new SimpleStringProperty();
//    @FXML private StringProperty assconcept = new SimpleStringProperty();
//    @FXML private StringProperty agefa = new SimpleStringProperty();
//    @FXML private StringProperty socf = new SimpleStringProperty();
//    @FXML private StringProperty occupmo = new SimpleStringProperty();
//    @FXML private StringProperty matdiab = new SimpleStringProperty();
//    @FXML private StringProperty illbef1 = new SimpleStringProperty();
//    @FXML private StringProperty sp_illbef1 = new SimpleStringProperty();
//    @FXML private StringProperty icd9illbef1 = new SimpleStringProperty();
//    @FXML private StringProperty illbef2 = new SimpleStringProperty();
//    @FXML private StringProperty sp_illbef2 = new SimpleStringProperty();
//    @FXML private StringProperty icd9illbef2 = new SimpleStringProperty();
//    @FXML private StringProperty illdur1 = new SimpleStringProperty();
//    @FXML private StringProperty sp_illdur1 = new SimpleStringProperty();
//    @FXML private StringProperty icd9illdur1 = new SimpleStringProperty();
//    @FXML private StringProperty illdur2 = new SimpleStringProperty();
//    @FXML private StringProperty sp_illdur2 = new SimpleStringProperty();
//    @FXML private StringProperty icd9illdur2 = new SimpleStringProperty();
//    @FXML private StringProperty folic_g14 = new SimpleStringProperty();
//    @FXML private StringProperty extra_drugs = new SimpleStringProperty();
//    @FXML private StringProperty firsttri = new SimpleStringProperty();
//    @FXML private StringProperty drugs1 = new SimpleStringProperty();
//    @FXML private StringProperty sp_ifnotlisted_medication = new SimpleStringProperty();
//    @FXML private StringProperty sp_drugs = new SimpleStringProperty();
//    @FXML private StringProperty drugs2 = new SimpleStringProperty();
//    @FXML private StringProperty sp_ifnotlisted_medication_2 = new SimpleStringProperty();
//    @FXML private StringProperty sp_drugs_2 = new SimpleStringProperty();
//    @FXML private StringProperty drugs3 = new SimpleStringProperty();
//    @FXML private StringProperty sp_ifnotlisted_medication_3 = new SimpleStringProperty();
//    @FXML private StringProperty sp_drugs_3 = new SimpleStringProperty();
//    @FXML private StringProperty drugs4 = new SimpleStringProperty();
//    @FXML private StringProperty sp_ifnotlisted_medication_4 = new SimpleStringProperty();
//    @FXML private StringProperty sp_drugs_4 = new SimpleStringProperty();
//    @FXML private StringProperty drugs5 = new SimpleStringProperty();
//    @FXML private StringProperty sp_ifnotlisted_medication_5 = new SimpleStringProperty();
//    @FXML private StringProperty sp_drugs_5 = new SimpleStringProperty();
//    @FXML private StringProperty inf_cov_test = new SimpleStringProperty();
//    @FXML private StringProperty imm_cov_test = new SimpleStringProperty();
//    @FXML private StringProperty oth_cov_test = new SimpleStringProperty();
//    @FXML private StringProperty sp_oth_cov_test = new SimpleStringProperty();
//    @FXML private StringProperty start_cov = new SimpleStringProperty();
//    @FXML private StringProperty cov_severity = new SimpleStringProperty();
//    @FXML private StringProperty consang = new SimpleStringProperty();
//    @FXML private StringProperty sp_consang = new SimpleStringProperty();
//    @FXML private StringProperty sibanom = new SimpleStringProperty();
//    @FXML private StringProperty sp_sibanom = new SimpleStringProperty();
//    @FXML private StringProperty prevsib = new SimpleStringProperty();
//    @FXML private StringProperty sib1 = new SimpleStringProperty();
//    @FXML private StringProperty sib2 = new SimpleStringProperty();
//    @FXML private StringProperty sib3 = new SimpleStringProperty();
//    @FXML private StringProperty moanom = new SimpleStringProperty();
//    @FXML private StringProperty sp_moanom = new SimpleStringProperty();
//    @FXML private StringProperty faanom = new SimpleStringProperty();
//    @FXML private StringProperty sp_faanom = new SimpleStringProperty();
//    @FXML private StringProperty matedu = new SimpleStringProperty();
//    @FXML private StringProperty socm = new SimpleStringProperty();
//    @FXML private StringProperty migrant = new SimpleStringProperty();
//    @FXML private StringProperty genrem = new SimpleStringProperty();
//    @FXML private StringProperty imer_key_factor = new SimpleStringProperty();
//    @FXML private StringProperty syndrome_factor = new SimpleStringProperty();
//    @FXML private StringProperty malfo1_factor = new SimpleStringProperty();
//    @FXML private StringProperty malfo2_factor = new SimpleStringProperty();
//    @FXML private StringProperty malfo3_factor = new SimpleStringProperty();
//    @FXML private StringProperty malfo4_factor = new SimpleStringProperty();
//    @FXML private StringProperty malfo5_factor = new SimpleStringProperty();
//    @FXML private StringProperty malfo6_factor = new SimpleStringProperty();
//    @FXML private StringProperty malfo7_factor = new SimpleStringProperty();
//    @FXML private StringProperty malfo8_factor = new SimpleStringProperty();
//    @FXML private StringProperty illbef1_factor = new SimpleStringProperty();
//    @FXML private StringProperty illbef2_factor = new SimpleStringProperty();
//    @FXML private StringProperty illdur1_factor = new SimpleStringProperty();
//    @FXML private StringProperty illdur2_factor = new SimpleStringProperty();
//    @FXML private StringProperty cohort_edc = new SimpleStringProperty();
//    @FXML private StringProperty birthCenter = new SimpleStringProperty();
//    @FXML private StringProperty sdo_number_std = new SimpleStringProperty();
//    @FXML private StringProperty data_source = new SimpleStringProperty();
//    @FXML private StringProperty linkageKey = new SimpleStringProperty();
//    @FXML private StringProperty cedap_linked_edc = new SimpleStringProperty();

    // SDO TABLE
    @FXML private TableView<Sdo> tableSdo;

    // SDO FORM
    @FXML private TextField id_sdo;
    @FXML private TextField revCode;
    @FXML private TextField cedap_linked;
//    @FXML private TextField COD_RG;
//    @FXML private TextField COD_PRES;
//    @FXML private TextField AA_SDO;
//    @FXML private TextField PROG_SDO;
//    @FXML private TextField AA_DIM;
//    @FXML private TextField COD_AZI;
//    @FXML private TextField COM_RES;
    @FXML private TextField dt_amm;
    @FXML private TextField dt_dim;
//    @FXML private TextField COD_DISD;
//    @FXML private TextField DRG_RG;
//    @FXML private TextField TIPO_DRG;
//    @FXML private TextField ETA;
//    @FXML private TextField ETA_GG;
//    @FXML private TextField GG_DEG;
//    @FXML private TextField GG_DEGOP;
//    @FXML private TextField MOD_DIM;
//    @FXML private TextField MPR;
//    @FXML private TextField NEO_TRASF;
//    @FXML private TextField COD_PAT1;
//    @FXML private TextField FLAG_PAT;
@FXML private TextField PESO_GR;
//    @FXML private TextField PROV_RES;
//    @FXML private TextField REGIME_R;
//    @FXML private TextField RG_RES;
@FXML private TextField SEX;
//    @FXML private TextField SUB_COD;
//    @FXML private TextField PROG_PAZ;
@FXML private TextField patol2;
@FXML private TextField patol3;
@FXML private TextField patol4;
@FXML private TextField patol5;
@FXML private TextField patol6;
@FXML private TextField interv1;
@FXML private TextField interv2;
@FXML private TextField interv3;
@FXML private TextField interv4;
@FXML private TextField interv5;
@FXML private TextField interv6;
@FXML private TextField interv7;
@FXML private TextField interv8;
@FXML private TextField interv9;
@FXML private TextField interv10;
@FXML private TextField interv11;
//    @FXML private TextField ospedale;
@FXML private TextField dt_nasc;
@FXML private TextField dt_decesso;
//    @FXML private TextField cohort_sdo;
@FXML private TextField daysAfterDelivery;
@FXML private TextField validated;
@FXML private TextField validation_type;
@FXML private TextField eta_gestazionale;
//    @FXML private TextField CIRCONFERENZA_CRANICA;
//    @FXML private TextField CONCEPIMENTI_PRECEDENTI;
//    @FXML private TextField violazione_filtro;
//    @FXML private TextField malformazione_tipo;
//    @FXML private TextField score;
@FXML private TextField sds_cc;
//    @FXML private TextField COD_STAB;
//    @FXML private TextField SDO_MADRE;
//    @FXML private TextField SDO_NEO;
//    @FXML private TextField prog_paz_m;
//    @FXML private TextField nati_femmine;
//    @FXML private TextField nati_maschi;
//    @FXML private TextField riscontro_autoptico;
//    @FXML private TextField Genere_del_parto;
//    @FXML private TextField data_nascita_padre;
//    @FXML private TextField ALTRA_MALATTIA_DELLA_MADRE;
//    @FXML private TextField STATO_CIVILE_MADRE;
//    @FXML private TextField MALATTIA_PRINCIPALE_DELLA_MADRE;
//    @FXML private TextField metodi_PMA;
//    @FXML private TextField ECOGRAFIA_OLTRE22SETTIMANE;
//    @FXML private TextField FETOSCOPIA;
//    @FXML private TextField VILLOCENTESI;
//    @FXML private TextField AMNIOCENTESI;
//    @FXML private TextField TEST_COMBINATO;
//    @FXML private TextField CITTADINANZA_M;
@FXML private TextField VITALITA;
//    @FXML private TextField NUMERO_ECOGRAFIE;
//    @FXML private TextField CONSANGUINEITA;
@FXML private TextField dt_nas_m;
//    @FXML private TextField PESO_MADRE_AL_PARTO;
//    @FXML private TextField PESO_MADRE_PREGRAVIDICO;
//    @FXML private TextField ALTEZZA_MADRE;
//    @FXML private TextField ABITUDINE_AL_FUMO;
//    @FXML private TextField MALATTIE_INSORTE_IN_GRAVIDANZA_1;
//    @FXML private TextField MALATTIE_INSORTE_IN_GRAVIDANZA_2;
//    @FXML private TextField MALFORMAZIONI_MADRE;
//    @FXML private TextField MALFORMAZIONI_PADRE;
//    @FXML private TextField MALFORMAZIONI_GENITORI_MADRE;
//    @FXML private TextField MALFORMAZIONI_GENITORI_PADRE;
//    @FXML private TextField MALFORMAZIONI_PARENTI_MADRE;
//    @FXML private TextField MALFORMAZIONI_PARENTI_PADRE;
//    @FXML private TextField MALFORMAZIONI_FRATELLI_SORELLE;
//    @FXML private TextField ETA_GESTAZIONALE_ALLA_DIAGNOSI;
@FXML private TextField CARIOTIPO_DEL_NATO;
//    @FXML private TextField CONDIZIONE_PROF_PADRE;
//    @FXML private TextField TITOLO_DI_STUDIO_PADRE;
//    @FXML private TextField CONDIZIONE_PROF_MADRE;
//    @FXML private TextField TITOLO_DI_STUDIO_MADRE;
//    @FXML private TextField COD_PAT1_label;
@FXML private TextField patol2_label;
@FXML private TextField patol3_label;
@FXML private TextField patol4_label;
@FXML private TextField patol5_label;
@FXML private TextField patol6_label;
@FXML private TextField interv1_label;
@FXML private TextField interv2_label;
@FXML private TextField interv3_label;
@FXML private TextField interv4_label;
@FXML private TextField interv5_label;
@FXML private TextField interv6_label;
@FXML private TextField interv7_label;
@FXML private TextField interv8_label;
@FXML private TextField interv9_label;
@FXML private TextField interv10_label;
@FXML private TextField interv11_label;
@FXML private TextField COD_PAT1_code_icd10;
@FXML private TextField patol2_code_icd10;
@FXML private TextField patol3_code_icd10;
@FXML private TextField patol4_code_icd10;
@FXML private TextField patol5_code_icd10;
@FXML private TextField patol6_code_icd10;
@FXML private TextField COD_PAT1_label_icd10;
@FXML private TextField patol2_label_icd10;
@FXML private TextField patol3_label_icd10;
@FXML private TextField patol4_label_icd10;
@FXML private TextField patol5_label_icd10;
@FXML private TextField patol6_label_icd10;
@FXML private TextField alreadyRecorded;
@FXML private TextField note;


    
    // CLASS METHODS
    
//    public boolean isEdcFormDirty() {
//        
//        if (edcLoaded == null) return false;
//
//        Edc edcForm = getEdcFromForm();
//        return !edcLoaded.equals(edcForm);
//    }
    
    public boolean isSdoFormDirty() {
        return formDirty.get();
}
    
    public void checkDirty(Sdo sdo) {
        
       if(sdo == null){
           System.out.println("Check dirty SDO == null");
            formDirty.set(false);
            return;
       } 

        
        try {
            
            System.out.println("Check dirty SDO != null");

        Field[] fields = Sdo.class.getDeclaredFields();

        for (Field f : fields) {

            f.setAccessible(true);
            Object value = f.get(sdo);

            if (value instanceof StringProperty) {

                String current = ((StringProperty) value).get();
                String original = originalValues.get(f.getName());

                if (!Objects.equals(current, original)) {
                    System.out.println("Check dirty current != original");
                    formDirty.set(true);
                    
                } else {
                      
                }
            }
            formDirty.set(false); 
        }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    private void aggiornaStatoEdc() {
//        
//        if (loading)
//            return;
//        
//        formDirty.setValue(isEdcFormDirty());
//        
    }
    
    private void aggiornaStatoSdo() {
        
        if (loading)
            return;
        
        formDirty.setValue(isSdoFormDirty());
        
    }
    
    private void fillFormEdc(Edc edc){
//
//        if(edc==null) return;
//
//        idFieldEdc.setText(String.valueOf(edc.getId()));
//        nomeFieldEdc.setText(edc.getNome());
//        cognomeFieldEdc.setText(edc.getCognome());
//        dataFieldEdc.setText(edc.getDataNascita());
//        pesoFieldEdc.setText(String.valueOf(edc.getPeso()));
//        bmiFieldEdc.setText(edc.getClasseBmi());
    }
    
    public void unbindForm() {

        for (Map.Entry<TextField, Object> entry : bindings.entrySet()) {

            TextField tf = entry.getKey();
            Object prop = entry.getValue();

            if (prop instanceof StringProperty) {

                tf.textProperty().unbindBidirectional((StringProperty) prop);

            } else if (prop instanceof IntegerProperty) {

                tf.textProperty().unbindBidirectional((IntegerProperty) prop);

            }
        }

        bindings.clear();
}
    
    public void bindForm(Sdo sdo) {

    unbindForm();

    Field[] fields = this.getClass().getDeclaredFields();

    for (Field field : fields) {

        if (field.getType() == TextField.class) {

            try {

                field.setAccessible(true);
                TextField tf = (TextField) field.get(this);

                String name = field.getName();

                Field sdoField = Sdo.class.getDeclaredField(name);
                sdoField.setAccessible(true);

                Object value = sdoField.get(sdo);

                if (value instanceof StringProperty) {

                    StringProperty prop = (StringProperty) value;

                    tf.textProperty().bindBidirectional(prop);

                    bindings.put(tf, prop);
                }
                
                else if (value instanceof IntegerProperty) {

                        IntegerProperty prop = (IntegerProperty) value;

                        tf.textProperty().bindBidirectional(prop, new NumberStringConverter());

                        bindings.put(tf, prop); // solo per tracking

                }

            } catch (Exception ignored) {
            }
        }
    }
}
    
    private void fillFormSdo(Sdo sdo){

        if(sdo==null) return;

//            id_sdo.setText(sdo.id_sdo.getValue());
            
//        nomeFieldSdo.setText(sdo.getNome());
//        cognomeFieldSdo.setText(sdo.getCognome());
//        dataFieldSdo.setText(sdo.getDataNascita());
//        pesoFieldSdo.setText(String.valueOf(sdo.getPeso()));
//        bmiFieldSdo.setText(sdo.getClasseBmi());
    }
    
    private Edc getEdcFromForm() {
//
        Edc edc = new Edc();
//        edc.setNome(nomeFieldEdc.getText());
//        edc.setCognome(cognomeFieldEdc.getText());
//        edc.setDataNascita(dataFieldEdc.getText());
//        edc.setPeso(Double.parseDouble(pesoFieldEdc.getText()));
//        edc.setClasseBmi(bmiFieldEdc.getText());
//
        return edc;
    }
    
    private void getSdoFromForm(Sdo sdo) {

        Field[] fields = this.getClass().getDeclaredFields();

        for (Field field : fields) {

            if (field.getType() == TextField.class) {

                try {

                    field.setAccessible(true);
                    TextField tf = (TextField) field.get(this);

                    String name = field.getName();

                    Field sdoField = Sdo.class.getDeclaredField(name);
                    sdoField.setAccessible(true);

                    Object value = sdoField.get(sdo);

                    if (value instanceof StringProperty) {

                        ((StringProperty) value).set(tf.getText());

                    }

                } catch (Exception ignored) {
                }
            }
        }
    
    }
    
    public void loadAllEdc(){
//
//        try (Connection conn = DatabaseConnection.connect()) {
//
//        String sql = "SELECT * FROM edc";
//
//        ResultSet rs = conn.createStatement().executeQuery(sql);
//        ResultSetMetaData meta = rs.getMetaData();
//
//        int columnCount = meta.getColumnCount();
//
//        // pulisce colonne precedenti
//        tableEdc.getColumns().clear();
//
//        // crea colonne dinamiche
//        for (int i = 1; i <= columnCount; i++) {
//
//            final int colIndex = i - 1;
//            String columnName = meta.getColumnName(i);
//
//            TableColumn<Edc, String> column = new TableColumn<>(columnName);
//
//            column.setCellValueFactory(cellData -> {
//
//                try {
//
//                    Field field = Edc.class.getDeclaredField(columnName);
//                    field.setAccessible(true);
//
//                    Object value = field.get(cellData.getValue());
//
//                    if (value == null)
//                        return new SimpleStringProperty("");
//
//                    if (value instanceof StringProperty)
//                        return (StringProperty) value;
//                    
//                    if (value instanceof IntegerProperty)
//                        return new SimpleStringProperty(
//                            String.valueOf(((IntegerProperty) value).get())
//                        );
//                    
//                    if (value instanceof DoubleProperty)
//                        return new SimpleStringProperty(
//                            String.valueOf(((DoubleProperty) value).get())
//                        );    
//
//                return new SimpleStringProperty(value.toString());
//
//                } catch (Exception e) {
//
//                    return new SimpleStringProperty("");
//
//                }
//
//            });
//
//            column.setPrefWidth(140);
//
//            tableEdc.getColumns().add(column);
//        }
//
//        // dati
//        ObservableList<Edc> data = FXCollections.observableArrayList();
//
//        while (rs.next()) {
//            
//            Edc edc = new Edc();
//
//            for (int i = 1; i <= columnCount; i++) {
//                String columnName = meta.getColumnName(i);
//
//                try {
//
//                    Field field = Edc.class.getDeclaredField(columnName);
//                    field.setAccessible(true);
//
//                    Object fieldValue = field.get(edc);
//
//                    if (fieldValue instanceof StringProperty) {
//                        ((StringProperty) fieldValue).set(rs.getString(i));
//                    }
//                    
//                    if (fieldValue instanceof IntegerProperty) {
//                        ((IntegerProperty) fieldValue).set(rs.getInt(i));
//                    }
//
//                    if (fieldValue instanceof DoubleProperty) {
//                        ((DoubleProperty) fieldValue).set(rs.getDouble(i));
//                    }
//
//                } catch (Exception ignored) {
//                }
//            }
//
//            data.add(edc);
//            } 
//        tableEdc.setItems(data);
//        
//        } catch (Exception e) {
//        e.printStackTrace();
//        }
    }
    
    public void loadAllSdo(){

        try (Connection conn = DatabaseConnection.connect()) {

        String sql = "SELECT * FROM sdo";

        ResultSet rs = conn.createStatement().executeQuery(sql);
        ResultSetMetaData meta = rs.getMetaData();

        int columnCount = meta.getColumnCount();

        // pulisce colonne precedenti
        tableSdo.getColumns().clear();

        // crea colonne dinamiche
        for (int i = 1; i <= columnCount; i++) {

            final int colIndex = i - 1;
            String columnName = meta.getColumnName(i);

            TableColumn<Sdo, String> column = new TableColumn<>(columnName);

            column.setCellValueFactory(cellData -> {

                try {

                    Field field = Sdo.class.getDeclaredField(columnName);
                    field.setAccessible(true);

                    Object value = field.get(cellData.getValue());

                    if (value == null)
                        return new SimpleStringProperty("");

                    if (value instanceof StringProperty)
                        return (StringProperty) value;
                    
                    if (value instanceof IntegerProperty)
                        return new SimpleStringProperty(
                            String.valueOf(((IntegerProperty) value).get())
                        );
                    
                    if (value instanceof DoubleProperty)
                        return new SimpleStringProperty(
                            String.valueOf(((DoubleProperty) value).get())
                        );    

                return new SimpleStringProperty(value.toString());

                } catch (Exception e) {

                    return new SimpleStringProperty("");

                }

            });

            column.setPrefWidth(140);

            tableSdo.getColumns().add(column);
        }

        // dati
        ObservableList<Sdo> data = FXCollections.observableArrayList();

        while (rs.next()) {
            
            Sdo sdo = new Sdo();

            for (int i = 1; i <= columnCount; i++) {
                String columnName = meta.getColumnName(i);

                try {

                    Field field = Sdo.class.getDeclaredField(columnName);
                    field.setAccessible(true);

                    Object fieldValue = field.get(sdo);

                    if (fieldValue instanceof StringProperty) {
                        ((StringProperty) fieldValue).set(rs.getString(i));
                    }
                    
                    if (fieldValue instanceof IntegerProperty) {
                        ((IntegerProperty) fieldValue).set(rs.getInt(i));
                    }

                    if (fieldValue instanceof DoubleProperty) {
                        ((DoubleProperty) fieldValue).set(rs.getDouble(i));
                    }

                } catch (Exception ignored) {
                }
            }

            data.add(sdo);
            } 
        tableSdo.setItems(data);
        
        } catch (Exception e) {
        e.printStackTrace();
        }

    }
    
    public void captureOriginalState(Sdo sdo) {

        originalValues.clear();

        try {

            Field[] fields = Sdo.class.getDeclaredFields();

            for (Field f : fields) {

                f.setAccessible(true);
                Object value = f.get(sdo);

                if (value instanceof StringProperty) {

                    originalValues.put(
                            f.getName(),
                            ((StringProperty) value).get()
                    );
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        formDirty.set(false);
}
    
    public static void handleExitAction (Event event) {
        {
            if (formDirty.getValue() || formDirty.getValue()) {

                boolean conferma = DialogsPopUp.confirmPopUp("Conferma", "Verranno cancellati i dati non salvati."
                );
                if (!conferma){
                    event.consume();
                } else {
                    Platform.exit();  
                }
            } else {
                boolean conferma = DialogsPopUp.confirmPopUp("Conferma", "Uscire dall'applicazione?"
                );
                if (!conferma){
                    event.consume();
                } else {
                    Platform.exit();   
                }
            }
        }
    }
    
    
    // CLASS FXML METHODS
    
    @FXML
    public void initialize() {

        // SDO

        loadAllSdo();
        
        saveButton.disableProperty().bind(formDirty.not());
        
        tableSdo.getSelectionModel().selectedItemProperty().addListener(
                (obs,oldSel,newSel)-> {
                    if (newSel != null) {
                        loading = true;
                        bindForm(newSel);
                        //formDirty.setValue(false);
                        loading = false;
                        selectedSdo = newSel;
                        captureOriginalState(newSel);
                        System.out.println("TableSdo original values");
                        System.out.print(originalValues);
                    }        
                }
            );
        
        // LISTENER PER MODIFICA CAMPI SDO
         revCode.textProperty().addListener((obs, oldVal, newVal) -> {
            System.out.println("revcode event listener");
            formDirty.set(true);
            //checkDirty(selectedSdo);
         });
         COD_PAT1_code_icd10.textProperty().addListener((obs, oldVal, newVal) -> {
             System.out.println("revcode event listener");
             formDirty.set(true);
             //checkDirty(selectedSdo);
         });
         patol2_code_icd10.textProperty().addListener((obs, oldVal, newVal) -> {
             System.out.println("revcode event listener");
             formDirty.set(true);
             //checkDirty(selectedSdo);
         });
         patol3_code_icd10.textProperty().addListener((obs, oldVal, newVal) -> {
             System.out.println("revcode event listener");
             formDirty.set(true);
             //checkDirty(selectedSdo);
         });
         patol4_code_icd10.textProperty().addListener((obs, oldVal, newVal) -> {
             System.out.println("revcode event listener");
             formDirty.set(true);
             //checkDirty(selectedSdo);
         });
         patol5_code_icd10.textProperty().addListener((obs, oldVal, newVal) -> {
             System.out.println("revcode event listener");
             formDirty.set(true);
             //checkDirty(selectedSdo);
         });
         patol6_code_icd10.textProperty().addListener((obs, oldVal, newVal) -> {
             System.out.println("revcode event listener");
             formDirty.set(true);
             //checkDirty(selectedSdo);
         });
         COD_PAT1_label_icd10.textProperty().addListener((obs, oldVal, newVal) -> {
             System.out.println("revcode event listener");
             formDirty.set(true);
             //checkDirty(selectedSdo);
         });
         patol2_label_icd10.textProperty().addListener((obs, oldVal, newVal) -> {
             System.out.println("revcode event listener");
             formDirty.set(true);
             //checkDirty(selectedSdo);
         });
         patol3_label_icd10.textProperty().addListener((obs, oldVal, newVal) -> {
             System.out.println("revcode event listener");
             formDirty.set(true);
             //checkDirty(selectedSdo);
         });
         patol4_label_icd10.textProperty().addListener((obs, oldVal, newVal) -> {
             System.out.println("revcode event listener");
             formDirty.set(true);
             //checkDirty(selectedSdo);
         });
         patol5_label_icd10.textProperty().addListener((obs, oldVal, newVal) -> {
             System.out.println("revcode event listener");
             formDirty.set(true);
             //checkDirty(selectedSdo);
         });
         patol6_label_icd10.textProperty().addListener((obs, oldVal, newVal) -> {
             System.out.println("revcode event listener");
             formDirty.set(true);
             //checkDirty(selectedSdo);
         });
         note.textProperty().addListener((obs, oldVal, newVal) -> {
             System.out.println("revcode event listener");
             formDirty.set(true);
             //checkDirty(selectedSdo);
         });

    
        // PREVIENE PERDITA DATI TRA TABS
        
//        tabPane.skinProperty().addListener((obs, oldSkin, newSkin) -> {
//            if (newSkin != null) {
//                tabPane.lookupAll(".tab").forEach(node -> {
//                    node.addEventFilter(MouseEvent.MOUSE_PRESSED, event -> {
//                        if (formDirty.getValue()) {
//                            boolean conferma = DialogsPopUp.warnPopUp("Conferma", "Verranno cancellati i dati non salvati."
//                            );
//                            if (conferma) {
//                            event.consume(); // blocca il cambio tab
//                            }
//                        }
//                    });
//                });
//            }   
//
//        });
        
        // PREVIENE PERDITA DATI SU CAMBIO RECORD DA TABELLA SDO
        
        tableSdo.addEventFilter(MouseEvent.MOUSE_PRESSED, event -> {
            System.out.println("Table SDO mouse event pressed");
            System.out.println("Form dirty: " + isSdoFormDirty());
            if (isSdoFormDirty()) {
                boolean conferma = DialogsPopUp.warnPopUp("Attenzione", "Salvare i dati prima di cambiare caso."
                            );
                if (conferma) {
                    event.consume(); // blocca il cambio selezione
                }
            }

        });
        
    }
   
    @FXML
    public void updateSdo(){
        
        spinner.setVisible(true);
        lblStatus.setText("Saving data..");
        
        Sdo selectedItem = tableSdo.getSelectionModel().getSelectedItem();
        
        if (selectedItem == null) {
            System.out.println("Nessuna riga selezionata");
            spinner.setVisible(false);
            lblStatus.setText("SDO Manager 1.0");
            return;
        }
        
        getSdoFromForm(selectedSdo);

        Task<Void> task = new Task<>() {
                    @Override
                    protected Void call() throws Exception {
                        try {
                                sdoDao.update(selectedItem);
                        } catch (Exception e) {

                            e.printStackTrace();
                          }    
                        return null;
                        }
            };
        
        task.setOnSucceeded(e -> {
                    System.out.println("Update completato");
                    spinner.setVisible(false);
                    lblStatus.setText("SDO Manager 1.0");
                    loadAllSdo();
                    formDirty.set(false);
                    saveButton.setDisable(true);
                });
        
        task.setOnFailed(e -> {
                spinner.setVisible(false);
                lblStatus.setText("SDO Manager 1.0");
                });

        new Thread(task).start();
    }
    
    @FXML
    public void updateEdc(){
//
//        try{
//
//            Edc edc = new Edc(
//                    Integer.parseInt(idFieldEdc.getText()),
//                    nomeFieldEdc.getText(),
//                    cognomeFieldEdc.getText(),
//                    dataFieldEdc.getText(),
//                    Double.parseDouble(pesoFieldEdc.getText()),
//                    bmiFieldEdc.getText()
//            );
//
//            edcDao.update(edc);
//            loadAllEdc();
//            formDirty.set(false);
//
//        }catch(Exception e){
//            e.printStackTrace();
//        }
    }

    @FXML
    public void switchToSecondary() throws IOException {
//        App.setRoot("secondary");
    }
    
    @FXML
    private void importEdcCsv() throws IOException {
//        
//        if (DialogsPopUp.confirmPopUp("Conferma", "Verranno cancellati i dati presenti.")) {
//            
//            Connection conn = DbOperations.getDbConnection();
//            DbOperations.clearEdcTable(conn);
//
//            FileChooser fileChooser = new FileChooser();
//            fileChooser.setTitle("Apri file CSV");
//
//            fileChooser.getExtensionFilters().add(
//                    new FileChooser.ExtensionFilter("File CSV", "*.csv")
//            );
//
//            File file = fileChooser.showOpenDialog(new Stage());
//
//            if (file != null) {
//                System.out.println("File selezionato: " + file.getAbsolutePath());
//
//                try {
//
//                    numberOfRecords = CsvEdcService.importCsv(file);
//                    loadAllEdc();
//                    Alert alert = new Alert(Alert.AlertType.INFORMATION);
//                    alert.setTitle("Import complete");
//                    alert.setHeaderText("EDC record importati: " + numberOfRecords);
//                    alert.showAndWait();
//                    
//                } catch (Exception e) {
//                    e.printStackTrace();
//                }
//            }
//        }
}
    
    @FXML
    private void importSdoCsv() throws IOException {
        
        if (DialogsPopUp.confirmPopUp("Conferma", "Verranno cancellati i dati presenti.")) {
            
            Connection conn = DbOperations.getDbConnection();
            DbOperations.clearSdoTable(conn);

            FileChooser fileChooser = new FileChooser();
            fileChooser.setTitle("Apri file CSV");

            fileChooser.getExtensionFilters().add(
                    new FileChooser.ExtensionFilter("File CSV", "*.csv")
            );

            File file = fileChooser.showOpenDialog(new Stage());

            if (file != null) {
                
                spinner.setVisible(true);
                lblStatus.setText("Loading data..");
                
                System.out.println("File selezionato: " + file.getAbsolutePath());

                // 2. Crea un compito in background
                Task<Void> task = new Task<>() {
                    @Override
                    protected Void call() throws Exception {
                        try {

                            numberOfRecords = CsvSdoService.importCsv(file);
                        
                        } catch (Exception e) {

                            e.printStackTrace();
                            
                        }    
                            return null;
                    }
                };
                
                task.setOnSucceeded(e -> {
                    System.out.println("Importazione completata!");
                    spinner.setVisible(false);
                    lblStatus.setText("SDO Manager 1.0");
                    loadAllSdo();
                    Alert alert = new Alert(Alert.AlertType.INFORMATION);
                            alert.setTitle("Import complete");
                            alert.setHeaderText("SDO record importati: " + numberOfRecords);
                            alert.showAndWait();
                });

                task.setOnFailed(e -> {
                    spinner.setVisible(false);
                    lblStatus.setText("SDO Manager 1.0");
                });

                // 4. Avvia il thread
                new Thread(task).start();
            }
        }
    }
    
    @FXML
    private void exportSdoCsv() throws IOException {
        
        System.out.println("export clicked");

        FileChooser fileChooser = new FileChooser();
        fileChooser.setTitle("Salva file CSV");

        fileChooser.getExtensionFilters().add(
                new FileChooser.ExtensionFilter("File CSV", "*.csv")
        );

        fileChooser.setInitialFileName("sdo_export.csv");

        File file = fileChooser.showSaveDialog(new Stage());

        if (file != null) {

            try {
                CsvSdoService.exportCsv(file.toString());
                System.out.println("File salvato: " + file.getAbsolutePath());
                Alert alert = new Alert(Alert.AlertType.INFORMATION);
                alert.setTitle("Info");
                alert.setHeaderText("SDO export");
                alert.setContentText("File salvato correttamente.");
                alert.showAndWait();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
}
    
    @FXML
    private void exportEdcCsv() throws IOException {
//        
//        System.out.println("export clicked");
//
//        FileChooser fileChooser = new FileChooser();
//        fileChooser.setTitle("Salva file CSV");
//
//        fileChooser.getExtensionFilters().add(
//                new FileChooser.ExtensionFilter("File CSV", "*.csv")
//        );
//
//        fileChooser.setInitialFileName("edc_export.csv");
//
//        File file = fileChooser.showSaveDialog(new Stage());
//
//        if (file != null) {
//
//            try {
//                CsvEdcService.exportCsv(file.toString());
//                System.out.println("File salvato: " + file.getAbsolutePath());
//                Alert alert = new Alert(Alert.AlertType.INFORMATION);
//                alert.setTitle("Info");
//                alert.setHeaderText("EDC export");
//                alert.setContentText("File salvato correttamente.");
//                alert.showAndWait();
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//        }
}
   
    @FXML
    private void handleExit(Event event){
        handleExitAction(event);
        
    }
//end class
}
