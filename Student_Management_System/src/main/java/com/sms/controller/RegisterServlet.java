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
import java.sql.Date;
import java.sql.SQLException;

/**
 *
 * @author Nilesh
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDao userDao;
    private StudentDao studentDao;
    private TeacherDao teacherDao;

    @Override
    public void init() {
        userDao = new UserDao();
        studentDao = new StudentDao();
        teacherDao = new TeacherDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        String role = request.getParameter("role");

        // Basic validation
        if (username == null || username.trim().isEmpty() ||
            password == null || password.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            role == null || role.trim().isEmpty()) {

            request.setAttribute("errorMessage", "All fields are required");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        try {
            // Check if username or email already exists
            if (userDao.usernameExists(username)) {
                request.setAttribute("errorMessage", "Username already exists");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
                return;
            }

            if (userDao.emailExists(email)) {
                request.setAttribute("errorMessage", "Email already exists");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
                return;
            }

            // Create and insert user
            User user = new User(username, password, email, role);
            int userId = userDao.insertUser(user);

            if (userId > 0) {
                // Based on role, collect and store additional information
                String firstName = request.getParameter("firstName");
                String lastName = request.getParameter("lastName");
                String dobStr = request.getParameter("dob");
                String gender = request.getParameter("gender");
                String address = request.getParameter("address");
                String phone = request.getParameter("phone");
                Date dob = null;

                if (dobStr != null && !dobStr.trim().isEmpty()) {
                    dob = Date.valueOf(dobStr);
                }

                if ("student".equals(role)) {
                    Date enrollmentDate = new Date(System.currentTimeMillis());
                    Student student = new Student(userId, firstName, lastName, dob, gender, address, phone, enrollmentDate);
                    studentDao.insertStudent(student);

                } else if ("teacher".equals(role)) {
                    String qualification = request.getParameter("qualification");
                    Date hireDate = new Date(System.currentTimeMillis());
                    Teacher teacher = new Teacher(userId, firstName, lastName, dob, gender, address, phone, hireDate, qualification);
                    teacherDao.insertTeacher(teacher);
                }

                request.setAttribute("successMessage", "Registration successful. Please login.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);

            } else {
                request.setAttribute("errorMessage", "Registration failed. Please try again.");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            throw new ServletException("Database error occurred", e);
        }
    }
}
