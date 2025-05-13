/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.sms.dao;

import com.sms.model.Course;
import com.sms.model.Teacher;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Nilesh
 */
public class TeacherDao {

    private Connection conn;

    public TeacherDao(Connection conn) {
        this.conn = conn;
    }

    public void insertTeacher(Teacher teacher) throws Exception {
        String sql = "INSERT INTO teachers (user_id, first_name, last_name, dob, gender, address, phone, hire_date, qualification) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, teacher.getUserId());
            ps.setString(2, teacher.getFirstName());
            ps.setString(3, teacher.getLastName());
            ps.setDate(4, (Date) teacher.getDob());
            ps.setString(5, teacher.getGender());
            ps.setString(6, teacher.getAddress());
            ps.setString(7, teacher.getPhone());
            ps.setDate(8, (Date) teacher.getHireDate());
            ps.setString(9, teacher.getQualification());
            ps.executeUpdate();
        }
    }

    public Teacher getTeacherById(int id) throws Exception {
        String sql = "SELECT * FROM tearchers WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractTeacher(rs);
            }
        }
        return null;
    }

    public Teacher getTeacherByUserId(int userId) throws Exception {
        String sql = "SELECT * FROM teachers WHERE user_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractTeacher(rs);
            }
        }
        return null;
    }

    public List<Teacher> getAllTeachers() throws Exception {
        List<Teacher> teachers = new ArrayList<>();
        String sql = "SELECT * FROM teachers";
        try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                teachers.add(extractTeacher(rs));
            }
        }
        return teachers;
    }

    public void updateTeacher(Teacher teacher) throws Exception {
        String sql = "UPDATE teachers SET user_id=?, first_name=?, last_name=?, dob=?, gender=?, address=?, phone=?, hire_date=?, qualification=? WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, teacher.getUserId());
            ps.setString(2, teacher.getFirstName());
            ps.setString(3, teacher.getLastName());
            ps.setDate(4, (Date) teacher.getDob());
            ps.setString(5, teacher.getGender());
            ps.setString(6, teacher.getAddress());
            ps.setString(7, teacher.getPhone());
            ps.setDate(8, (Date) teacher.getHireDate());
            ps.setString(9, teacher.getQualification());
            ps.setInt(10, teacher.getId());
            ps.executeUpdate();
        }
    }
    
    public void deleteTeacher(int id) throws Exception{
        String sql = "DELETE * FROM tearchers WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
    
    public List<Course> getTeacherCourses(int teacherId) throws Exception {
        List<Course> courses = new ArrayList<>();
        String sql = "SELECT * FROM courses WHERE teacher_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, teacherId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Course course = new Course();
                course.setId(rs.getInt("id"));
                course.setCode(rs.getString("code"));
                course.setName(rs.getString("name"));
                course.setDescription(rs.getString("description"));
                course.setCreditHours(rs.getInt("credit_hours"));
                course.setTeacherId(rs.getInt("teacher_id"));
                courses.add(course);
            }
        }
        return courses;
    }

    private Teacher extractTeacher(ResultSet rs) throws SQLException {
        Teacher teacher = new Teacher();
        teacher.setId(rs.getInt("id"));
        teacher.setUserId(rs.getInt("user_id"));
        teacher.setFirstName(rs.getString("first_name"));
        teacher.setLastName(rs.getString("last_name"));
        teacher.setDob(rs.getDate("dob"));
        teacher.setGender(rs.getString("gender"));
        teacher.setAddress(rs.getString("address"));
        teacher.setPhone(rs.getString("phone"));
        teacher.setHireDate(rs.getDate("hire_date"));
        teacher.setQualification(rs.getString("qualification"));
        return teacher;
    }
}
