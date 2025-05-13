/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.sms.dao;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 *
 * @author Nilesh
 */
public class DatabaseConnection {
    private static final String PROPERTIES_FILE = "/database.properties";
    private static String jdbcURL;
    private static String jdbcUsername;
    private static String jdbcPassword;
    
    static {
        try {
            Properties props = new Properties();
            InputStream inputStream = DatabaseConnection.class.getResourceAsStream(PROPERTIES_FILE);
            
            if (inputStream != null) {
                props.load(inputStream);
                jdbcURL = props.getProperty("jdbc.url");
                jdbcUsername = props.getProperty("jdbc.username");
                jdbcPassword = props.getProperty("jdbc.password");
                
                // Load the JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");
            } else {
                // If properties file not found, use default values
                jdbcURL = "jdbc:mysql://localhost:3306/student_management_system";
                jdbcUsername = "root";
                jdbcPassword = "";
                
                // Load the JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");
            }
        } catch (ClassNotFoundException | IOException e) {
            e.printStackTrace();
        }
    }
    
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }
}
