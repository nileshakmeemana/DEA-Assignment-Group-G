/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.sms.controller;

import com.sms.dao.CourseDao;
import com.sms.dao.StudentDao;
import com.sms.dao.TeacherDao;
import com.sms.dao.UserDao;
import com.sms.model.Course;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Nilesh
 */
@WebServlet(urlPatterns = {
    "/admin/dashboard",
    "/admin/manage-students",
    "/admin/manage-teachers",
    "/admin/manage-courses",
    "/admin/add-student",
    "/admin/edit-student",
    "/admin/delete-student",
    "/admin/add-teacher",
    "/admin/edit-teacher",
    "/admin/delete-teacher",
    "/admin/add-course",
    "/admin/edit-course",
    "/admin/delete-course",
    "/admin/assign-teacher"
})
public class AdminServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDao userDao;
    private StudentDao studentDao;
    private TeacherDao teacherDao;
    private CourseDao courseDao;
    
    public void init() {
        userDao = new UserDao();
        studentDao = new StudentDao();
        teacherDao = new TeacherDao();
        courseDao = new CourseDao();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in and is an admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || 
            !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getServletPath();
        
        try {
            switch (action) {
                case "/admin/dashboard":
                    showDashboard(request, response);
                    break;
                case "/admin/manage-students":
                    listStudents(request, response);
                    break;
                case "/admin/manage-teachers":
                    listTeachers(request, response);
                    break;
                case "/admin/manage-courses":
                    listCourses(request, response);
                    break;
                case "/admin/edit-student":
                    showEditStudentForm(request, response);
                    break;
                case "/admin/edit-teacher":
                    showEditTeacherForm(request, response);
                    break;
                case "/admin/edit-course":
                    showEditCourseForm(request, response);
                    break;
                case "/admin/assign-teacher":
                    showAssignTeacherForm(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Database error occurred", e);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in and is an admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || 
            !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getServletPath();
        
        try {
            switch (action) {
                case "/admin/add-student":
                    addStudent(request, response);
                    break;
                case "/admin/edit-student":
                    updateStudent(request, response);
                    break;
                case "/admin/delete-student":
                    deleteStudent(request, response);
                    break;
                case "/admin/add-teacher":
                    addTeacher(request, response);
                    break;
                case "/admin/edit-teacher":
                    updateTeacher(request, response);
                    break;
                case "/admin/delete-teacher":
                    deleteTeacher(request, response);
                    break;
                case "/admin/add-course":
                    addCourse(request, response);
                    break;
                case "/admin/edit-course":
                    updateCourse(request, response);
                    break;
                case "/admin/delete-course":
                    deleteCourse(request, response);
                    break;
                case "/admin/assign-teacher":
                    assignTeacher(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Database error occurred", e);
        }
    }
    
    private void showDashboard(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        // Get counts for dashboard
        List<Student> students = studentDao.getAllStudents();
        List<Teacher> teachers = teacherDao.getAllTeachers();
        List<Course> courses = courseDao.getAllCourses();
        
        request.setAttribute("studentCount", students.size());
        request.setAttribute("teacherCount", teachers.size());
        request.setAttribute("courseCount", courses.size());
        
        // Create some sample recent activities
        List<String> recentActivities = new ArrayList<>();
        recentActivities.add("Add new students, teachers and courses.");
        recentActivities.add("Edit students, teachers and courses.");
        recentActivities.add("Assign teachers for new courses");
        
        request.setAttribute("recentActivities", recentActivities);
        
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
    
    private void listStudents(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        List<Student> students = studentDao.getAllStudents();
        
        // Get user information for each student
        Map<Integer, User> userMap = new HashMap<>();
        for (Student student : students) {
            User user = userDao.getUserById(student.getUserId());
            if (user != null) {
                userMap.put(student.getId(), user);
            }
        }
        
        request.setAttribute("students", students);
        request.setAttribute("userMap", userMap);
        
        request.getRequestDispatcher("/admin/manage-students.jsp").forward(request, response);
    }
    
    private void listTeachers(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        List<Teacher> teachers = teacherDao.getAllTeachers();
        
        // Get user information for each teacher
        Map<Integer, User> userMap = new HashMap<>();
        for (Teacher teacher : teachers) {
            User user = userDao.getUserById(teacher.getUserId());
            if (user != null) {
                userMap.put(teacher.getId(), user);
            }
        }
        
        request.setAttribute("teachers", teachers);
        request.setAttribute("userMap", userMap);
        
        request.getRequestDispatcher("/admin/manage-teachers.jsp").forward(request, response);
    }
    
    private void listCourses(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        List<Course> courses = courseDao.getAllCourses();
        
        // Get teacher names for each course
        Map<Integer, String> teacherNames = new HashMap<>();
        for (Course course : courses) {
            if (course.getTeacherId() > 0) {
                Teacher teacher = teacherDao.getTeacherById(course.getTeacherId());
                if (teacher != null) {
                    teacherNames.put(course.getId(), teacher.getFirstName() + " " + teacher.getLastName());
                }
            }
        }
        
        // Get all teachers for the dropdown
        List<Teacher> teachers = teacherDao.getAllTeachers();
        
        request.setAttribute("courses", courses);
        request.setAttribute("teacherNames", teacherNames);
        request.setAttribute("teachers", teachers);
        
        request.getRequestDispatcher("/admin/manage-courses.jsp").forward(request, response);
    }
    
    private void showEditStudentForm(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int studentId = Integer.parseInt(request.getParameter("id"));
        Student student = studentDao.getStudentById(studentId);
        User user = userDao.getUserById(student.getUserId());
        
        request.setAttribute("student", student);
        request.setAttribute("user", user);
        
        request.getRequestDispatcher("/admin/edit-student.jsp").forward(request, response);
    }
    
    private void showEditTeacherForm(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int teacherId = Integer.parseInt(request.getParameter("id"));
        Teacher teacher = teacherDao.getTeacherById(teacherId);
        User user = userDao.getUserById(teacher.getUserId());
        
        request.setAttribute("teacher", teacher);
        request.setAttribute("user", user);
        
        request.getRequestDispatcher("/admin/edit-teacher.jsp").forward(request, response);
    }
    
    private void showEditCourseForm(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int courseId = Integer.parseInt(request.getParameter("id"));
        Course course = courseDao.getCourseById(courseId);
        List<Teacher> teachers = teacherDao.getAllTeachers();
        
        request.setAttribute("course", course);
        request.setAttribute("teachers", teachers);
        
        request.getRequestDispatcher("/admin/edit-course.jsp").forward(request, response);
    }
    
    private void showAssignTeacherForm(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int courseId = Integer.parseInt(request.getParameter("id"));
        Course course = courseDao.getCourseById(courseId);
        List<Teacher> teachers = teacherDao.getAllTeachers();
        
        request.setAttribute("course", course);
        request.setAttribute("teachers", teachers);
        
        request.getRequestDispatcher("/admin/assign-teacher.jsp").forward(request, response);
    }
    
    private void addStudent(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        // Create user first
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        
        User user = new User(username, password, email, "student");
        int userId = userDao.insertUser(user);
        
        if (userId > 0) {
            // Then create student
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
            
            Date enrollmentDate = new Date(System.currentTimeMillis());
            
            Student student = new Student(userId, firstName, lastName, dob, gender, address, phone, enrollmentDate);
            studentDao.insertStudent(student);
            
            request.setAttribute("successMessage", "Student added successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to add student");
        }
        
        listStudents(request, response);
    }
    
    private void updateStudent(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int studentId = Integer.parseInt(request.getParameter("id"));
        Student student = studentDao.getStudentById(studentId);
        
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
        
        // Update user information if needed
        String email = request.getParameter("email");
        if (email != null && !email.trim().isEmpty()) {
            User user = userDao.getUserById(student.getUserId());
            user.setEmail(email);
            userDao.updateUser(user);
        }
        
        if (success) {
            request.setAttribute("successMessage", "Student updated successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to update student");
        }
        
        listStudents(request, response);
    }
    
    private void deleteStudent(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int studentId = Integer.parseInt(request.getParameter("id"));
        Student student = studentDao.getStudentById(studentId);
        
        if (student != null) {
            // Delete the user (which will cascade delete the student due to foreign key)
            boolean success = userDao.deleteUser(student.getUserId());
            
            if (success) {
                request.setAttribute("successMessage", "Student deleted successfully");
            } else {
                request.setAttribute("errorMessage", "Failed to delete student");
            }
        } else {
            request.setAttribute("errorMessage", "Student not found");
        }
        
        listStudents(request, response);
    }
    
    private void addTeacher(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        // Create user first
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        
        User user = new User(username, password, email, "teacher");
        int userId = userDao.insertUser(user);
        
        if (userId > 0) {
            // Then create teacher
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String dobStr = request.getParameter("dob");
            String gender = request.getParameter("gender");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            String qualification = request.getParameter("qualification");
            
            Date dob = null;
            if (dobStr != null && !dobStr.trim().isEmpty()) {
                dob = Date.valueOf(dobStr);
            }
            
            Date hireDate = new Date(System.currentTimeMillis());
            
            Teacher teacher = new Teacher(userId, firstName, lastName, dob, gender, address, phone, hireDate, qualification);
            teacherDao.insertTeacher(teacher);
            
            request.setAttribute("successMessage", "Teacher added successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to add teacher");
        }
        
        listTeachers(request, response);
    }
    
    private void updateTeacher(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int teacherId = Integer.parseInt(request.getParameter("id"));
        Teacher teacher = teacherDao.getTeacherById(teacherId);
        
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
        
        // Update user information if needed
        String email = request.getParameter("email");
        if (email != null && !email.trim().isEmpty()) {
            User user = userDao.getUserById(teacher.getUserId());
            user.setEmail(email);
            userDao.updateUser(user);
        }
        
        if (success) {
            request.setAttribute("successMessage", "Teacher updated successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to update teacher");
        }
        
        listTeachers(request, response);
    }
    
    private void deleteTeacher(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int teacherId = Integer.parseInt(request.getParameter("id"));
        Teacher teacher = teacherDao.getTeacherById(teacherId);
        
        if (teacher != null) {
            // Delete the user (which will cascade delete the teacher due to foreign key)
            boolean success = userDao.deleteUser(teacher.getUserId());
            
            if (success) {
                request.setAttribute("successMessage", "Teacher deleted successfully");
            } else {
                request.setAttribute("errorMessage", "Failed to delete teacher");
            }
        } else {
            request.setAttribute("errorMessage", "Teacher not found");
        }
        
        listTeachers(request, response);
    }
    
    private void addCourse(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        String code = request.getParameter("code");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        int creditHours = Integer.parseInt(request.getParameter("creditHours"));
        
        String teacherIdStr = request.getParameter("teacherId");
        int teacherId = 0;
        if (teacherIdStr != null && !teacherIdStr.trim().isEmpty()) {
            teacherId = Integer.parseInt(teacherIdStr);
        }
        
        Course course = new Course(code, name, description, creditHours, teacherId);
        boolean success = courseDao.insertCourse(course);
        
        if (success) {
            request.setAttribute("successMessage", "Course added successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to add course");
        }
        
        listCourses(request, response);
    }
    
    private void updateCourse(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int courseId = Integer.parseInt(request.getParameter("id"));
        Course course = courseDao.getCourseById(courseId);
        
        course.setCode(request.getParameter("code"));
        course.setName(request.getParameter("name"));
        course.setDescription(request.getParameter("description"));
        course.setCreditHours(Integer.parseInt(request.getParameter("creditHours")));
        
        String teacherIdStr = request.getParameter("teacherId");
        if (teacherIdStr != null && !teacherIdStr.trim().isEmpty()) {
            course.setTeacherId(Integer.parseInt(teacherIdStr));
        } else {
            course.setTeacherId(0);
        }
        
        boolean success = courseDao.updateCourse(course);
        
        if (success) {
            request.setAttribute("successMessage", "Course updated successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to update course");
        }
        
        listCourses(request, response);
    }
    
    private void deleteCourse(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int courseId = Integer.parseInt(request.getParameter("id"));
        boolean success = courseDao.deleteCourse(courseId);
        
        if (success) {
            request.setAttribute("successMessage", "Course deleted successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to delete course");
        }
        
        listCourses(request, response);
    }
    
    private void assignTeacher(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        String teacherIdStr = request.getParameter("teacherId");
        
        Course course = courseDao.getCourseById(courseId);
        
        if (teacherIdStr != null && !teacherIdStr.trim().isEmpty()) {
            int teacherId = Integer.parseInt(teacherIdStr);
            course.setTeacherId(teacherId);
        } else {
            course.setTeacherId(0);
        }
        
        boolean success = courseDao.updateCourse(course);
        
        if (success) {
            request.setAttribute("successMessage", "Teacher assigned successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to assign teacher");
        }
        
        listCourses(request, response);
    }
}