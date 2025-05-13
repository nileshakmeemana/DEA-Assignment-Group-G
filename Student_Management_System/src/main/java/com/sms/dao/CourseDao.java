/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.sms.dao;

import com.sms.model.Course;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Nilesh
 */
public class CourseDao {
    
    // Insert a new course
    public boolean insertCourse(Course course) throws SQLException {
        String sql = "INSERT INTO courses (code, name, description, credit_hours, teacher_id) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, course.getCode());
            stmt.setString(2, course.getName());
            stmt.setString(3, course.getDescription());
            stmt.setInt(4, course.getCreditHours());
            
            if (course.getTeacherId() > 0) {
                stmt.setInt(5, course.getTeacherId());
            } else {
                stmt.setNull(5, java.sql.Types.INTEGER);
            }
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        course.setId(rs.getInt(1));
                        return true;
                    }
                }
            }
        }
        
        return false;
    }
    
    // Get course by ID
    public Course getCourseById(int id) throws SQLException {
        String sql = "SELECT * FROM courses WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Course course = new Course();
                    course.setId(rs.getInt("id"));
                    course.setCode(rs.getString("code"));
                    course.setName(rs.getString("name"));
                    course.setDescription(rs.getString("description"));
                    course.setCreditHours(rs.getInt("credit_hours"));
                    
                    // Check if teacher_id is NULL
                    int teacherId = rs.getInt("teacher_id");
                    if (!rs.wasNull()) {
                        course.setTeacherId(teacherId);
                    }
                    
                    return course;
                }
            }
        }
        
        return null;
    }
    
    // Get all courses
    public List<Course> getAllCourses() throws SQLException {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT * FROM courses";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("id"));
                course.setCode(rs.getString("code"));
                course.setName(rs.getString("name"));
                course.setDescription(rs.getString("description"));
                course.setCreditHours(rs.getInt("credit_hours"));
                
                // Check if teacher_id is NULL
                int teacherId = rs.getInt("teacher_id");
                if (!rs.wasNull()) {
                    course.setTeacherId(teacherId);
                }
                
                courses.add(course);
            }
        }
        
        return courses;
    }
    
    // Get courses by teacher ID
    public List<Course> getCoursesByTeacherId(int teacherId) throws SQLException {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT * FROM courses WHERE teacher_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, teacherId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Course course = new Course();
                    course.setId(rs.getInt("id"));
                    course.setCode(rs.getString("code"));
                    course.setName(rs.getString("name"));
                    course.setDescription(rs.getString("description"));
                    course.setCreditHours(rs.getInt("credit_hours"));
                    course.setTeacherId(teacherId);
                    
                    courses.add(course);
                }
            }
        }
        
        return courses;
    }
    
    // Get courses by student ID (enrolled courses)
    public List<Course> getCoursesByStudentId(int studentId) throws SQLException {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.* FROM courses c " +
                     "JOIN student_courses sc ON c.id = sc.course_id " +
                     "WHERE sc.student_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Course course = new Course();
                    course.setId(rs.getInt("id"));
                    course.setCode(rs.getString("code"));
                    course.setName(rs.getString("name"));
                    course.setDescription(rs.getString("description"));
                    course.setCreditHours(rs.getInt("credit_hours"));
                    
                    // Check if teacher_id is NULL
                    int teacherId = rs.getInt("teacher_id");
                    if (!rs.wasNull()) {
                        course.setTeacherId(teacherId);
                    }
                    
                    courses.add(course);
                }
            }
        }
        
        return courses;
    }
    
    // Update course
    public boolean updateCourse(Course course) throws SQLException {
        String sql = "UPDATE courses SET code = ?, name = ?, description = ?, credit_hours = ?, teacher_id = ? WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, course.getCode());
            stmt.setString(2, course.getName());
            stmt.setString(3, course.getDescription());
            stmt.setInt(4, course.getCreditHours());
            
            if (course.getTeacherId() > 0) {
                stmt.setInt(5, course.getTeacherId());
            } else {
                stmt.setNull(5, java.sql.Types.INTEGER);
            }
            
            stmt.setInt(6, course.getId());
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }
    
    // Delete course
    public boolean deleteCourse(int id) throws SQLException {
        String sql = "DELETE FROM courses WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }
    
    // Get student count for a course
    public int getStudentCountForCourse(int courseId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM student_courses WHERE course_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, courseId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        
        return 0;
    }
}
