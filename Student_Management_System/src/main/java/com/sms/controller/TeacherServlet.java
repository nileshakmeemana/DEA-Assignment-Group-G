/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.sms.controller;

import com.sms.dao.AttendanceDao;
import com.sms.dao.CourseDao;
import com.sms.dao.GradeDao;
import com.sms.dao.StudentDao;
import com.sms.dao.TeacherDao;
import com.sms.dao.UserDao;
import com.sms.model.Attendance;
import com.sms.model.Course;
import com.sms.model.Grade;
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
import java.math.BigDecimal;
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
    "/teacher/dashboard",
    "/teacher/manage-grades",
    "/teacher/manage-attendance",
    "/teacher/update-grade",
    "/teacher/update-attendance",
    "/teacher/take-attendance"
})
public class TeacherServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDao userDao;
    private TeacherDao teacherDao;
    private CourseDao courseDao;
    private StudentDao studentDao;
    private GradeDao gradeDao;
    private AttendanceDao attendanceDao;
    
    public void init() {
        userDao = new UserDao();
        teacherDao = new TeacherDao();
        courseDao = new CourseDao();
        studentDao = new StudentDao();
        gradeDao = new GradeDao();
        attendanceDao = new AttendanceDao();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in and is a teacher
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || 
            !"teacher".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getServletPath();
        
        try {
            switch (action) {
                case "/teacher/dashboard":
                    showDashboard(request, response);
                    break;
                case "/teacher/manage-grades":
                    manageGrades(request, response);
                    break;
                case "/teacher/manage-attendance":
                    manageAttendance(request, response);
                    break;
                case "/teacher/take-attendance":
                    showTakeAttendanceForm(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/teacher/dashboard");
                    break;
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in TeacherServlet doGet: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Database error occurred", e);
        } catch (Exception e) {
            System.out.println("General Error in TeacherServlet doGet: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("An error occurred", e);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in and is a teacher
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || 
            !"teacher".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getServletPath();
        
        try {
            switch (action) {
                case "/teacher/update-grade":
                    updateGrade(request, response);
                    break;
                case "/teacher/update-attendance":
                    updateAttendance(request, response);
                    break;
                case "/teacher/take-attendance":
                    takeAttendance(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/teacher/dashboard");
                    break;
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in TeacherServlet doPost: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Database error occurred", e);
        } catch (Exception e) {
            System.out.println("General Error in TeacherServlet doPost: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("An error occurred", e);
        }
    }
    
    private void showDashboard(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Get teacher information
        Teacher teacher = teacherDao.getTeacherByUserId(user.getId());
        
        if (teacher != null) {
            // Get courses taught by the teacher
            List<Course> teacherCourses = courseDao.getCoursesByTeacherId(teacher.getId());
            
            // Get enrollment counts for each course
            Map<Integer, Integer> enrollmentCounts = new HashMap<>();
            for (Course course : teacherCourses) {
                int count = courseDao.getStudentCountForCourse(course.getId());
                enrollmentCounts.put(course.getId(), count);
            }
            
            // Create some sample recent activities
            List<String> recentActivities = new ArrayList<>();
            recentActivities.add("Review recent grade updates.");
            recentActivities.add("Check recent attendance records.");
            
            request.setAttribute("teacher", teacher);
            request.setAttribute("user", user);
            request.setAttribute("teacherCourses", teacherCourses);
            request.setAttribute("enrollmentCounts", enrollmentCounts);
            request.setAttribute("recentActivities", recentActivities);
            
            request.getRequestDispatcher("/teacher/dashboard.jsp").forward(request, response);
        } else {
            // Handle case where teacher profile is not found
            request.setAttribute("errorMessage", "Teacher profile not found");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    
    private void manageGrades(HttpServletRequest request, HttpServletResponse response) 
        throws SQLException, ServletException, IOException {
    
    HttpSession session = request.getSession();
    User user = (User) session.getAttribute("user");
    
    // Get teacher information
    Teacher teacher = teacherDao.getTeacherByUserId(user.getId());
    
    if (teacher != null) {
        // Get courses taught by the teacher
        List<Course> teacherCourses = courseDao.getCoursesByTeacherId(teacher.getId());
        
        // Check if a specific course is selected
        String courseIdStr = request.getParameter("courseId");
        if (courseIdStr != null && !courseIdStr.trim().isEmpty()) {
            int courseId = Integer.parseInt(courseIdStr);
            
            // Verify that the teacher teaches this course
            boolean courseFound = false;
            for (Course course : teacherCourses) {
                if (course.getId() == courseId) {
                    courseFound = true;
                    break;
                }
            }
            
            if (courseFound) {
                Course selectedCourse = courseDao.getCourseById(courseId);
                
                // Get all students enrolled in the course
                List<Student> enrolledStudents = new ArrayList<>();
                
                // Get student IDs enrolled in the course from student_courses table
                List<Integer> enrolledStudentIds = studentDao.getStudentsByCourseId(courseId);
                
                // Get student details for each enrolled student ID
                for (int studentId : enrolledStudentIds) {
                    Student student = studentDao.getStudentById(studentId);
                    if (student != null) {
                        enrolledStudents.add(student);
                    }
                }
                
                // Get grades for each student
                Map<Integer, Grade> gradeMap = new HashMap<>();
                Map<Integer, String> academicStatusMap = new HashMap<>();
                Map<Integer, BigDecimal> earnedCreditsMap = new HashMap<>();
                
                for (Student student : enrolledStudents) {
                    Grade grade = gradeDao.getGradeByStudentAndCourse(student.getId(), courseId);
                    gradeMap.put(student.getId(), grade);
                    
                    if (grade != null) {
                        academicStatusMap.put(student.getId(), grade.getAcademicStatus());
                        earnedCreditsMap.put(student.getId(), 
                            grade.calculateEarnedCredits(selectedCourse.getCreditHours()));
                    }
                }
                
                request.setAttribute("selectedCourse", selectedCourse);
                request.setAttribute("enrolledStudents", enrolledStudents);
                request.setAttribute("gradeMap", gradeMap);
                request.setAttribute("academicStatusMap", academicStatusMap);
                request.setAttribute("earnedCreditsMap", earnedCreditsMap);
            }
        }
        
        request.setAttribute("teacher", teacher);
        request.setAttribute("teacherCourses", teacherCourses);
        
        request.getRequestDispatcher("/teacher/manage-grades.jsp").forward(request, response);
    } else {
        // Handle case where teacher profile is not found
        request.setAttribute("errorMessage", "Teacher profile not found");
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
}

    
    private void manageAttendance(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Get teacher information
        Teacher teacher = teacherDao.getTeacherByUserId(user.getId());
        
        if (teacher != null) {
            // Get courses taught by the teacher
            List<Course> teacherCourses = courseDao.getCoursesByTeacherId(teacher.getId());
            
            // Check if a specific course is selected
            String courseIdStr = request.getParameter("courseId");
            if (courseIdStr != null && !courseIdStr.trim().isEmpty()) {
                int courseId = Integer.parseInt(courseIdStr);
                
                // Verify that the teacher teaches this course
                boolean courseFound = false;
                for (Course course : teacherCourses) {
                    if (course.getId() == courseId) {
                        courseFound = true;
                        break;
                    }
                }
                
                if (courseFound) {
                    Course selectedCourse = courseDao.getCourseById(courseId);
                    
                    // Get all students enrolled in the course
                    List<Student> enrolledStudents = new ArrayList<>();
                    
                    // Get student IDs enrolled in the course from student_courses table
                    List<Integer> enrolledStudentIds = studentDao.getStudentsByCourseId(courseId);
                    
                    // Get student details for each enrolled student ID
                    for (int studentId : enrolledStudentIds) {
                        Student student = studentDao.getStudentById(studentId);
                        if (student != null) {
                            enrolledStudents.add(student);
                        }
                    }
                    
                    // Get attendance records for the course
                    List<Attendance> attendanceRecords = attendanceDao.getAttendanceByCourseId(courseId);
                    
                    // Group attendance records by date
                    Map<Date, Map<Integer, String>> attendanceByDate = new HashMap<>();
                    for (Attendance attendance : attendanceRecords) {
                        if (!attendanceByDate.containsKey(attendance.getDate())) {
                            attendanceByDate.put(attendance.getDate(), new HashMap<>());
                        }
                        attendanceByDate.get(attendance.getDate()).put(attendance.getStudentId(), attendance.getStatus());
                    }
                    
                    request.setAttribute("selectedCourse", selectedCourse);
                    request.setAttribute("enrolledStudents", enrolledStudents);
                    request.setAttribute("attendanceByDate", attendanceByDate);
                }
            }
            
            request.setAttribute("teacher", teacher);
            request.setAttribute("teacherCourses", teacherCourses);
            
            request.getRequestDispatcher("/teacher/manage-attendance.jsp").forward(request, response);
        } else {
            // Handle case where teacher profile is not found
            request.setAttribute("errorMessage", "Teacher profile not found");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    
    private void showTakeAttendanceForm(HttpServletRequest request, HttpServletResponse response) 
        throws SQLException, ServletException, IOException {
    
    try {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Get teacher information
        Teacher teacher = teacherDao.getTeacherByUserId(user.getId());
        
        if (teacher != null) {
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            
            // Verify that the teacher teaches this course
            List<Course> teacherCourses = courseDao.getCoursesByTeacherId(teacher.getId());
            boolean courseFound = false;
            for (Course course : teacherCourses) {
                if (course.getId() == courseId) {
                    courseFound = true;
                    break;
                }
            }
            
            if (courseFound) {
                Course selectedCourse = courseDao.getCourseById(courseId);
                
                // Get all students enrolled in the course
                List<Student> enrolledStudents = new ArrayList<>();
                
                // Get student IDs enrolled in the course from student_courses table
                List<Integer> enrolledStudentIds = studentDao.getStudentsByCourseId(courseId);
                
                // Get student details for each enrolled student ID
                for (int studentId : enrolledStudentIds) {
                    Student student = studentDao.getStudentById(studentId);
                    if (student != null) {
                        enrolledStudents.add(student);
                    }
                }
                
                // Check if a date parameter was provided
                String dateStr = request.getParameter("date");
                Date selectedDate;
                if (dateStr != null && !dateStr.isEmpty()) {
                    selectedDate = Date.valueOf(dateStr);
                } else {
                    // Default to today's date
                    selectedDate = new Date(System.currentTimeMillis());
                }
                
                // Check if attendance records already exist for this date
                Map<Integer, String> existingAttendance = new HashMap<>();
                for (Student student : enrolledStudents) {
                    Attendance attendance = attendanceDao.getAttendanceByStudentCourseDate(student.getId(), courseId, selectedDate);
                    if (attendance != null) {
                        existingAttendance.put(student.getId(), attendance.getStatus());
                    }
                }
                
                request.setAttribute("selectedCourse", selectedCourse);
                request.setAttribute("enrolledStudents", enrolledStudents);
                request.setAttribute("selectedDate", selectedDate);
                request.setAttribute("existingAttendance", existingAttendance);
                
                request.getRequestDispatcher("/teacher/take-attendance.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/teacher/manage-attendance");
            }
        } else {
            // Handle case where teacher profile is not found
            request.setAttribute("errorMessage", "Teacher profile not found");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    } catch (Exception e) {
        System.out.println("Error in showTakeAttendanceForm: " + e.getMessage());
        e.printStackTrace();
        request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
}


    
    private void updateGrade(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int studentId = Integer.parseInt(request.getParameter("studentId"));
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        
        String assignmentScoreStr = request.getParameter("assignmentScore");
        String midtermScoreStr = request.getParameter("midtermScore");
        String finalScoreStr = request.getParameter("finalScore");
        
        BigDecimal assignmentScore = null;
        BigDecimal midtermScore = null;
        BigDecimal finalScore = null;
        
        if (assignmentScoreStr != null && !assignmentScoreStr.trim().isEmpty()) {
            assignmentScore = new BigDecimal(assignmentScoreStr);
        }
        
        if (midtermScoreStr != null && !midtermScoreStr.trim().isEmpty()) {
            midtermScore = new BigDecimal(midtermScoreStr);
        }
        
        if (finalScoreStr != null && !finalScoreStr.trim().isEmpty()) {
            finalScore = new BigDecimal(finalScoreStr);
        }
        
        // Check if grade already exists
        Grade grade = gradeDao.getGradeByStudentAndCourse(studentId, courseId);
        
        boolean success;
        if (grade != null) {
            // Update existing grade
            grade.setAssignmentScore(assignmentScore);
            grade.setMidtermScore(midtermScore);
            grade.setFinalScore(finalScore);
            success = gradeDao.updateGrade(grade);
        } else {
            // Create new grade
            grade = new Grade(studentId, courseId, assignmentScore, midtermScore, finalScore);
            success = gradeDao.insertGrade(grade);
        }
        
        if (success) {
            request.setAttribute("successMessage", "Grade updated successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to update grade");
        }
        
        // Redirect back to manage grades page
        response.sendRedirect(request.getContextPath() + "/teacher/manage-grades?courseId=" + courseId);
    }
    
    private void updateAttendance(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int studentId = Integer.parseInt(request.getParameter("studentId"));
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        Date date = Date.valueOf(request.getParameter("date"));
        String status = request.getParameter("status");
        
        // Check if attendance record already exists
        Attendance attendance = attendanceDao.getAttendanceByStudentCourseDate(studentId, courseId, date);
        
        boolean success;
        if (attendance != null) {
            // Update existing attendance
            attendance.setStatus(status);
            success = attendanceDao.updateAttendance(attendance);
        } else {
            // Create new attendance record
            attendance = new Attendance(studentId, courseId, date, status);
            success = attendanceDao.insertAttendance(attendance);
        }
        
        if (success) {
            request.setAttribute("successMessage", "Attendance updated successfully");
        } else {
            request.setAttribute("errorMessage", "Failed to update attendance");
        }
        
        // Redirect back to manage attendance page
        response.sendRedirect(request.getContextPath() + "/teacher/manage-attendance?courseId=" + courseId);
    }
    
    private void takeAttendance(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        Date date = Date.valueOf(request.getParameter("date"));
        
        String[] studentIds = request.getParameterValues("studentId");
        
        if (studentIds != null) {
            for (String studentIdStr : studentIds) {
                int studentId = Integer.parseInt(studentIdStr);
                String status = request.getParameter("status_" + studentId);
                
                if (status != null && !status.trim().isEmpty()) {
                    // Check if attendance record already exists
                    Attendance attendance = attendanceDao.getAttendanceByStudentCourseDate(studentId, courseId, date);
                    
                    if (attendance != null) {
                        // Update existing attendance
                        attendance.setStatus(status);
                        attendanceDao.updateAttendance(attendance);
                    } else {
                        // Create new attendance record
                        attendance = new Attendance(studentId, courseId, date, status);
                        attendanceDao.insertAttendance(attendance);
                    }
                }
            }
            
            request.setAttribute("successMessage", "Attendance recorded successfully");
        } else {
            request.setAttribute("errorMessage", "No students selected");
        }
        
        // Redirect back to manage attendance page
        response.sendRedirect(request.getContextPath() + "/teacher/manage-attendance?courseId=" + courseId);
    }
}