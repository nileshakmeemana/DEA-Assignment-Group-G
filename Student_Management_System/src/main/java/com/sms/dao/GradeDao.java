/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.sms.dao;

import com.sms.model.Grade;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Nilesh
 */
public class GradeDao {
    private Connection conn;

    public GradeDao(Connection conn) {
        this.conn = conn;
    }
    
    public void insertGrade(Grade grade) throws Exception {
        String sql = "INSERT INTO grades (student_id, course_id, assignment_score, midterm_score, final_score, total_score, grade) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, grade.getStudentId());
            ps.setInt(2, grade.getCourseId());
            ps.setBigDecimal(3, grade.getAssignmentScore());
            ps.setBigDecimal(4, grade.getMidtermScore());
            ps.setBigDecimal(5, grade.getFinalScore());
            ps.setBigDecimal(6, grade.getTotalScore());
            ps.setString(7, grade.getGrade());
            ps.executeUpdate();
        }
    }
    
    public Grade getGradeByStudentAndCourse(int studentId, int courseId) throws Exception {
        String sql = "SELECT * FROM grades WHERE student_id = ? AND course_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ps.setInt(2, courseId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractGrade(rs);
            }
        }
        return null;
    }
    
    public List<Grade> getGradesByStudentId(int studentId) throws Exception {
        List<Grade> list = new ArrayList<>();
        String sql = "SELECT * FROM grades WHERE student_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractGrade(rs));
            }
        }
        return list;
    }
    
    public List<Grade> getGradesByCourseId(int courseId) throws Exception {
        List<Grade> list = new ArrayList<>();
        String sql = "SELECT * FROM grades WHERE course_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractGrade(rs));
            }
        }
        return list;
    }
    
    public void updateGrade(Grade grade) throws Exception {
        String sql = "UPDATE grades SET assignment_score = ?, midterm_score = ?, final_score = ?, total_score = ?, grade = ? WHERE student_id = ? AND course_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setBigDecimal(1, grade.getAssignmentScore());
            ps.setBigDecimal(2, grade.getMidtermScore());
            ps.setBigDecimal(3, grade.getFinalScore());
            ps.setBigDecimal(4, grade.getTotalScore());
            ps.setString(5, grade.getGrade());
            ps.setInt(6, grade.getStudentId());
            ps.setInt(7, grade.getCourseId());
            ps.executeUpdate();
        }
    }
    
    public void deleteGrade(int studentId, int courseId) throws Exception {
        String sql = "DELETE FROM grades WHERE student_id = ? AND course_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ps.setInt(2, courseId);
            ps.executeUpdate();
        }
    }
    
    private Grade extractGrade(ResultSet rs) throws SQLException {
        Grade g = new Grade();
        g.setId(rs.getInt("id"));
        g.setStudentId(rs.getInt("student_id"));
        g.setCourseId(rs.getInt("course_id"));
        g.setAssignmentScore(rs.getBigDecimal("assignment_score"));
        g.setMidtermScore(rs.getBigDecimal("midterm_score"));
        g.setFinalScore(rs.getBigDecimal("final_score"));
        g.setTotalScore(rs.getBigDecimal("total_score"));
        g.setGrade(rs.getString("grade"));
        return g;
    }
}
