<%-- 
    Document   : dashboard
    Created on : May 10, 2025, 1:46:11 PM
    Author     : Nilesh
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - Student Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
    <jsp:include page="../includes/header.jsp" />
    
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <h2 class="text-2xl font-bold text-gray-900 mb-6">Student Dashboard</h2>
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
            <div class="lg:col-span-2">
                <div class="bg-white shadow-lg rounded-lg overflow-hidden mb-6">
                    <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                        <h5 class="text-lg font-medium text-gray-900">Welcome, ${student.firstName} ${student.lastName}</h5>
                    </div>
                    <div class="p-6">
                        <p class="text-sm text-gray-600 mb-2">Student ID: ${student.id}</p>
                        <p class="text-sm text-gray-600 mb-2">Email: ${user.email}</p>
                        <p class="text-sm text-gray-600">Enrollment Date: ${student.enrollmentDate}</p>
                    </div>
                </div>
                
                <!-- Academic Summary Card -->
                <div class="bg-white shadow-lg rounded-lg overflow-hidden mb-6">
                    <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                        <h5 class="text-lg font-medium text-gray-900">Academic Summary</h5>
                    </div>
                    <div class="p-6">
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                            <div class="bg-white rounded-lg border border-gray-200 p-6 text-center">
                                <h2 class="text-3xl font-bold text-gray-900">${gpa != null ? gpa : '0.00'}</h2>
                                <p class="text-sm text-gray-600 mt-1">Current GPA</p>
                            </div>
                            <div class="bg-white rounded-lg border border-gray-200 p-6 text-center">
                                <h2 class="text-3xl font-bold text-gray-900">${totalEarnedCredits != null ? totalEarnedCredits : '0'}</h2>
                                <p class="text-sm text-gray-600 mt-1">Credits Earned</p>
                            </div>
                            <div class="bg-white rounded-lg border border-gray-200 p-6 text-center">
                                <h2 class="text-3xl font-bold">
                                    <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-medium
                                        ${academicStatus == 'Excellent' ? 'bg-green-100 text-green-800' : 
                                        academicStatus == 'Very Good' ? 'bg-blue-100 text-blue-800' : 
                                        academicStatus == 'Good' ? 'bg-indigo-100 text-indigo-800' : 
                                        academicStatus == 'Satisfactory' ? 'bg-gray-100 text-gray-800' : 
                                        academicStatus == 'Poor' ? 'bg-yellow-100 text-yellow-800' : 'bg-red-100 text-red-800'}">
                                        ${academicStatus}
                                    </span>
                                </h2>
                                <p class="text-sm text-gray-600 mt-1">Academic Status</p>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="bg-white shadow-lg rounded-lg overflow-hidden">
                    <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                        <h5 class="text-lg font-medium text-gray-900">Enrolled Courses</h5>
                    </div>
                    <div class="p-6">
                        <c:if test="${not empty enrolledCourses}">
                            <div class="overflow-x-auto">
                                <table class="min-w-full divide-y divide-gray-200">
                                    <thead class="bg-gray-50">
                                        <tr>
                                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Course Code</th>
                                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Course Name</th>
                                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Credit Hours</th>
                                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Teacher</th>
                                        </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200">
                                        <c:forEach items="${enrolledCourses}" var="course">
                                            <tr>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${course.code}</td>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${course.name}</td>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${course.creditHours}</td>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                                    ${teacherNames[course.teacherId] != null ? teacherNames[course.teacherId] : 'Not Assigned'}
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:if>
                        <c:if test="${empty enrolledCourses}">
                            <div class="rounded-md bg-blue-50 p-4">
                                <div class="flex">
                                    <div class="flex-shrink-0">
                                        <svg class="h-5 w-5 text-blue-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                            <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd" />
                                        </svg>
                                    </div>
                                    <div class="ml-3">
                                        <p class="text-sm text-blue-700">You are not enrolled in any courses yet.</p>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <div class="mt-4">
                            <a href="${pageContext.request.contextPath}/student/view-courses" 
                               class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                                View All Courses
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="lg:col-span-1">
                <div class="bg-white shadow-lg rounded-lg overflow-hidden mb-6">
                    <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                        <h5 class="text-lg font-medium text-gray-900">Quick Links</h5>
                    </div>
                    <div class="p-6">
                        <nav class="space-y-2">
                            <a href="${pageContext.request.contextPath}/student/view-grades" 
                               class="flex items-center px-3 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-gray-900">
                                <svg class="mr-3 h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                    <path d="M9 2a1 1 0 000 2h2a1 1 0 100-2H9z" />
                                    <path fill-rule="evenodd" d="M4 5a2 2 0 012-2 3 3 0 003 3h2a3 3 0 003-3 2 2 0 012 2v11a2 2 0 01-2 2H6a2 2 0 01-2-2V5zm3 4a1 1 0 000 2h.01a1 1 0 100-2H7zm3 0a1 1 0 000 2h3a1 1 0 100-2h-3zm-3 4a1 1 0 100 2h.01a1 1 0 100-2H7zm3 0a1 1 0 100 2h3a1 1 0 100-2h-3z" clip-rule="evenodd" />
                                </svg>
                                View Grades
                            </a>
                            <a href="${pageContext.request.contextPath}/student/view-attendance" 
                               class="flex items-center px-3 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-gray-900">
                                <svg class="mr-3 h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                    <path fill-rule="evenodd" d="M6 2a1 1 0 00-1 1v1H4a2 2 0 00-2 2v10a2 2 0 002 2h12a2 2 0 002-2V6a2 2 0 00-2-2h-1V3a1 1 0 10-2 0v1H7V3a1 1 0 00-1-1zm0 5a1 1 0 000 2h8a1 1 0 100-2H6z" clip-rule="evenodd" />
                                </svg>
                                View Attendance
                            </a>
                            <a href="${pageContext.request.contextPath}/profile" 
                               class="flex items-center px-3 py-2 text-sm font-medium text-gray-700 rounded-md hover:bg-gray-50 hover:text-gray-900">
                                <svg class="mr-3 h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                    <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd" />
                                </svg>
                                Edit Profile
                            </a>
                        </nav>
                    </div>
                </div>
                
                <div class="bg-white shadow-lg rounded-lg overflow-hidden">
                    <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                        <h5 class="text-lg font-medium text-gray-900">Notices for Student</h5>
                    </div>
                    <div class="p-6">
                        <c:if test="${not empty deadlines}">
                            <div class="space-y-4">
                                <c:forEach items="${deadlines}" var="deadline">
                                    <div class="bg-white rounded-lg border border-gray-200 p-4">
                                        <h6 class="text-sm font-medium text-gray-900 mb-1">${deadline.title}</h6>
                                        <p class="text-sm text-gray-600 mb-2">${deadline.description}</p>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>
                        <c:if test="${empty deadlines}">
                            <p class="text-sm text-gray-600">No Notices for Students.</p>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../includes/footer.jsp" />
</body>
</html>
