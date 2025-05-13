/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.sms.dao;

import com.sms.model.Course;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Nilesh
 */
public class CourseDao {

    private Connection conn;

    public CourseDao(Connection conn) {
        this.conn = conn;
    }

    public void insertCourse(Course course) throws Exception {
        String sql = "INSERT INTO courses (code, name, description, credit_hours, teacher_id) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, course.getCode());
            ps.setString(2, course.getName());
            ps.setString(3, course.getDescription());
            ps.setInt(4, course.getCreditHours());
            ps.setInt(5, course.getTeacherId());
            ps.executeUpdate();
        }
    }

    public Course getCourseById(int id) throws Exception {
        String sql = "SELECT * FROM courses WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractCourse(rs);
            }
        }
        return null;
    }

    public List<Course> getAllCourses() throws Exception {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT * FROM courses";
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                courses.add(extractCourse(rs));
            }
        }
        return courses;
    }

    public List<Course> getCoursesByTeacherId(int teacherId) throws Exception {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT * FROM courses WHERE teacher_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, teacherId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                courses.add(extractCourse(rs));
            }
        }
        return courses;
    }

    public List<Course> getCoursesByStudentId(int studentId) throws Exception {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT c.* FROM courses c "
                + "JOIN student_courses sc ON c.id = sc.course_id "
                + "WHERE sc.student_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                courses.add(extractCourse(rs));
            }
        }
        return courses;
    }
    
    public void updateCourse(Course course) throws Exception {
        String sql = "UPDATE courses SET code=?, name=?, description=?, credit_hours=?, teacher_id=? WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, course.getCode());
            ps.setString(2, course.getName());
            ps.setString(3, course.getDescription());
            ps.setInt(4, course.getCreditHours());
            ps.setInt(5, course.getTeacherId());
            ps.setInt(6, course.getId());
            ps.executeUpdate();
        }
    }
    
    public void deleteCourse(int id) throws Exception {
        String sql = "DELETE FROM courses WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
    
    public int getStudentCountForCourse(int courseId) throws Exception {
        String sql = "SELECT COUNT(*) FROM student_courses WHERE course_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    private Course extractCourse(ResultSet rs) throws SQLException {
        Course course = new Course();
        course.setId(rs.getInt("id"));
        course.setCode(rs.getString("code"));
        course.setName(rs.getString("name"));
        course.setDescription(rs.getString("description"));
        course.setCreditHours(rs.getInt("credit_hours"));
        course.setTeacherId(rs.getInt("teacher_id"));
        return course;
    }
}
