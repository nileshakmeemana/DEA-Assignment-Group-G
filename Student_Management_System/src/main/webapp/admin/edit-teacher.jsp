<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp" %> 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Management System - Manage Teachers</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-4xl font-bold mb-8">Manage Teachers</h1>
        
        <div class="bg-white rounded-lg shadow-lg overflow-hidden">
            <div class="flex justify-between items-center p-6 border-b">
                <h2 class="text-2xl font-bold">Teacher List</h2>
                <a href="${pageContext.request.contextPath}/admin/add-teacher.jsp" 
                   class="bg-indigo-600 hover:bg-indigo-700 text-white font-medium py-2 px-6 rounded-lg">
                    Add New Teacher
                </a>
            </div>
            
            <!-- Search box -->
            <div class="p-6 border-b">
                <input type="text" placeholder="Search teachers..." 
                       class="w-full p-3 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-indigo-500">
            </div>
            
            <!-- Teachers table -->
            <div class="overflow-x-auto">
                <table class="min-w-full">
                    <thead class="bg-gray-200">
                        <tr>
                            <th class="py-3 px-6 text-left font-medium text-gray-600">ID</th>
                            <th class="py-3 px-6 text-left font-medium text-gray-600">NAME</th>
                            <th class="py-3 px-6 text-left font-medium text-gray-600">EMAIL</th>
                            <th class="py-3 px-6 text-left font-medium text-gray-600">QUALIFICATION</th>
                            <th class="py-3 px-6 text-left font-medium text-gray-600">PHONE</th>
                            <th class="py-3 px-6 text-left font-medium text-gray-600">HIRE DATE</th>
                            <th class="py-3 px-6 text-left font-medium text-gray-600">ACTIONS</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200">
                        <c:forEach var="teacher" items="${teacherList}">
                            <tr class="hover:bg-gray-50">
                                <td class="py-4 px-6">${teacher.id}</td>
                                <td class="py-4 px-6">${teacher.name}</td>
                                <td class="py-4 px-6">${teacher.email}</td>
                                <td class="py-4 px-6">${teacher.qualification}</td>
                                <td class="py-4 px-6">${teacher.phone}</td>
                                <td class="py-4 px-6">${teacher.hireDate}</td>
                                <td class="py-4 px-6">
                                    <a href="${pageContext.request.contextPath}/admin/edit-teacher.jsp?id=${teacher.id}" 
                                       class="text-indigo-600 hover:text-indigo-900 mr-3">Edit</a>
                                    <a href="#" onclick="confirmDelete(${teacher.id})" 
                                       class="text-red-600 hover:text-red-900">Delete</a>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty teacherList}">
                            <tr class="hover:bg-gray-50">
                                <td class="py-4 px-6">1</td>
                                <td class="py-4 px-6">Gayan Perera</td>
                                <td class="py-4 px-6">gayan@gmail.com</td>
                                <td class="py-4 px-6">MBBS</td>
                                <td class="py-4 px-6">0787223917</td>
                                <td class="py-4 px-6">2025-05-04</td>
                                <td class="py-4 px-6">
                                    <a href="${pageContext.request.contextPath}/admin/edit-teacher.jsp?id=1" 
                                       class="text-indigo-600 hover:text-indigo-900 mr-3">Edit</a>
                                    <a href="#" onclick="confirmDelete(1)" 
                                       class="text-red-600 hover:text-red-900">Delete</a>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
            
            <!-- Pagination (optional) -->
            <div class="px-6 py-4 flex items-center justify-between border-t">
                <div class="text-sm text-gray-500">
                    Showing <span class="font-medium">1</span> to <span class="font-medium">1</span> of <span class="font-medium">1</span> results
                </div>
                <div class="flex space-x-2">
                    <button class="px-3 py-1 rounded-md bg-gray-200 text-gray-600 hover:bg-gray-300 disabled:opacity-50" disabled>
                        Previous
                    </button>
                    <button class="px-3 py-1 rounded-md bg-gray-200 text-gray-600 hover:bg-gray-300 disabled:opacity-50" disabled>
                        Next
                    </button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
<%@ include file="footer.jsp" %>