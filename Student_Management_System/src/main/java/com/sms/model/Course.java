/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.sms.model;

import java.math.BigDecimal;

/**
 *
 * @author Nilesh
 */
public class Course {
    private int id;
    private String code;
    private String name;
    private String description;
    private int creditHours;
    private int teacherId;
    private BigDecimal overallGrade;
    
    public Course() {
        this.overallGrade = BigDecimal.ZERO;
    }
    
    public Course(String code, String name, String description, int creditHours, int teacherId) {
        this.code = code;
        this.name = name;
        this.description = description;
        this.creditHours = creditHours;
        this.teacherId = teacherId;
        this.overallGrade = BigDecimal.ZERO;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getCode() {
        return code;
    }
    
    public void setCode(String code) {
        this.code = code;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public int getCreditHours() {
        return creditHours;
    }
    
    public void setCreditHours(int creditHours) {
        this.creditHours = creditHours;
    }
    
    public int getTeacherId() {
        return teacherId;
    }
    
    public void setTeacherId(int teacherId) {
        this.teacherId = teacherId;
    }
    
    public BigDecimal getOverallGrade() {
        return overallGrade;
    }
    
    public void setOverallGrade(BigDecimal overallGrade) {
        this.overallGrade = overallGrade;
    }
    
    // Helper method to get overall grade as an integer for display
    public int getOverallGradeAsInt() {
        return overallGrade != null ? overallGrade.intValue() : 0;
    }
}