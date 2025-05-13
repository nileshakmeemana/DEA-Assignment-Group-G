/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.sms.dao;

import com.sms.model.Attendance;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Nilesh
 */
public class AttendanceDao {

    private Connection conn;

    public AttendanceDao(Connection conn) {
        this.conn = conn;
    }

    public void insertAttendance(Attendance attendance) throws Exception {
        String sql = "INSERT INTO attendance (student_id, course_id, date, status) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, attendance.getStudentId());
            ps.setInt(2, attendance.getCourseId());
            ps.setDate(3, (Date) attendance.getDate());
            ps.setString(4, attendance.getStatus());
            ps.executeUpdate();
        }
    }

    public Attendance getAttendanceById(int id) throws Exception {
        String sql = "SELECT * FROM attendance WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractAttendance(rs);
            }
        }
        return null;
    }

    public Attendance getAttendanceByStudentCourseDate(int studentId, int courseId, Date date) throws Exception {
        String sql = "SELECT * FROM attendance WHERE student_id = ? AND course_id = ? AND date = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ps.setInt(2, courseId);
            ps.setDate(3, date);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractAttendance(rs);
            }
        }
        return null;
    }

    public List<Attendance> getAttendanceByStudentId(int studentId) throws Exception {
        List<Attendance> list = new ArrayList<>();
        String sql = "SELECT * FROM attendance WHERE student_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractAttendance(rs));
            }
        }
        return list;
    }

    public List<Attendance> getAttendanceByCourseId(int courseId) throws Exception {
        List<Attendance> list = new ArrayList<>();
        String sql = "SELECT * FROM attendance WHERE course_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractAttendance(rs));
            }
        }
        return list;
    }

    public List<Attendance> getAttendanceByStudentAndCourse(int studentId, int courseId) throws Exception {
        List<Attendance> list = new ArrayList<>();
        String sql = "SELECT * FROM attendance WHERE student_id = ? AND course_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, studentId);
            ps.setInt(2, courseId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractAttendance(rs));
            }
        }
        return list;
    }

    public void updateAttendance(Attendance attendance) throws Exception {
        String sql = "UPDATE attendance SET student_id=?, course_id=?, date=?, status=? WHERE id=?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, attendance.getStudentId());
            ps.setInt(2, attendance.getCourseId());
            ps.setDate(3, (Date) attendance.getDate());
            ps.setString(4, attendance.getStatus());
            ps.setInt(5, attendance.getId());
            ps.executeUpdate();
        }
    }

    public void deleteAttendance(int id) throws Exception {
        String sql = "DELETE FROM attendance WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }

    public double getAttendancePercentage(int studentId, int courseId) throws Exception {
        String sqlTotal = "SELECT COUNT(*) FROM attendance WHERE student_id = ? AND course_id = ?";
        String sqlPresent = "SELECT COUNT(*) FROM attendance WHERE student_id = ? AND course_id = ? AND status = 'Present'";

        int total = 0, present = 0;

        try (PreparedStatement psTotal = conn.prepareStatement(sqlTotal)) {
            psTotal.setInt(1, studentId);
            psTotal.setInt(2, courseId);
            ResultSet rsTotal = psTotal.executeQuery();
            if (rsTotal.next()) {
                total = rsTotal.getInt(1);
            }
        }

        try (PreparedStatement psPresent = conn.prepareStatement(sqlPresent)) {
            psPresent.setInt(1, studentId);
            psPresent.setInt(2, courseId);
            ResultSet rsPresent = psPresent.executeQuery();
            if (rsPresent.next()) {
                present = rsPresent.getInt(1);
            }
        }

        if (total == 0) {
            return 0.0;
        }
        return (present * 100.0) / total;
    }

    private Attendance extractAttendance(ResultSet rs) throws SQLException {
        Attendance attendance = new Attendance();
        attendance.setId(rs.getInt("id"));
        attendance.setStudentId(rs.getInt("student_id"));
        attendance.setCourseId(rs.getInt("course_id"));
        attendance.setDate(rs.getDate("date"));
        attendance.setStatus(rs.getString("status"));
        return attendance;
    }
}
