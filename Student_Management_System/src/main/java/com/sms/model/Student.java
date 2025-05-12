/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.sms.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

/**
 *
 * @author Nilesh
 */
public class Student {
    private int id;
    private int userId;
    private String firstName;
    private String lastName;
    private Date dob;
    private String gender;
    private String address;
    private String phone;
    private Date enrollmentDate;
    private String program;
    private BigDecimal gpa;
    private int creditsCompleted;
    private String yearLevel;
    private String academicStanding;
    
    public Student() {}
    
    public Student(int userId, String firstName, String lastName, Date dob, String gender, String address, String phone, Date enrollmentDate) {
        this.userId = userId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.dob = dob;
        this.gender = gender;
        this.address = address;
        this.phone = phone;
        this.enrollmentDate = enrollmentDate;
        this.program = program;
        this.yearLevel = yearLevel;
        this.gpa = BigDecimal.ZERO;
        this.creditsCompleted = 0;
        this.academicStanding = "Good Standing";
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getFirstName() {
        return firstName;
    }
    
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    
    public String getLastName() {
        return lastName;
    }
    
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    
    public Date getDob() {
        return dob;
    }
    
    public void setDob(Date dob) {
        this.dob = dob;
    }
    
    public String getGender() {
        return gender;
    }
    
    public void setGender(String gender) {
        this.gender = gender;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public Date getEnrollmentDate() {
        return enrollmentDate;
    }
    
    public void setEnrollmentDate(Date enrollmentDate) {
        this.enrollmentDate = enrollmentDate;
    }
    
    public String getFullName() {
        return firstName + " " + lastName;
    }
    
    public String getProgram() {
        return program;
    }
    
    public void setProgram(String program) {
        this.program = program;
    }
    
    public BigDecimal getGpa() {
        return gpa;
    }
    
    public void setGpa(BigDecimal gpa) {
        this.gpa = gpa;
    }
    
    public int getCreditsCompleted() {
        return creditsCompleted;
    }
    
    public void setCreditsCompleted(int creditsCompleted) {
        this.creditsCompleted = creditsCompleted;
    }
    
    public String getYearLevel() {
        return yearLevel;
    }
    
    public void setYearLevel(String yearLevel) {
        this.yearLevel = yearLevel;
    }
    
    public String getAcademicStanding() {
        return academicStanding;
    }
    
    public void setAcademicStanding(String academicStanding) {
        this.academicStanding = academicStanding;
    }
    
    // Calculate GPA based on grades
    public void calculateGpa(List<Grade> grades) {
        if (grades == null || grades.isEmpty()) {
            this.gpa = BigDecimal.ZERO;
            return;
        }
        
        BigDecimal totalPoints = BigDecimal.ZERO;
        int totalCredits = 0;
        
        for (Grade grade : grades) {
            // Assuming each course is worth 3 credits
            int credits = 3;
            totalCredits += credits;
            
            // Convert letter grade to grade points
            BigDecimal gradePoints;
            String letterGrade = grade.getGrade();
            
            if ("A".equals(letterGrade)) {
                gradePoints = new BigDecimal("4.0");
            } else if ("B".equals(letterGrade)) {
                gradePoints = new BigDecimal("3.0");
            } else if ("C".equals(letterGrade)) {
                gradePoints = new BigDecimal("2.0");
            } else if ("D".equals(letterGrade)) {
                gradePoints = new BigDecimal("1.0");
            } else {
                gradePoints = BigDecimal.ZERO;
            }
            
            // Add to total points (credits * grade points)
            totalPoints = totalPoints.add(gradePoints.multiply(new BigDecimal(credits)));
        }
        
        // Calculate GPA
        if (totalCredits > 0) {
            this.gpa = totalPoints.divide(new BigDecimal(totalCredits), 2, BigDecimal.ROUND_HALF_UP);
            this.creditsCompleted = totalCredits;
            
            // Update academic standing based on GPA
            if (this.gpa.compareTo(new BigDecimal("2.0")) < 0) {
                this.academicStanding = "Academic Probation";
            } else if (this.gpa.compareTo(new BigDecimal("3.0")) < 0) {
                this.academicStanding = "Good Standing";
            } else {
                this.academicStanding = "Dean's List";
            }
        }
    }
}
