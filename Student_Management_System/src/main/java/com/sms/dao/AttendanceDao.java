/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.sms.dao;

import com.sms.model.Attendance;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Nilesh
 */
public class AttendanceDao {
    
    // Insert a new attendance record
    public boolean insertAttendance(Attendance attendance) throws SQLException {
        String sql = "INSERT INTO attendance (student_id, course_id, date, status) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, attendance.getStudentId());
            stmt.setInt(2, attendance.getCourseId());
            stmt.setDate(3, attendance.getDate());
            stmt.setString(4, attendance.getStatus());
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }
    
    // Get attendance by ID
    public Attendance getAttendanceById(int id) throws SQLException {
        String sql = "SELECT * FROM attendance WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Attendance attendance = new Attendance();
                    attendance.setId(rs.getInt("id"));
                    attendance.setStudentId(rs.getInt("student_id"));
                    attendance.setCourseId(rs.getInt("course_id"));
                    attendance.setDate(rs.getDate("date"));
                    attendance.setStatus(rs.getString("status"));
                    return attendance;
                }
            }
        }
        
        return null;
    }
    
    // Get attendance by student ID, course ID, and date
    public Attendance getAttendanceByStudentCourseDate(int studentId, int courseId, Date date) throws SQLException {
        String sql = "SELECT * FROM attendance WHERE student_id = ? AND course_id = ? AND date = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            stmt.setInt(2, courseId);
            stmt.setDate(3, date);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Attendance attendance = new Attendance();
                    attendance.setId(rs.getInt("id"));
                    attendance.setStudentId(rs.getInt("student_id"));
                    attendance.setCourseId(rs.getInt("course_id"));
                    attendance.setDate(rs.getDate("date"));
                    attendance.setStatus(rs.getString("status"));
                    return attendance;
                }
            }
        }
        
        return null;
    }
    
    // Get all attendance records for a student
    public List<Attendance> getAttendanceByStudentId(int studentId) throws SQLException {
        List<Attendance> attendanceList = new ArrayList<>();
        String sql = "SELECT * FROM attendance WHERE student_id = ? ORDER BY date DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Attendance attendance = new Attendance();
                    attendance.setId(rs.getInt("id"));
                    attendance.setStudentId(rs.getInt("student_id"));
                    attendance.setCourseId(rs.getInt("course_id"));
                    attendance.setDate(rs.getDate("date"));
                    attendance.setStatus(rs.getString("status"));
                    attendanceList.add(attendance);
                }
            }
        }
        
        return attendanceList;
    }
    
    // Get all attendance records for a course
    public List<Attendance> getAttendanceByCourseId(int courseId) throws SQLException {
        List<Attendance> attendanceList = new ArrayList<>();
        String sql = "SELECT * FROM attendance WHERE course_id = ? ORDER BY date DESC, student_id";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, courseId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Attendance attendance = new Attendance();
                    attendance.setId(rs.getInt("id"));
                    attendance.setStudentId(rs.getInt("student_id"));
                    attendance.setCourseId(rs.getInt("course_id"));
                    attendance.setDate(rs.getDate("date"));
                    attendance.setStatus(rs.getString("status"));
                    attendanceList.add(attendance);
                }
            }
        }
        
        return attendanceList;
    }
    
    // Get attendance records for a student in a specific course
    public List<Attendance> getAttendanceByStudentAndCourse(int studentId, int courseId) throws SQLException {
        List<Attendance> attendanceList = new ArrayList<>();
        String sql = "SELECT * FROM attendance WHERE student_id = ? AND course_id = ? ORDER BY date DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            stmt.setInt(2, courseId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Attendance attendance = new Attendance();
                    attendance.setId(rs.getInt("id"));
                    attendance.setStudentId(rs.getInt("student_id"));
                    attendance.setCourseId(rs.getInt("course_id"));
                    attendance.setDate(rs.getDate("date"));
                    attendance.setStatus(rs.getString("status"));
                    attendanceList.add(attendance);
                }
            }
        }
        
        return attendanceList;
    }
    
    // Get attendance records for a specific date in a course
    public List<Attendance> getAttendanceByDateAndCourse(Date date, int courseId) throws SQLException {
        List<Attendance> attendanceList = new ArrayList<>();
        String sql = "SELECT * FROM attendance WHERE date = ? AND course_id = ? ORDER BY student_id";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setDate(1, date);
            stmt.setInt(2, courseId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Attendance attendance = new Attendance();
                    attendance.setId(rs.getInt("id"));
                    attendance.setStudentId(rs.getInt("student_id"));
                    attendance.setCourseId(rs.getInt("course_id"));
                    attendance.setDate(rs.getDate("date"));
                    attendance.setStatus(rs.getString("status"));
                    attendanceList.add(attendance);
                }
            }
        }
        
        return attendanceList;
    }
    
    // Update attendance
    public boolean updateAttendance(Attendance attendance) throws SQLException {
        String sql = "UPDATE attendance SET status = ? WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, attendance.getStatus());
            stmt.setInt(2, attendance.getId());
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }
    
    // Delete attendance
    public boolean deleteAttendance(int id) throws SQLException {
        String sql = "DELETE FROM attendance WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }
    
    // Get attendance percentage for a student in a course
    public double getAttendancePercentage(int studentId, int courseId) throws SQLException {
        String sql = "SELECT COUNT(*) AS total, " +
                     "SUM(CASE WHEN status = 'Present' THEN 1 ELSE 0 END) AS present " +
                     "FROM attendance WHERE student_id = ? AND course_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            stmt.setInt(2, courseId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int total = rs.getInt("total");
                    int present = rs.getInt("present");
                    
                    if (total > 0) {
                        return (double) present / total * 100;
                    }
                }
            }
        }
        
        return 0.0;
    }
}