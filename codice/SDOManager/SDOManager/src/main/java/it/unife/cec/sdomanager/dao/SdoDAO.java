/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package it.unife.cec.sdomanager.dao;

import it.unife.cec.sdomanager.database.DatabaseConnection;
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
public class SdoDAO {


    public static List<Sdo> findAll() throws SQLException {
//        List<Sdo> list = new ArrayList<>();
//        String sql = "SELECT * FROM sdo";
//
//        try (Connection conn = DatabaseConnection.connect();
//             Statement stmt = conn.createStatement();
//             ResultSet rs = stmt.executeQuery(sql)) {
//
//            while (rs.next()) {
//                list.add(new Sdo(
//                        rs.getInt("id"),
//                        rs.getString("nome"),
//                        rs.getString("cognome"),
//                        rs.getString("data_nascita"),
//                        rs.getDouble("peso"),
//                        rs.getString("classe_bmi")
//                ));
//            }
//        }
//        return list;
        
        List<Sdo> list = new ArrayList<>();
        String sql = "SELECT * FROM sdo";

        try (Connection conn = DatabaseConnection.connect();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Sdo sdo = new Sdo();
                // Cicla su tutti i campi della classe
                for (Field field : Sdo.class.getDeclaredFields()) {
                    try {
                        field.setAccessible(true);
                        Object value = rs.getObject(field.getName()); // Nome campo = Nome colonna
                    
                        // Gestione specifica per JavaFX Properties
                        if (field.get(sdo) instanceof StringProperty) {
                            ((StringProperty) field.get(sdo)).set((String) value);
                        } else if (field.get(sdo) instanceof IntegerProperty) {
                            ((IntegerProperty) field.get(sdo)).set((Integer) value);
                        } else if (field.get(sdo) instanceof DoubleProperty) {
                            ((DoubleProperty) field.get(sdo)).set((Double) value);
                        }
                        // Aggiungi altri tipi se necessario (BooleanProperty, etc.)
                    } catch (Exception e) {
                    // Ignora campi che non sono nel DB (come serialVersionUID)
                    }
                }
                list.add(sdo);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
}

    public void update(Sdo sdo) throws SQLException {
        
        
        
        StringBuilder sql = new StringBuilder("UPDATE sdo SET ");
        List<Object> values = new ArrayList<>();
        Field[] fields = Sdo.class.getDeclaredFields();

        for (Field field : fields) {
            try {
                field.setAccessible(true);
                Object property = field.get(sdo);
            
                // Escludi l'ID dal SET e gestisci solo le Property JavaFX
                if (!field.getName().equalsIgnoreCase("id_sdo") && property instanceof Property) {
                    sql.append(field.getName()).append(" = ?, ");
                    values.add(((Property<?>) property).getValue());
                }
            } catch (IllegalAccessException e) { e.printStackTrace(); }
        }

        // Rimuovi l'ultima virgola e aggiungi la clausola WHERE
        sql.setLength(sql.length() - 2);
        sql.append(" WHERE id_sdo = ?");
        values.add(sdo.id_sdo.getValue());

        try (Connection conn = DatabaseConnection.connect();
            PreparedStatement ps = conn.prepareStatement(sql.toString())) {
        
            for (int i = 0; i < values.size(); i++) {
                ps.setObject(i + 1, values.get(i));
            }
            ps.executeUpdate();
            System.out.print(ps);
        } catch (SQLException e) { e.printStackTrace(); }
}

//        String sql = "UPDATE sdo "
//                + "SET nome=?, cognome=?, data_nascita=?, peso=?, classe_bmi=?"
//                + "WHERE id=?";
//
//        try (Connection conn = DatabaseConnection.connect();
//             PreparedStatement ps = conn.prepareStatement(sql)) {
//
//            ps.setString(1, sdo.getNome());
//            ps.setString(2, sdo.getCognome());
//            ps.setString(3, sdo.getDataNascita());
//            ps.setDouble(4, sdo.getPeso());
//            ps.setString(5, sdo.getClasseBmi());
//            ps.setInt(6, sdo.getId());
//            ps.executeUpdate();
//        }

    public void delete(int id) throws SQLException {
        try (Connection conn = DatabaseConnection.connect();
             PreparedStatement ps =
                     conn.prepareStatement("DELETE FROM sdo WHERE id=?")) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}
