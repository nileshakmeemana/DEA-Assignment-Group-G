/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.sms.util;

import java.util.regex.Pattern;

/**
 *
 * @author Nilesh
 */
public class ValidationUtil {
    
    // Email validation pattern
    private static final Pattern EMAIL_PATTERN = 
        Pattern.compile("^[A-Za-z0-9+_.-]+@(.+)$");
    
    // Username validation pattern (alphanumeric, 3-20 characters)
    private static final Pattern USERNAME_PATTERN = 
        Pattern.compile("^[a-zA-Z0-9]{3,20}$");
    
    // Password validation pattern (at least 8 characters, at least one digit, one lowercase, one uppercase)
    private static final Pattern PASSWORD_PATTERN = 
        Pattern.compile("^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,}$");
    
    // Phone number validation pattern
    private static final Pattern PHONE_PATTERN = 
        Pattern.compile("^[0-9]{10,15}$");
    
    // Validate email
    public static boolean isValidEmail(String email) {
        if (email == null) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email).matches();
    }
    
    // Validate username
    public static boolean isValidUsername(String username) {
        if (username == null) {
            return false;
        }
        return USERNAME_PATTERN.matcher(username).matches();
    }
    
    // Validate password
    public static boolean isValidPassword(String password) {
        if (password == null) {
            return false;
        }
        return PASSWORD_PATTERN.matcher(password).matches();
    }
    
    // Validate phone number
    public static boolean isValidPhone(String phone) {
        if (phone == null) {
            return false;
        }
        return PHONE_PATTERN.matcher(phone).matches();
    }
    
    // Validate name (not empty, only letters and spaces)
    public static boolean isValidName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return false;
        }
        return name.matches("^[a-zA-Z ]+$");
    }
    
    // Validate course code (alphanumeric, 2-10 characters)
    public static boolean isValidCourseCode(String code) {
        if (code == null || code.trim().isEmpty()) {
            return false;
        }
        return code.matches("^[a-zA-Z0-9]{2,10}$");
    }
    
    // Validate credit hours (positive integer)
    public static boolean isValidCreditHours(int creditHours) {
        return creditHours > 0;
    }
    
    // Validate grade (A, B, C, D, F, possibly with + or -)
    public static boolean isValidGrade(String grade) {
        if (grade == null || grade.trim().isEmpty()) {
            return false;
        }
        return grade.matches("^[A-F][+-]?$");
    }
    
    // Validate attendance status (Present, Absent, Late)
    public static boolean isValidAttendanceStatus(String status) {
        if (status == null || status.trim().isEmpty()) {
            return false;
        }
        return status.equals("Present") || status.equals("Absent") || status.equals("Late");
    }
}
