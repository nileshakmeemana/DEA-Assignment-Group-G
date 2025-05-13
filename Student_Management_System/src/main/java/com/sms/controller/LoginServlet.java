/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.sms.controller;

import com.sms.dao.UserDao;
import com.sms.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;

/**
 *
 * @author Nilesh
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDao userDao;
    
    public void init() {
        userDao = new UserDao();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            redirectBasedOnRole(request, response, user.getRole());
        } else {
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        try {
            User user = userDao.validateUser(username, password);
            
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getId());
                session.setAttribute("username", user.getUsername());
                session.setAttribute("role", user.getRole());
                
                redirectBasedOnRole(request, response, user.getRole());
            } else {
                request.setAttribute("errorMessage", "Invalid username or password");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            throw new ServletException("Database error occurred", e);
        }
    }
    
    private void redirectBasedOnRole(HttpServletRequest request, HttpServletResponse response, String role) throws IOException {
        switch (role) {
            case "admin":
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                break;
            case "teacher":
                response.sendRedirect(request.getContextPath() + "/teacher/dashboard");
                break;
            case "student":
                response.sendRedirect(request.getContextPath() + "/student/dashboard");
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/login");
                break;
        }
    }
}
