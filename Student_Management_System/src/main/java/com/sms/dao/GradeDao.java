/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.sms.dao;

import com.sms.model.Grade;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Nilesh
 */
public class GradeDao {
    
    // Insert a new grade
    public boolean insertGrade(Grade grade) throws SQLException {
        String sql = "INSERT INTO grades (student_id, course_id, assignment_score, midterm_score, final_score, total_score, grade) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, grade.getStudentId());
            stmt.setInt(2, grade.getCourseId());
            
            if (grade.getAssignmentScore() != null) {
                stmt.setBigDecimal(3, grade.getAssignmentScore());
            } else {
                stmt.setNull(3, java.sql.Types.DECIMAL);
            }
            
            if (grade.getMidtermScore() != null) {
                stmt.setBigDecimal(4, grade.getMidtermScore());
            } else {
                stmt.setNull(4, java.sql.Types.DECIMAL);
            }
            
            if (grade.getFinalScore() != null) {
                stmt.setBigDecimal(5, grade.getFinalScore());
            } else {
                stmt.setNull(5, java.sql.Types.DECIMAL);
            }
            
            if (grade.getTotalScore() != null) {
                stmt.setBigDecimal(6, grade.getTotalScore());
            } else {
                stmt.setNull(6, java.sql.Types.DECIMAL);
            }
            
            if (grade.getGrade() != null) {
                stmt.setString(7, grade.getGrade());
            } else {
                stmt.setNull(7, java.sql.Types.CHAR);
            }
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }
    
    // Get grade by student ID and course ID
    public Grade getGradeByStudentAndCourse(int studentId, int courseId) throws SQLException {
        String sql = "SELECT * FROM grades WHERE student_id = ? AND course_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            stmt.setInt(2, courseId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Grade grade = new Grade();
                    grade.setId(rs.getInt("id"));
                    grade.setStudentId(rs.getInt("student_id"));
                    grade.setCourseId(rs.getInt("course_id"));
                    
                    // Handle potential NULL values
                    BigDecimal assignmentScore = rs.getBigDecimal("assignment_score");
                    if (!rs.wasNull()) {
                        grade.setAssignmentScore(assignmentScore);
                    }
                    
                    BigDecimal midtermScore = rs.getBigDecimal("midterm_score");
                    if (!rs.wasNull()) {
                        grade.setMidtermScore(midtermScore);
                    }
                    
                    BigDecimal finalScore = rs.getBigDecimal("final_score");
                    if (!rs.wasNull()) {
                        grade.setFinalScore(finalScore);
                    }
                    
                    BigDecimal totalScore = rs.getBigDecimal("total_score");
                    if (!rs.wasNull()) {
                        grade.setTotalScore(totalScore);
                    }
                    
                    String letterGrade = rs.getString("grade");
                    if (!rs.wasNull()) {
                        grade.setGrade(letterGrade);
                    }
                    
                    return grade;
                }
            }
        }
        
        return null;
    }
    
    // Get all grades for a student
    public List<Grade> getGradesByStudentId(int studentId) throws SQLException {
        List<Grade> grades = new ArrayList<>();
        String sql = "SELECT * FROM grades WHERE student_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Grade grade = new Grade();
                    grade.setId(rs.getInt("id"));
                    grade.setStudentId(rs.getInt("student_id"));
                    grade.setCourseId(rs.getInt("course_id"));
                    
                    // Handle potential NULL values
                    BigDecimal assignmentScore = rs.getBigDecimal("assignment_score");
                    if (!rs.wasNull()) {
                        grade.setAssignmentScore(assignmentScore);
                    }
                    
                    BigDecimal midtermScore = rs.getBigDecimal("midterm_score");
                    if (!rs.wasNull()) {
                        grade.setMidtermScore(midtermScore);
                    }
                    
                    BigDecimal finalScore = rs.getBigDecimal("final_score");
                    if (!rs.wasNull()) {
                        grade.setFinalScore(finalScore);
                    }
                    
                    BigDecimal totalScore = rs.getBigDecimal("total_score");
                    if (!rs.wasNull()) {
                        grade.setTotalScore(totalScore);
                    }
                    
                    String letterGrade = rs.getString("grade");
                    if (!rs.wasNull()) {
                        grade.setGrade(letterGrade);
                    }
                    
                    grades.add(grade);
                }
            }
        }
        
        return grades;
    }
    
    // Get all grades for a course
    public List<Grade> getGradesByCourseId(int courseId) throws SQLException {
        List<Grade> grades = new ArrayList<>();
        String sql = "SELECT * FROM grades WHERE course_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, courseId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Grade grade = new Grade();
                    grade.setId(rs.getInt("id"));
                    grade.setStudentId(rs.getInt("student_id"));
                    grade.setCourseId(rs.getInt("course_id"));
                    
                    // Handle potential NULL values
                    BigDecimal assignmentScore = rs.getBigDecimal("assignment_score");
                    if (!rs.wasNull()) {
                        grade.setAssignmentScore(assignmentScore);
                    }
                    
                    BigDecimal midtermScore = rs.getBigDecimal("midterm_score");
                    if (!rs.wasNull()) {
                        grade.setMidtermScore(midtermScore);
                    }
                    
                    BigDecimal finalScore = rs.getBigDecimal("final_score");
                    if (!rs.wasNull()) {
                        grade.setFinalScore(finalScore);
                    }
                    
                    BigDecimal totalScore = rs.getBigDecimal("total_score");
                    if (!rs.wasNull()) {
                        grade.setTotalScore(totalScore);
                    }
                    
                    String letterGrade = rs.getString("grade");
                    if (!rs.wasNull()) {
                        grade.setGrade(letterGrade);
                    }
                    
                    grades.add(grade);
                }
            }
        }
        
        return grades;
    }
    
    // Update grade
    public boolean updateGrade(Grade grade) throws SQLException {
        String sql = "UPDATE grades SET assignment_score = ?, midterm_score = ?, final_score = ?, " +
                     "total_score = ?, grade = ? WHERE student_id = ? AND course_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            if (grade.getAssignmentScore() != null) {
                stmt.setBigDecimal(1, grade.getAssignmentScore());
            } else {
                stmt.setNull(1, java.sql.Types.DECIMAL);
            }
            
            if (grade.getMidtermScore() != null) {
                stmt.setBigDecimal(2, grade.getMidtermScore());
            } else {
                stmt.setNull(2, java.sql.Types.DECIMAL);
            }
            
            if (grade.getFinalScore() != null) {
                stmt.setBigDecimal(3, grade.getFinalScore());
            } else {
                stmt.setNull(3, java.sql.Types.DECIMAL);
            }
            
            if (grade.getTotalScore() != null) {
                stmt.setBigDecimal(4, grade.getTotalScore());
            } else {
                stmt.setNull(4, java.sql.Types.DECIMAL);
            }
            
            if (grade.getGrade() != null) {
                stmt.setString(5, grade.getGrade());
            } else {
                stmt.setNull(5, java.sql.Types.CHAR);
            }
            
            stmt.setInt(6, grade.getStudentId());
            stmt.setInt(7, grade.getCourseId());
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }
    
    // Delete grade
    public boolean deleteGrade(int studentId, int courseId) throws SQLException {
        String sql = "DELETE FROM grades WHERE student_id = ? AND course_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            stmt.setInt(2, courseId);
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }
}