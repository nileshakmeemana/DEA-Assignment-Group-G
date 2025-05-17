<%-- 
    Document   : header
    Created on : May 10, 2025, 1:41:23 PM
    Author     : Nilesh
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<header class="bg-indigo-600">
    <nav class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-16">
            <div class="flex items-center">
                <a href="${pageContext.request.contextPath}/" class="text-white font-bold text-xl">Student Management System</a>
            </div>
            <div class="hidden md:block">
                <div class="flex items-center space-x-4">
                    
                    <c:if test="${not empty sessionScope.user}">
                        <c:choose>
                            <c:when test="${sessionScope.role eq 'admin'}">
                                <a href="${pageContext.request.contextPath}/admin/dashboard" class="text-white hover:bg-indigo-700 px-3 py-2 rounded-md text-sm font-medium">Dashboard</a>
                                <a href="${pageContext.request.contextPath}/admin/manage-students" class="text-white hover:bg-indigo-700 px-3 py-2 rounded-md text-sm font-medium">Students</a>
                                <a href="${pageContext.request.contextPath}/admin/manage-teachers" class="text-white hover:bg-indigo-700 px-3 py-2 rounded-md text-sm font-medium">Teachers</a>
                                <a href="${pageContext.request.contextPath}/admin/manage-courses" class="text-white hover:bg-indigo-700 px-3 py-2 rounded-md text-sm font-medium">Courses</a>
                            </c:when>
                            <c:when test="${sessionScope.role eq 'teacher'}">
                                <a href="${pageContext.request.contextPath}/teacher/dashboard" class="text-white hover:bg-indigo-700 px-3 py-2 rounded-md text-sm font-medium">Dashboard</a>
                                <a href="${pageContext.request.contextPath}/teacher/manage-grades" class="text-white hover:bg-indigo-700 px-3 py-2 rounded-md text-sm font-medium">Grades</a>
                                <a href="${pageContext.request.contextPath}/teacher/manage-attendance" class="text-white hover:bg-indigo-700 px-3 py-2 rounded-md text-sm font-medium">Attendance</a>
                            </c:when>
                            <c:when test="${sessionScope.role eq 'student'}">
                                <a href="${pageContext.request.contextPath}/student/dashboard" class="text-white hover:bg-indigo-700 px-3 py-2 rounded-md text-sm font-medium">Dashboard</a>
                                <a href="${pageContext.request.contextPath}/student/view-courses" class="text-white hover:bg-indigo-700 px-3 py-2 rounded-md text-sm font-medium">Courses</a>
                                <a href="${pageContext.request.contextPath}/student/view-grades" class="text-white hover:bg-indigo-700 px-3 py-2 rounded-md text-sm font-medium">Grades</a>
                                <a href="${pageContext.request.contextPath}/student/view-attendance" class="text-white hover:bg-indigo-700 px-3 py-2 rounded-md text-sm font-medium">Attendance</a>
                            </c:when>
                        </c:choose>
                    </c:if>
                </div>
            </div>
            
            <div class="flex items-center">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <div class="relative ml-3">
                            <div class="group">
                                <button type="button" class="flex items-center text-white hover:bg-indigo-700 px-3 py-2 rounded-md text-sm font-medium">
                                    <span>Welcome, ${sessionScope.username}</span>
                                    <svg class="ml-2 h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                        <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
                                    </svg>
                                </button>
                                <div class="hidden group-hover:block absolute right-0 w-48 py-1 mt-2 bg-white rounded-md shadow-lg">
                                    <a href="${pageContext.request.contextPath}/profile" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Profile</a>
                                    <div class="border-t border-gray-100"></div>
                                    <a href="${pageContext.request.contextPath}/logout" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">Logout</a>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="text-white hover:bg-indigo-700 px-3 py-2 rounded-md text-sm font-medium">Login</a>
                        <a href="${pageContext.request.contextPath}/register" class="ml-4 text-white bg-indigo-500 hover:bg-indigo-400 px-3 py-2 rounded-md text-sm font-medium">Register</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </nav>
</header>
