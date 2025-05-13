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
import java.math.RoundingMode;
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
    "/student/dashboard",
    "/student/view-courses",
    "/student/view-grades",
    "/student/view-attendance",
    "/student/enroll-course",
    "/student/drop-course",
    "/student/course-registration"
})
public class StudentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDao userDao;
    private StudentDao studentDao;
    private CourseDao courseDao;
    private GradeDao gradeDao;
    private AttendanceDao attendanceDao;
    private TeacherDao teacherDao;
    
    public void init() {
        userDao = new UserDao();
        studentDao = new StudentDao();
        courseDao = new CourseDao();
        gradeDao = new GradeDao();
        attendanceDao = new AttendanceDao();
        teacherDao = new TeacherDao();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in and is a student
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || 
            !"student".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getServletPath();
        System.out.println("StudentServlet doGet action: " + action);
        
        try {
            switch (action) {
                case "/student/dashboard":
                    showDashboard(request, response);
                    break;
                case "/student/view-courses":
                    viewCourses(request, response);
                    break;
                case "/student/view-grades":
                    viewGrades(request, response);
                    break;
                case "/student/view-attendance":
                    viewAttendance(request, response);
                    break;
                case "/student/course-registration":
                    showCourseRegistration(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/student/dashboard");
                    break;
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in StudentServlet doGet: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Database error occurred", e);
        } catch (Exception e) {
            System.out.println("General Error in StudentServlet doGet: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("An error occurred", e);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is logged in and is a student
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || 
            !"student".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String action = request.getServletPath();
        System.out.println("StudentServlet doPost action: " + action);
        
        try {
            switch (action) {
                case "/student/enroll-course":
                    enrollCourse(request, response);
                    break;
                case "/student/drop-course":
                    dropCourse(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/student/dashboard");
                    break;
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in StudentServlet doPost: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Database error occurred", e);
        } catch (Exception e) {
            System.out.println("General Error in StudentServlet doPost: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("An error occurred", e);
        }
    }
    
    private void showDashboard(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    try {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            System.out.println("User object is null in session");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        System.out.println("Student dashboard for user ID: " + user.getId());
        
        // Get student information
        Student student = studentDao.getStudentByUserId(user.getId());
        
        if (student != null) {
            System.out.println("Found student: " + student.getFirstName() + " " + student.getLastName());
            
            // Get enrolled courses
            List<Course> enrolledCourses = new ArrayList<>();
            try {
                enrolledCourses = courseDao.getCoursesByStudentId(student.getId());
                System.out.println("Enrolled courses count: " + enrolledCourses.size());
            } catch (Exception e) {
                System.out.println("Error getting enrolled courses: " + e.getMessage());
                e.printStackTrace();
            }
            
            // Get teacher names for courses
            Map<Integer, String> teacherNames = new HashMap<>();
            for (Course course : enrolledCourses) {
                if (course.getTeacherId() > 0) {
                    try {
                        Teacher teacher = teacherDao.getTeacherById(course.getTeacherId());
                        if (teacher != null) {
                            teacherNames.put(course.getTeacherId(), teacher.getFirstName() + " " + teacher.getLastName());
                        }
                    } catch (Exception e) {
                        System.out.println("Error getting teacher for course: " + e.getMessage());
                    }
                }
            }
            
            // Get all grades for the student
            List<Grade> grades = gradeDao.getGradesByStudentId(student.getId());
            
            // Get course information for each grade
            Map<Integer, Course> courseMap = new HashMap<>();
            for (Grade grade : grades) {
                Course course = courseDao.getCourseById(grade.getCourseId());
                if (course != null) {
                    courseMap.put(grade.getCourseId(), course);
                }
            }
            
            // Calculate GPA and total earned credits
            BigDecimal gpa = calculateGPA(grades, courseMap);
            BigDecimal totalEarnedCredits = calculateTotalEarnedCredits(grades, courseMap);
            String academicStatus = getOverallAcademicStatus(gpa);
            
            // Get upcoming deadlines (sample data)
            List<Map<String, String>> deadlines = new ArrayList<>();
            Map<String, String> deadline1 = new HashMap<>();
            deadline1.put("title", "Assignment 1");
            deadline1.put("description", "Complete the first programming assignment");
            deadline1.put("dueDate", "2025-05-15");
            deadlines.add(deadline1);
            
            Map<String, String> deadline2 = new HashMap<>();
            deadline2.put("title", "Midterm Exam");
            deadline2.put("description", "Prepare for the midterm examination");
            deadline2.put("dueDate", "2025-05-20");
            deadlines.add(deadline2);
            
            request.setAttribute("student", student);
            request.setAttribute("user", user);
            request.setAttribute("enrolledCourses", enrolledCourses);
            request.setAttribute("teacherNames", teacherNames);
            request.setAttribute("deadlines", deadlines);
            request.setAttribute("gpa", gpa);
            request.setAttribute("totalEarnedCredits", totalEarnedCredits);
            request.setAttribute("academicStatus", academicStatus);
            
            System.out.println("Forwarding to student dashboard JSP");
            request.getRequestDispatcher("/student/dashboard.jsp").forward(request, response);
        } else {
            // Handle case where student profile is not found
            System.out.println("Student profile not found for user ID: " + user.getId());
            request.setAttribute("errorMessage", "Student profile not found");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    } catch (Exception e) {
        System.out.println("Error in showDashboard: " + e.getMessage());
        e.printStackTrace();
        request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
}

    
    private void viewCourses(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        System.out.println("View courses for user ID: " + user.getId());
        
        // Get student information
        Student student = studentDao.getStudentByUserId(user.getId());
        
        if (student != null) {
            // Get enrolled courses
            List<Course> enrolledCourses = courseDao.getCoursesByStudentId(student.getId());
            System.out.println("Enrolled courses count: " + enrolledCourses.size());
            
            // Get teacher names for courses
            Map<Integer, String> teacherNames = new HashMap<>();
            for (Course course : enrolledCourses) {
                if (course.getTeacherId() > 0) {
                    Teacher teacher = teacherDao.getTeacherById(course.getTeacherId());
                    if (teacher != null) {
                        teacherNames.put(course.getTeacherId(), teacher.getFirstName() + " " + teacher.getLastName());
                    }
                }
            }
            
            request.setAttribute("student", student);
            request.setAttribute("enrolledCourses", enrolledCourses);
            request.setAttribute("teacherNames", teacherNames);
            
            request.getRequestDispatcher("/student/view-courses.jsp").forward(request, response);
        } else {
            // Handle case where student profile is not found
            request.setAttribute("errorMessage", "Student profile not found");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    
    private void viewGrades(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {
    
    try {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        System.out.println("View grades for user ID: " + user.getId());
        
        // Get student information
        Student student = studentDao.getStudentByUserId(user.getId());
        
        if (student != null) {
            // Get all grades for the student
            List<Grade> grades = gradeDao.getGradesByStudentId(student.getId());
            System.out.println("Grades count: " + grades.size());
            
            // Get course information for each grade
            Map<Integer, Course> courseMap = new HashMap<>();
            for (Grade grade : grades) {
                Course course = courseDao.getCourseById(grade.getCourseId());
                if (course != null) {
                    courseMap.put(grade.getCourseId(), course);
                }
            }
            
            // Get all enrolled courses (including those without grades yet)
            List<Course> enrolledCourses = courseDao.getCoursesByStudentId(student.getId());
            
            // Create a map of course IDs to grades for easy lookup
            Map<Integer, Grade> courseGradeMap = new HashMap<>();
            for (Grade grade : grades) {
                courseGradeMap.put(grade.getCourseId(), grade);
            }
            
            // Calculate earned credits for each course
            Map<Integer, BigDecimal> earnedCreditsMap = new HashMap<>();
            for (Grade grade : grades) {
                if (courseMap.containsKey(grade.getCourseId())) {
                    Course course = courseMap.get(grade.getCourseId());
                    earnedCreditsMap.put(grade.getCourseId(), 
                        grade.calculateEarnedCredits(course.getCreditHours()));
                }
            }
            
            // Calculate GPA and total earned credits
            BigDecimal gpa = calculateGPA(grades, courseMap);
            BigDecimal totalEarnedCredits = calculateTotalEarnedCredits(grades, courseMap);
            String academicStatus = getOverallAcademicStatus(gpa);
            
            request.setAttribute("student", student);
            request.setAttribute("grades", grades);
            request.setAttribute("courseMap", courseMap);
            request.setAttribute("enrolledCourses", enrolledCourses);
            request.setAttribute("courseGradeMap", courseGradeMap);
            request.setAttribute("earnedCreditsMap", earnedCreditsMap);
            request.setAttribute("gpa", gpa);
            request.setAttribute("totalEarnedCredits", totalEarnedCredits);
            request.setAttribute("academicStatus", academicStatus);
            
            request.getRequestDispatcher("/student/view-grades.jsp").forward(request, response);
        } else {
            // Handle case where student profile is not found
            request.setAttribute("errorMessage", "Student profile not found");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    } catch (Exception e) {
        System.out.println("Error in viewGrades: " + e.getMessage());
        e.printStackTrace();
        request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
        request.getRequestDispatcher("/error.jsp").forward(request, response);
    }
}

    
    private void viewAttendance(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        System.out.println("View attendance for user ID: " + user.getId());
        
        // Get student information
        Student student = studentDao.getStudentByUserId(user.getId());
        
        if (student != null) {
            // Get all attendance records for the student
            List<Attendance> attendanceRecords = attendanceDao.getAttendanceByStudentId(student.getId());
            System.out.println("Attendance records count: " + attendanceRecords.size());
            
            // Get course information for each attendance record
            Map<Integer, Course> courseMap = new HashMap<>();
            for (Attendance attendance : attendanceRecords) {
                Course course = courseDao.getCourseById(attendance.getCourseId());
                if (course != null) {
                    courseMap.put(attendance.getCourseId(), course);
                }
            }
            
            // Calculate attendance percentages for each course
            Map<Integer, Double> attendancePercentages = new HashMap<>();
            List<Course> enrolledCourses = courseDao.getCoursesByStudentId(student.getId());
            
            for (Course course : enrolledCourses) {
                double percentage = attendanceDao.getAttendancePercentage(student.getId(), course.getId());
                attendancePercentages.put(course.getId(), percentage);
            }
            
            // Group attendance by course
            Map<Integer, List<Attendance>> attendanceByCourse = new HashMap<>();
            for (Attendance attendance : attendanceRecords) {
                if (!attendanceByCourse.containsKey(attendance.getCourseId())) {
                    attendanceByCourse.put(attendance.getCourseId(), new ArrayList<>());
                }
                attendanceByCourse.get(attendance.getCourseId()).add(attendance);
            }
            
            request.setAttribute("student", student);
            request.setAttribute("attendanceRecords", attendanceRecords);
            request.setAttribute("courseMap", courseMap);
            request.setAttribute("attendancePercentages", attendancePercentages);
            request.setAttribute("enrolledCourses", enrolledCourses);
            request.setAttribute("attendanceByCourse", attendanceByCourse);
            
            request.getRequestDispatcher("/student/view-attendance.jsp").forward(request, response);
        } else {
            // Handle case where student profile is not found
            request.setAttribute("errorMessage", "Student profile not found");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    
    // Calculate GPA for a student
private BigDecimal calculateGPA(List<Grade> grades, Map<Integer, Course> courseMap) {
    if (grades == null || grades.isEmpty()) {
        return BigDecimal.ZERO;
    }
    
    BigDecimal totalPoints = BigDecimal.ZERO;
    BigDecimal totalCredits = BigDecimal.ZERO;
    
    for (Grade grade : grades) {
        if (grade.getGradePoint() != null && courseMap.containsKey(grade.getCourseId())) {
            Course course = courseMap.get(grade.getCourseId());
            BigDecimal credits = new BigDecimal(course.getCreditHours());
            
            totalPoints = totalPoints.add(grade.getGradePoint().multiply(credits));
            totalCredits = totalCredits.add(credits);
        }
    }
    
    if (totalCredits.compareTo(BigDecimal.ZERO) > 0) {
        return totalPoints.divide(totalCredits, 2, RoundingMode.HALF_UP);
    } else {
        return BigDecimal.ZERO;
    }
}

// Calculate total earned credits
private BigDecimal calculateTotalEarnedCredits(List<Grade> grades, Map<Integer, Course> courseMap) {
    if (grades == null || grades.isEmpty()) {
        return BigDecimal.ZERO;
    }
    
    BigDecimal totalEarnedCredits = BigDecimal.ZERO;
    
    for (Grade grade : grades) {
        if (grade.getGrade() != null && !grade.getGrade().equals("F") && courseMap.containsKey(grade.getCourseId())) {
            Course course = courseMap.get(grade.getCourseId());
            totalEarnedCredits = totalEarnedCredits.add(new BigDecimal(course.getCreditHours()));
        }
    }
    
    return totalEarnedCredits;
}

// Get overall academic status based on GPA
private String getOverallAcademicStatus(BigDecimal gpa) {
    if (gpa == null) {
        return "Not Available";
    }
    
    if (gpa.compareTo(new BigDecimal("3.5")) >= 0) {
        return "Excellent";
    } else if (gpa.compareTo(new BigDecimal("3.0")) >= 0) {
        return "Very Good";
    } else if (gpa.compareTo(new BigDecimal("2.5")) >= 0) {
        return "Good";
    } else if (gpa.compareTo(new BigDecimal("2.0")) >= 0) {
        return "Satisfactory";
    } else if (gpa.compareTo(new BigDecimal("1.0")) >= 0) {
        return "Poor";
    } else {
        return "Failing";
    }
}

    
    private void showCourseRegistration(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        System.out.println("Course registration for user ID: " + user.getId());
        
        // Get student information
        Student student = studentDao.getStudentByUserId(user.getId());
        
        if (student != null) {
            // Get all available courses
            List<Course> allCourses = courseDao.getAllCourses();
            
            // Get enrolled courses
            List<Course> enrolledCourses = courseDao.getCoursesByStudentId(student.getId());
            
            // Create a map of enrolled course IDs for easy checking
            Map<Integer, Boolean> enrolledCourseMap = new HashMap<>();
            for (Course course : enrolledCourses) {
                enrolledCourseMap.put(course.getId(), true);
            }
            
            // Get teacher names for courses
            Map<Integer, String> teacherNames = new HashMap<>();
            for (Course course : allCourses) {
                if (course.getTeacherId() > 0) {
                    Teacher teacher = teacherDao.getTeacherById(course.getTeacherId());
                    if (teacher != null) {
                        teacherNames.put(course.getTeacherId(), teacher.getFirstName() + " " + teacher.getLastName());
                    }
                }
            }
            
            request.setAttribute("student", student);
            request.setAttribute("allCourses", allCourses);
            request.setAttribute("enrolledCourseMap", enrolledCourseMap);
            request.setAttribute("teacherNames", teacherNames);
            
            request.getRequestDispatcher("/student/course-registration.jsp").forward(request, response);
        } else {
            // Handle case where student profile is not found
            request.setAttribute("errorMessage", "Student profile not found");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    
    private void enrollCourse(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        System.out.println("Enroll course for user ID: " + user.getId());
        
        // Get student information
        Student student = studentDao.getStudentByUserId(user.getId());
        
        if (student != null) {
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            System.out.println("Enrolling in course ID: " + courseId);
            
            boolean success = studentDao.enrollStudentInCourse(student.getId(), courseId);
            
            if (success) {
                request.setAttribute("successMessage", "Successfully enrolled in course");
                System.out.println("Enrollment successful");
            } else {
                request.setAttribute("errorMessage", "Failed to enroll in course");
                System.out.println("Enrollment failed");
            }
            
            // Redirect back to the referring page
            String referer = request.getHeader("Referer");
            if (referer != null && referer.contains("course-registration")) {
                response.sendRedirect(request.getContextPath() + "/student/course-registration");
            } else {
                response.sendRedirect(request.getContextPath() + "/student/view-courses");
            }
        } else {
            // Handle case where student profile is not found
            request.setAttribute("errorMessage", "Student profile not found");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
    
    private void dropCourse(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        System.out.println("Drop course for user ID: " + user.getId());
        
        // Get student information
        Student student = studentDao.getStudentByUserId(user.getId());
        
        if (student != null) {
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            System.out.println("Dropping course ID: " + courseId);
            
            boolean success = studentDao.removeStudentFromCourse(student.getId(), courseId);
            
            if (success) {
                request.setAttribute("successMessage", "Successfully dropped course");
                System.out.println("Drop successful");
            } else {
                request.setAttribute("errorMessage", "Failed to drop course");
                System.out.println("Drop failed");
            }
            
            // Redirect back to the referring page
            String referer = request.getHeader("Referer");
            if (referer != null && referer.contains("course-registration")) {
                response.sendRedirect(request.getContextPath() + "/student/course-registration");
            } else {
                response.sendRedirect(request.getContextPath() + "/student/view-courses");
            }
        } else {
            // Handle case where student profile is not found
            request.setAttribute("errorMessage", "Student profile not found");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}