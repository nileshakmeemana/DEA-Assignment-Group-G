/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.sms.dao;

import com.sms.model.Student;
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
public class StudentDao {
    
    // Insert a new student
    public boolean insertStudent(Student student) throws SQLException {
        String sql = "INSERT INTO students (user_id, first_name, last_name, dob, gender, address, phone, enrollment_date) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, student.getUserId());
            stmt.setString(2, student.getFirstName());
            stmt.setString(3, student.getLastName());
            stmt.setDate(4, student.getDob());
            stmt.setString(5, student.getGender());
            stmt.setString(6, student.getAddress());
            stmt.setString(7, student.getPhone());
            stmt.setDate(8, student.getEnrollmentDate());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        student.setId(rs.getInt(1));
                        return true;
                    }
                }
            }
        }
        
        return false;
    }
    
    // Get student by ID
    public Student getStudentById(int id) throws SQLException {
        String sql = "SELECT * FROM students WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Student student = new Student();
                    student.setId(rs.getInt("id"));
                    student.setUserId(rs.getInt("user_id"));
                    student.setFirstName(rs.getString("first_name"));
                    student.setLastName(rs.getString("last_name"));
                    student.setDob(rs.getDate("dob"));
                    student.setGender(rs.getString("gender"));
                    student.setAddress(rs.getString("address"));
                    student.setPhone(rs.getString("phone"));
                    student.setEnrollmentDate(rs.getDate("enrollment_date"));
                    return student;
                }
            }
        }
        
        return null;
    }
    
    // Get student by user ID
    public Student getStudentByUserId(int userId) throws SQLException {
        String sql = "SELECT * FROM students WHERE user_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Student student = new Student();
                    student.setId(rs.getInt("id"));
                    student.setUserId(rs.getInt("user_id"));
                    student.setFirstName(rs.getString("first_name"));
                    student.setLastName(rs.getString("last_name"));
                    student.setDob(rs.getDate("dob"));
                    student.setGender(rs.getString("gender"));
                    student.setAddress(rs.getString("address"));
                    student.setPhone(rs.getString("phone"));
                    student.setEnrollmentDate(rs.getDate("enrollment_date"));
                    return student;
                }
            }
        }
        
        return null;
    }

    // Get students by course ID
    public List<Integer> getStudentsByCourseId(int courseId) throws SQLException {
        List<Integer> studentIds = new ArrayList<>();
        String sql = "SELECT student_id FROM student_courses WHERE course_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, courseId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    studentIds.add(rs.getInt("student_id"));
                }
            }
        }
        
        return studentIds;
    }

    
    // Get all students
    public List<Student> getAllStudents() throws SQLException {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students";
        
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Student student = new Student();
                student.setId(rs.getInt("id"));
                student.setUserId(rs.getInt("user_id"));
                student.setFirstName(rs.getString("first_name"));
                student.setLastName(rs.getString("last_name"));
                student.setDob(rs.getDate("dob"));
                student.setGender(rs.getString("gender"));
                student.setAddress(rs.getString("address"));
                student.setPhone(rs.getString("phone"));
                student.setEnrollmentDate(rs.getDate("enrollment_date"));
                students.add(student);
            }
        }
        
        return students;
    }
    
    // Update student
    public boolean updateStudent(Student student) throws SQLException {
        String sql = "UPDATE students SET first_name = ?, last_name = ?, dob = ?, gender = ?, " +
                     "address = ?, phone = ?, enrollment_date = ? WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, student.getFirstName());
            stmt.setString(2, student.getLastName());
            stmt.setDate(3, student.getDob());
            stmt.setString(4, student.getGender());
            stmt.setString(5, student.getAddress());
            stmt.setString(6, student.getPhone());
            stmt.setDate(7, student.getEnrollmentDate());
            stmt.setInt(8, student.getId());
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }
    
    // Delete student
    public boolean deleteStudent(int id) throws SQLException {
        String sql = "DELETE FROM students WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }
    
    // Enroll student in a course
    public boolean enrollStudentInCourse(int studentId, int courseId) throws SQLException {
        String sql = "INSERT INTO student_courses (student_id, course_id, enrollment_date) VALUES (?, ?, CURDATE())";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            stmt.setInt(2, courseId);
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }
    
    // Get courses for a student
    public List<Integer> getStudentCourses(int studentId) throws SQLException {
        List<Integer> courseIds = new ArrayList<>();
        String sql = "SELECT course_id FROM student_courses WHERE student_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    courseIds.add(rs.getInt("course_id"));
                }
            }
        }
        
        return courseIds;
    }
    
    // Remove student from a course
    public boolean removeStudentFromCourse(int studentId, int courseId) throws SQLException {
        String sql = "DELETE FROM student_courses WHERE student_id = ? AND course_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, studentId);
            stmt.setInt(2, courseId);
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }
}

