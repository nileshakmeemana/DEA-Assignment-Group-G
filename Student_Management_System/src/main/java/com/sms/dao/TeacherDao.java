/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.sms.dao;

import com.sms.model.Teacher;
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
public class TeacherDao {

    public boolean insertTeacher(Teacher teacher) throws SQLException {
        String sql = "INSERT INTO teachers (user_id, first_name, last_name, dob, gender, address, phone, hire_date, qualification) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, teacher.getUserId());
            stmt.setString(2, teacher.getFirstName());
            stmt.setString(3, teacher.getLastName());
            stmt.setDate(4, teacher.getDob());
            stmt.setString(5, teacher.getGender());
            stmt.setString(6, teacher.getAddress());
            stmt.setString(7, teacher.getPhone());
            stmt.setDate(8, teacher.getHireDate());
            stmt.setString(9, teacher.getQualification());

            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        teacher.setId(rs.getInt(1));
                        return true;
                    }
                }
            }
        }

        return false;
    }

    public Teacher getTeacherById(int id) throws SQLException {
        String sql = "SELECT * FROM teachers WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
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
        }

        return null;
    }

    public Teacher getTeacherByUserId(int userId) throws SQLException {
        String sql = "SELECT * FROM teachers WHERE user_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
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
        }

        return null;
    }

    public List<Teacher> getAllTeachers() throws SQLException {
        List<Teacher> teachers = new ArrayList<>();
        String sql = "SELECT * FROM teachers";

        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
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
                teachers.add(teacher);
            }
        }

        return teachers;
    }

    public boolean updateTeacher(Teacher teacher) throws SQLException {
        String sql = "UPDATE teachers SET first_name = ?, last_name = ?, dob = ?, gender = ?, " +
                     "address = ?, phone = ?, hire_date = ?, qualification = ? WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, teacher.getFirstName());
            stmt.setString(2, teacher.getLastName());
            stmt.setDate(3, teacher.getDob());
            stmt.setString(4, teacher.getGender());
            stmt.setString(5, teacher.getAddress());
            stmt.setString(6, teacher.getPhone());
            stmt.setDate(7, teacher.getHireDate());
            stmt.setString(8, teacher.getQualification());
            stmt.setInt(9, teacher.getId());

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }

    public boolean deleteTeacher(int id) throws SQLException {
        String sql = "DELETE FROM teachers WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }

    public List<Integer> getTeacherCourses(int teacherId) throws SQLException {
        List<Integer> courseIds = new ArrayList<>();
        String sql = "SELECT id FROM courses WHERE teacher_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, teacherId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    courseIds.add(rs.getInt("id"));
                }
            }
        }

        return courseIds;
    }
}

