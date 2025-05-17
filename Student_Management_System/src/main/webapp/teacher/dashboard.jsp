<%-- 
    Document   : dashboard
    Created on : May 10, 2025, 1:47:47 PM
    Author     : Nilesh
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Dashboard - Student Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
    <jsp:include page="../includes/header.jsp" />
    
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <h2 class="text-2xl font-bold text-gray-900 mb-6">Teacher Dashboard</h2>
        
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
            <div class="lg:col-span-2">
                <!-- Teacher Info Card -->
                <div class="bg-white shadow rounded-lg mb-6">
                    <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                        <h3 class="text-lg leading-6 font-medium text-gray-900">
                            Welcome, ${teacher.firstName} ${teacher.lastName}
                        </h3>
                    </div>
                    <div class="px-4 py-5 sm:p-6">
                        <dl class="grid grid-cols-1 gap-x-4 gap-y-6 sm:grid-cols-2">
                            <div class="sm:col-span-1">
                                <dt class="text-sm font-medium text-gray-500">Teacher ID</dt>
                                <dd class="mt-1 text-sm text-gray-900">${teacher.id}</dd>
                            </div>
                            <div class="sm:col-span-1">
                                <dt class="text-sm font-medium text-gray-500">Email</dt>
                                <dd class="mt-1 text-sm text-gray-900">${user.email}</dd>
                            </div>
                            <div class="sm:col-span-1">
                                <dt class="text-sm font-medium text-gray-500">Hire Date</dt>
                                <dd class="mt-1 text-sm text-gray-900">${teacher.hireDate}</dd>
                            </div>
                        </dl>
                    </div>
                </div>

                <!-- Courses Table -->
                <div class="bg-white shadow rounded-lg">
                    <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                        <h3 class="text-lg leading-6 font-medium text-gray-900">Courses You Teach</h3>
                    </div>
                    <div class="px-4 py-5 sm:p-6">
                        <c:if test="${not empty teacherCourses}">
                            <div class="overflow-x-auto">
                                <table class="min-w-full divide-y divide-gray-200">
                                    <thead class="bg-gray-50">
                                        <tr>
                                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Course Code</th>
                                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Course Name</th>
                                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Credit Hours</th>
                                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Students Enrolled</th>
                                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody class="bg-white divide-y divide-gray-200">
                                        <c:forEach items="${teacherCourses}" var="course">
                                            <tr>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${course.code}</td>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${course.name}</td>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${course.creditHours}</td>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${enrollmentCounts[course.id]}</td>
                                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium space-x-2">
                                                    <a href="${pageContext.request.contextPath}/teacher/manage-grades?courseId=${course.id}" 
                                                       class="text-indigo-600 hover:text-indigo-900">Grades</a>
                                                    <a href="${pageContext.request.contextPath}/teacher/manage-attendance?courseId=${course.id}" 
                                                       class="text-blue-600 hover:text-blue-900">Attendance</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:if>
                        <c:if test="${empty teacherCourses}">
                            <p class="text-sm text-gray-500">You are not assigned to any courses yet.</p>
                        </c:if>
                    </div>
                </div>
            </div>

            <div class="space-y-6">
                <!-- Quick Links Card -->
                <div class="bg-white shadow rounded-lg">
                    <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                        <h3 class="text-lg leading-6 font-medium text-gray-900">Quick Links</h3>
                    </div>
                    <div class="px-4 py-5 sm:p-6">
                        <nav class="space-y-2">
                            <a href="${pageContext.request.contextPath}/teacher/manage-grades" 
                               class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900 rounded-md">
                                Manage Grades
                            </a>
                            <a href="${pageContext.request.contextPath}/teacher/manage-attendance" 
                               class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900 rounded-md">
                                Manage Attendance
                            </a>
                            <a href="${pageContext.request.contextPath}/profile" 
                               class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900 rounded-md">
                                Edit Profile
                            </a>
                        </nav>
                    </div>
                </div>

                <!-- Recent Activities Card -->
                <div class="bg-white shadow rounded-lg">
                    <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                        <h3 class="text-lg leading-6 font-medium text-gray-900">Recent Activities</h3>
                    </div>
                    <div class="px-4 py-5 sm:p-6">
                        <c:if test="${not empty recentActivities}">
                            <div class="flow-root">
                                <ul class="-my-5 divide-y divide-gray-200">
                                    <c:forEach items="${recentActivities}" var="activity">
                                        <li class="py-4">
                                            <div class="flex items-center space-x-4">
                                                <div class="flex-shrink-0">
                                                    <svg class="h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2" />
                                                    </svg>
                                                </div>
                                                <div class="flex-1 min-w-0">
                                                    <p class="text-sm text-gray-900">${activity}</p>
                                                </div>
                                            </div>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </c:if>
                        <c:if test="${empty recentActivities}">
                            <p class="text-sm text-gray-500">No recent activities.</p>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../includes/footer.jsp" />
</body>
</html>