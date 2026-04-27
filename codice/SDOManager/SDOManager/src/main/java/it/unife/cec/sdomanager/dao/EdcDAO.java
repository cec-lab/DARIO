/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package it.unife.cec.sdomanager.dao;

import it.unife.cec.sdomanager.database.DatabaseConnection;
import it.unife.cec.sdomanager.model.Edc;
import it.unife.cec.sdomanager.model.Sdo;
import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javafx.beans.property.DoubleProperty;
import javafx.beans.property.IntegerProperty;
import javafx.beans.property.Property;
import javafx.beans.property.StringProperty;

/**
 *
 * @author utente
 */
public class EdcDAO {

    public static List<Edc> findAll() throws SQLException {

    List<Edc> list = new ArrayList<>();
        String sql = "SELECT * FROM edc";

        try (Connection conn = DatabaseConnection.connect();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Edc edc = new Edc();
                // Cicla su tutti i campi della classe
                for (Field field : Edc.class.getDeclaredFields()) {
                    try {
                        field.setAccessible(true);
                        Object value = rs.getObject(field.getName()); // Nome campo = Nome colonna
                    
                        // Gestione specifica per JavaFX Properties
                        if (field.get(edc) instanceof StringProperty) {
                            ((StringProperty) field.get(edc)).set((String) value);
                        } else if (field.get(edc) instanceof IntegerProperty) {
                            ((IntegerProperty) field.get(edc)).set((Integer) value);
                        } else if (field.get(edc) instanceof DoubleProperty) {
                            ((DoubleProperty) field.get(edc)).set((Double) value);
                        }
                        // Aggiungi altri tipi se necessario (BooleanProperty, etc.)
                    } catch (Exception e) {
                    // Ignora campi che non sono nel DB (come serialVersionUID)
                    }
                }
                list.add(edc);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;

    }

    public void update(Edc edc) throws SQLException {
        
        StringBuilder sql = new StringBuilder("UPDATE edc SET ");
        List<Object> values = new ArrayList<>();
        Field[] fields = Edc.class.getDeclaredFields();

        for (Field field : fields) {
            try {
                field.setAccessible(true);
                Object property = field.get(edc);
            
                // Escludi l'ID dal SET e gestisci solo le Property JavaFX
                if (!field.getName().equalsIgnoreCase("id") && property instanceof Property) {
                    sql.append(field.getName()).append(" = ?, ");
                    values.add(((Property<?>) property).getValue());
                }
            } catch (IllegalAccessException e) { e.printStackTrace(); }
        }

        // Rimuovi l'ultima virgola e aggiungi la clausola WHERE
        sql.setLength(sql.length() - 2);
        sql.append(" WHERE id = ?");
        values.add(edc.getId());

        try (Connection conn = DatabaseConnection.connect();
            PreparedStatement ps = conn.prepareStatement(sql.toString())) {
        
            for (int i = 0; i < values.size(); i++) {
                ps.setObject(i + 1, values.get(i));
            }
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
        
//        String sql = "UPDATE edc "
//                + "SET nome=?, cognome=?, data_nascita=?, peso=?, classe_bmi=?"
//                + "WHERE id=?";
//
//        try (Connection conn = DatabaseConnection.connect();
//             PreparedStatement ps = conn.prepareStatement(sql)) {
//
//            ps.setString(1, edc.getNome());
//            ps.setString(2, edc.getCognome());
//            ps.setString(3, edc.getDataNascita());
//            ps.setDouble(4, edc.getPeso());
//            ps.setString(5, edc.getClasseBmi());
//            ps.setInt(6, edc.getId());
//            ps.executeUpdate();
//        }
    }

    public void delete(int id) throws SQLException {
        try (Connection conn = DatabaseConnection.connect();
             PreparedStatement ps =
                     conn.prepareStatement("DELETE FROM sdo WHERE id=?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}

