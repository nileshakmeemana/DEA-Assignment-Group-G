/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.sms.controller;

import com.sms.dao.StudentDao;
import com.sms.dao.TeacherDao;
import com.sms.dao.UserDao;
import com.sms.model.Student;
import com.sms.model.Teacher;
import com.sms.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.sql.SQLException;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author Nilesh
 */
@WebServlet(urlPatterns = {
    "/profile",
    "/profile/update-student",
    "/profile/update-teacher",
    "/profile/change-password",
    "/profile/update-email"
})
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDao userDao;
    private StudentDao studentDao;
    private TeacherDao teacherDao;
    
    public void init() {
        userDao = new UserDao();
        studentDao = new StudentDao();
        teacherDao = new TeacherDao();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        try {
            showProfile(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database error occurred", e);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getServletPath();
        
        try {
            switch (action) {
                case "/profile/update-student":
                    updateStudentProfile(request, response);
                    break;
                case "/profile/update-teacher":
                    updateTeacherProfile(request, response);
                    break;
                case "/profile/change-password":
                    changePassword(request, response);
                    break;
                case "/profile/update-email":
                    updateEmail(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/profile");
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Database error occurred", e);
        }
    }
    
    private void showProfile(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Refresh user data from database
        user = userDao.getUserById(user.getId());
        session.setAttribute("user", user);
        
        // Get role-specific information
        switch (user.getRole()) {
            case "student":
                Student student = studentDao.getStudentByUserId(user.getId());
                request.setAttribute("student", student);
                break;
            case "teacher":
                Teacher teacher = teacherDao.getTeacherByUserId(user.getId());
                request.setAttribute("teacher", teacher);
                break;
            case "admin":
                // No additional information needed for admin
                break;
        }
        
        request.getRequestDispatcher("/profile.jsp").forward(request, response);
    }
    
    private void updateStudentProfile(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (!"student".equals(user.getRole())) {
            request.setAttribute("errorMessage", "Unauthorized access");
            showProfile(request, response);
            return;
        }
        
        Student student = studentDao.getStudentByUserId(user.getId());
        
        if (student != null) {
            // Update student information
            student.setFirstName(request.getParameter("firstName"));
            student.setLastName(request.getParameter("lastName"));
            
            String dobStr = request.getParameter("dob");
            if (dobStr != null && !dobStr.trim().isEmpty()) {
                student.setDob(Date.valueOf(dobStr));
            }
            
            student.setGender(request.getParameter("gender"));
            student.setAddress(request.getParameter("address"));
            student.setPhone(request.getParameter("phone"));
            
            boolean success = studentDao.updateStudent(student);
            
            if (success) {
                request.setAttribute("successMessage", "Profile updated successfully");
            } else {
                request.setAttribute("errorMessage", "Failed to update profile");
            }
        } else {
            request.setAttribute("errorMessage", "Student profile not found");
        }
        
        showProfile(request, response);
    }
    
    private void updateTeacherProfile(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (!"teacher".equals(user.getRole())) {
            request.setAttribute("errorMessage", "Unauthorized access");
            showProfile(request, response);
            return;
        }
        
        Teacher teacher = teacherDao.getTeacherByUserId(user.getId());
        
        if (teacher != null) {
            // Update teacher information
            teacher.setFirstName(request.getParameter("firstName"));
            teacher.setLastName(request.getParameter("lastName"));
            
            String dobStr = request.getParameter("dob");
            if (dobStr != null && !dobStr.trim().isEmpty()) {
                teacher.setDob(Date.valueOf(dobStr));
            }
            
            teacher.setGender(request.getParameter("gender"));
            teacher.setAddress(request.getParameter("address"));
            teacher.setPhone(request.getParameter("phone"));
            teacher.setQualification(request.getParameter("qualification"));
            
            boolean success = teacherDao.updateTeacher(teacher);
            
            if (success) {
                request.setAttribute("successMessage", "Profile updated successfully");
            } else {
                request.setAttribute("errorMessage", "Failed to update profile");
            }
        } else {
            request.setAttribute("errorMessage", "Teacher profile not found");
        }
        
        showProfile(request, response);
    }
    
    private void changePassword(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Validate input
        if (currentPassword == null || newPassword == null || confirmPassword == null ||
            currentPassword.trim().isEmpty() || newPassword.trim().isEmpty() || confirmPassword.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "All fields are required");
            showProfile(request, response);
            return;
        }
        
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "New passwords do not match");
            showProfile(request, response);
            return;
        }
        
        // Verify current password
        User dbUser = userDao.getUserById(user.getId());
        if (!BCrypt.checkpw(currentPassword, dbUser.getPassword())) {
            request.setAttribute("errorMessage", "Current password is incorrect");
            showProfile(request, response);
            return;
        }
        
        // Update password
        boolean success = userDao.updatePassword(user.getId(), newPassword);
        
        if (success) {
            request.setAttribute("successMessage", "Password changed successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to change password");
        }
        
        showProfile(request, response);
    }
    
    private void updateEmail(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        String newEmail = request.getParameter("newEmail");
        String password = request.getParameter("password");
        
        // Validate input
        if (newEmail == null || password == null ||
            newEmail.trim().isEmpty() || password.trim().isEmpty()) {
            
            request.setAttribute("errorMessage", "All fields are required");
            showProfile(request, response);
            return;
        }
        
        // Check if email already exists
        if (userDao.emailExists(newEmail) && !newEmail.equals(user.getEmail())) {
            request.setAttribute("errorMessage", "Email already in use");
            showProfile(request, response);
            return;
        }
        
        // Verify password
        User dbUser = userDao.getUserById(user.getId());
        if (!BCrypt.checkpw(password, dbUser.getPassword())) {
            request.setAttribute("errorMessage", "Password is incorrect");
            showProfile(request, response);
            return;
        }
        
        // Update email
        user.setEmail(newEmail);
        boolean success = userDao.updateUser(user);
        
        if (success) {
            session.setAttribute("user", user); // Update session with new email
            request.setAttribute("successMessage", "Email updated successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to update email");
        }
        
        showProfile(request, response);
    }
}