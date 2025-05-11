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
public class Grade {
    private int id;
    private int studentId;
    private int courseId;
    private BigDecimal assignmentScore;
    private BigDecimal midtermScore;
    private BigDecimal finalScore;
    private BigDecimal totalScore;
    private String grade;
    private BigDecimal gradePoint; // Added for GPA calculation
    
    public Grade() {}
    
    public Grade(int studentId, int courseId, BigDecimal assignmentScore, 
                BigDecimal midtermScore, BigDecimal finalScore) {
        this.studentId = studentId;
        this.courseId = courseId;
        this.assignmentScore = assignmentScore;
        this.midtermScore = midtermScore;
        this.finalScore = finalScore;
        calculateTotal();
        calculateGrade();
        calculateGradePoint();
    }
    
    // Calculate total score (30% assignments, 30% midterm, 40% final)
    private void calculateTotal() {
        if (assignmentScore != null && midtermScore != null && finalScore != null) {
            BigDecimal assignmentWeight = new BigDecimal("0.3");
            BigDecimal midtermWeight = new BigDecimal("0.3");
            BigDecimal finalWeight = new BigDecimal("0.4");
            
            this.totalScore = assignmentScore.multiply(assignmentWeight)
                            .add(midtermScore.multiply(midtermWeight))
                            .add(finalScore.multiply(finalWeight));
        }
    }
    
    // Calculate letter grade based on total score
    private void calculateGrade() {
        if (totalScore != null) {
            if (totalScore.compareTo(new BigDecimal("90")) >= 0) {
                this.grade = "A";
            } else if (totalScore.compareTo(new BigDecimal("80")) >= 0) {
                this.grade = "B";
            } else if (totalScore.compareTo(new BigDecimal("70")) >= 0) {
                this.grade = "C";
            } else if (totalScore.compareTo(new BigDecimal("60")) >= 0) {
                this.grade = "D";
            } else {
                this.grade = "F";
            }
        }
    }
    
    // Calculate grade point for GPA
    private void calculateGradePoint() {
        if (grade != null) {
            switch (grade) {
                case "A":
                    this.gradePoint = new BigDecimal("4.0");
                    break;
                case "B":
                    this.gradePoint = new BigDecimal("3.0");
                    break;
                case "C":
                    this.gradePoint = new BigDecimal("2.0");
                    break;
                case "D":
                    this.gradePoint = new BigDecimal("1.0");
                    break;
                case "F":
                default:
                    this.gradePoint = new BigDecimal("0.0");
                    break;
            }
        }
    }
    
    // Calculate earned credits based on grade
    public BigDecimal calculateEarnedCredits(int creditHours) {
        if (grade != null && !grade.equals("F")) {
            return new BigDecimal(creditHours);
        }
        return BigDecimal.ZERO;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public int getStudentId() {
        return studentId;
    }
    
    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }
    
    public int getCourseId() {
        return courseId;
    }
    
    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }
    
    public BigDecimal getAssignmentScore() {
        return assignmentScore;
    }
    
    public void setAssignmentScore(BigDecimal assignmentScore) {
        this.assignmentScore = assignmentScore;
        calculateTotal();
        calculateGrade();
        calculateGradePoint();
    }
    
    public BigDecimal getMidtermScore() {
        return midtermScore;
    }
    
    public void setMidtermScore(BigDecimal midtermScore) {
        this.midtermScore = midtermScore;
        calculateTotal();
        calculateGrade();
        calculateGradePoint();
    }
    
    public BigDecimal getFinalScore() {
        return finalScore;
    }
    
    public void setFinalScore(BigDecimal finalScore) {
        this.finalScore = finalScore;
        calculateTotal();
        calculateGrade();
        calculateGradePoint();
    }
    
    public BigDecimal getTotalScore() {
        return totalScore;
    }
    
    public void setTotalScore(BigDecimal totalScore) {
        this.totalScore = totalScore;
    }
    
    public String getGrade() {
        return grade;
    }
    
    public void setGrade(String grade) {
        this.grade = grade;
        calculateGradePoint();
    }
    
    public BigDecimal getGradePoint() {
        return gradePoint;
    }
    
    public void setGradePoint(BigDecimal gradePoint) {
        this.gradePoint = gradePoint;
    }
    
    // Get academic status based on grade point
    public String getAcademicStatus() {
        if (gradePoint == null) {
            return "Not Graded";
        }
        
        if (gradePoint.compareTo(new BigDecimal("3.5")) >= 0) {
            return "Excellent";
        } else if (gradePoint.compareTo(new BigDecimal("3.0")) >= 0) {
            return "Very Good";
        } else if (gradePoint.compareTo(new BigDecimal("2.5")) >= 0) {
            return "Good";
        } else if (gradePoint.compareTo(new BigDecimal("2.0")) >= 0) {
            return "Satisfactory";
        } else if (gradePoint.compareTo(new BigDecimal("1.0")) >= 0) {
            return "Poor";
        } else {
            return "Failing";
        }
    }
}
