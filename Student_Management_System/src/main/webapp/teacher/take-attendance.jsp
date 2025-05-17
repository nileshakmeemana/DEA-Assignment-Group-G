<%-- 
    Document   : take-attendance
    Created on : May 10, 2025, 1:48:46 PM
    Author     : Nilesh
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Take Attendance - Student Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
    <jsp:include page="../includes/header.jsp" />
    
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <h2 class="text-2xl font-bold text-gray-900 mb-6">Take Attendance</h2>
        
        <div class="bg-white shadow-lg rounded-lg overflow-hidden">
            <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                <h5 class="text-lg font-medium text-gray-900">Take Attendance for ${selectedCourse.code} - ${selectedCourse.name}</h5>
            </div>
            <div class="p-6">
                <c:if test="${not empty enrolledStudents}">
                    <form action="${pageContext.request.contextPath}/teacher/take-attendance" method="post">
                        <input type="hidden" name="courseId" value="${selectedCourse.id}">
                        
                        <div class="mb-6">
                            <label for="date" class="block text-sm font-medium text-gray-700">Date</label>
                            <input type="date" class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" 
                                   id="date" name="date" value="<fmt:formatDate value="${selectedDate}" pattern="yyyy-MM-dd" />" required>
                        </div>
                        
                        <div class="mb-6 space-x-4">
                            <button type="button" class="inline-flex items-center px-4 py-2 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" id="markAllPresent">
                                Mark All Present
                            </button>
                            <button type="button" class="inline-flex items-center px-4 py-2 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-yellow-500" id="markAllLate">
                                Mark All Late
                            </button>
                            <button type="button" class="inline-flex items-center px-4 py-2 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-red-500" id="markAllAbsent">
                                Mark All Absent
                            </button>
                        </div>
                        
                        <div class="overflow-x-auto">
                            <table class="min-w-full divide-y divide-gray-200">
                                <thead class="bg-gray-50">
                                    <tr>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Student ID</th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                                    </tr>
                                </thead>
                                <tbody class="bg-white divide-y divide-gray-200">
                                    <c:forEach items="${enrolledStudents}" var="student">
                                        <tr>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${student.id}</td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${student.firstName} ${student.lastName}</td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <input type="hidden" name="studentId" value="${student.id}">
                                                <div class="space-x-4">
                                                    <div class="inline-flex items-center">
                                                        <input class="status-radio h-4 w-4 text-indigo-600 focus:ring-indigo-500 border-gray-300" 
                                                               type="radio" name="status_${student.id}" id="present_${student.id}" value="Present" 
                                                               ${existingAttendance[student.id] == 'Present' ? 'checked' : (existingAttendance[student.id] == null ? 'checked' : '')}>
                                                        <label class="ml-2 text-sm text-gray-700" for="present_${student.id}">Present</label>
                                                    </div>
                                                    <div class="inline-flex items-center">
                                                        <input class="status-radio h-4 w-4 text-yellow-600 focus:ring-yellow-500 border-gray-300" 
                                                               type="radio" name="status_${student.id}" id="late_${student.id}" value="Late" 
                                                               ${existingAttendance[student.id] == 'Late' ? 'checked' : ''}>
                                                        <label class="ml-2 text-sm text-gray-700" for="late_${student.id}">Late</label>
                                                    </div>
                                                    <div class="inline-flex items-center">
                                                        <input class="status-radio h-4 w-4 text-red-600 focus:ring-red-500 border-gray-300" 
                                                               type="radio" name="status_${student.id}" id="absent_${student.id}" value="Absent" 
                                                               ${existingAttendance[student.id] == 'Absent' ? 'checked' : ''}>
                                                        <label class="ml-2 text-sm text-gray-700" for="absent_${student.id}">Absent</label>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        
                        <div class="mt-6 flex space-x-4">
                            <button type="submit" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                                Submit Attendance
                            </button>
                            <a href="${pageContext.request.contextPath}/teacher/manage-attendance?courseId=${selectedCourse.id}" 
                               class="inline-flex items-center px-4 py-2 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                                Cancel
                            </a>
                        </div>
                    </form>
                </c:if>
                <c:if test="${empty enrolledStudents}">
                    <div class="rounded-md bg-blue-50 p-4">
                        <div class="flex">
                            <div class="ml-3">
                                <p class="text-sm text-blue-700">No students enrolled in this course yet.</p>
                            </div>
                        </div>
                    </div>
                    <div class="mt-6">
                        <a href="${pageContext.request.contextPath}/teacher/manage-attendance" 
                           class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                            Back to Attendance Management
                        </a>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    
    <jsp:include page="../includes/footer.jsp" />
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Date change handler
            document.getElementById('date').addEventListener('change', function() {
                const date = this.value;
                const courseId = ${selectedCourse.id};
                window.location.href = '${pageContext.request.contextPath}/teacher/take-attendance?courseId=' + courseId + '&date=' + date;
            });
            
            // Mark all present button
            document.getElementById('markAllPresent').addEventListener('click', function() {
                const presentRadios = document.querySelectorAll('input[id^="present_"]');
                presentRadios.forEach(radio => {
                    radio.checked = true;
                });
            });
            
            // Mark all late button
            document.getElementById('markAllLate').addEventListener('click', function() {
                const lateRadios = document.querySelectorAll('input[id^="late_"]');
                lateRadios.forEach(radio => {
                    radio.checked = true;
                });
            });
            
            // Mark all absent button
            document.getElementById('markAllAbsent').addEventListener('click', function() {
                const absentRadios = document.querySelectorAll('input[id^="absent_"]');
                absentRadios.forEach(radio => {
                    radio.checked = true;
                });
            });
        });
    </script>
</body>
</html>

