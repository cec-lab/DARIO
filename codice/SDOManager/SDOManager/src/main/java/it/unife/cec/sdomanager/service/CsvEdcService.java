/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package it.unife.cec.sdomanager.service;

import com.opencsv.CSVParserBuilder;
import it.unife.cec.sdomanager.dao.EdcDAO;
import it.unife.cec.sdomanager.model.Edc;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.List;
import com.opencsv.CSVReader;
import com.opencsv.CSVReaderBuilder;
import com.opencsv.CSVWriter;
import com.opencsv.CSVWriterBuilder;
import com.opencsv.ICSVWriter;
import it.unife.cec.sdomanager.dao.SdoDAO;
import it.unife.cec.sdomanager.database.DatabaseConnection;
import it.unife.cec.sdomanager.database.DbOperations;
import it.unife.cec.sdomanager.model.Sdo;
import java.io.FileNotFoundException;
import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javafx.beans.property.DoubleProperty;
import javafx.beans.property.IntegerProperty;
import javafx.beans.property.StringProperty;
import javafx.scene.control.Alert;

/**
 *
 * @author utente
 */
public class CsvEdcService {

    //private static EdcDAO edcDao = new EdcDAO();
    
    private static Integer numberOfRecords = 0;
    
    public static Integer importCsv(File file) throws Exception {
        try (CSVReader reader = new CSVReaderBuilder(new FileReader(file))
                .withCSVParser(new CSVParserBuilder()
                .withSeparator(';')
                .build())
                .withSkipLines(0) // salta header
                .build();
                )
        {
            
            String[] header = reader.readNext();
            
            StringBuilder sql = new StringBuilder();
            sql.append("INSERT INTO edc (");

            for (int i = 0; i < header.length; i++) {
                sql.append(header[i]);
                if (i < header.length - 1) sql.append(",");
            }

            sql.append(") VALUES (");

            for (int i = 0; i < header.length; i++) {
                sql.append("?");
                if (i < header.length - 1) sql.append(",");
            }

            sql.append(")");
            
            System.out.println(sql.toString());
            
            try (Connection conn = DatabaseConnection.connect();
                    
                PreparedStatement ps = conn.prepareStatement(sql.toString())){
                
                DbOperations.deleteEdcTable(conn);
                DbOperations.createEdcTable(conn);
            
                String[] row;

                int nrows = 0;
                while ((row = reader.readNext()) != null) {

                    for (int i = 0; i < row.length; i++) {
                        ps.setString(i + 1, row[i]);
                    }

                    ps.executeUpdate();
                
                    nrows++;
                }
            
                numberOfRecords = nrows;
            } catch (Exception e) {
                Alert alert = new Alert(Alert.AlertType.ERROR);
                alert.setTitle("Errore");
                alert.setHeaderText("EDC import: operazione non riuscita");
                alert.setContentText(e.getClass().getName() + ": " + e.getMessage());
                alert.showAndWait();
                System.err.println( e.getClass().getName() + ": " + e.getMessage() );
                numberOfRecords = 0;
            } 
        } catch (Exception e) {
                System.err.println( e.getClass().getName() + ": " + e.getMessage() );
                numberOfRecords = 0;
        }
        return numberOfRecords;
    }

    public static void exportCsv(String file) throws Exception {
        try (ICSVWriter writer = new CSVWriterBuilder(new FileWriter(file))
                .withSeparator(';')
                .build();
                )
            {
       
            // HEADER
                
            Field[] fields = Edc.class.getDeclaredFields();
            String[] header = new String[fields.length];

            for (int i = 0; i < fields.length; i++) {
                header[i] = fields[i].getName();
            }

            writer.writeNext(header);
                
            // 2. Scrittura Dati
            for (Edc edc : EdcDAO.findAll()) {
                String[] row = new String[fields.length];
                for (int i = 0; i < fields.length; i++) {
                    fields[i].setAccessible(true);

                Object value = fields[i].get(edc);

                if (value == null) {

                    row[i] = "";

                } else if (value instanceof StringProperty) {

                    row[i] = ((StringProperty) value).get();

                } else if (value instanceof IntegerProperty) {

                    row[i] = String.valueOf(((IntegerProperty) value).get());

                } else if (value instanceof DoubleProperty) {

                    row[i] = String.valueOf(((DoubleProperty) value).get());

                } else {

                    row[i] = value.toString();

                }
            }

            writer.writeNext(row);
            }
            // writer.close();
            
            } catch (FileNotFoundException e) {
                e.printStackTrace();
            }
    }
}
