package it.unife.cec.sdomanager.database;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author utente
 */

import java.io.File;
import java.sql.*;

public class DatabaseConnection {
    
    static String userHome = System.getProperty("user.home");
    
    static char separator = File.separatorChar;
    
    private static final String URL = "jdbc:sqlite:" + userHome + separator + "sdomanager.db";
    
    public static Connection connect() throws SQLException {
        try {
            Connection conn = DriverManager.getConnection(URL);
        } catch (Exception e) {
            System.err.println( e.getClass().getName() + ": " + e.getMessage() );
        }
        return DriverManager.getConnection(URL);
    } 
}
