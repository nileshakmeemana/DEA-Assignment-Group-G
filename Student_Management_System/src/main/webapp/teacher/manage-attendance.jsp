<%-- 
    Document   : manage-attendance
    Created on : May 10, 2025, 1:48:16 PM
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
    <title>Manage Attendance - Student Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
    <jsp:include page="../includes/header.jsp" />
    
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <h2 class="text-2xl font-bold text-gray-900 mb-6">Manage Attendance</h2>
        
        <c:if test="${not empty successMessage}">
            <div class="rounded-md bg-green-50 p-4 mb-6">
                <div class="flex">
                    <div class="flex-shrink-0">
                        <svg class="h-5 w-5 text-green-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                    </div>
                    <div class="ml-3">
                        <p class="text-sm font-medium text-green-800">${successMessage}</p>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="rounded-md bg-red-50 p-4 mb-6">
                <div class="flex">
                    <div class="flex-shrink-0">
                        <svg class="h-5 w-5 text-red-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                    </div>
                    <div class="ml-3">
                        <p class="text-sm font-medium text-red-800">${errorMessage}</p>
                    </div>
                </div>
            </div>
        </c:if>
        
        <div class="bg-white shadow-lg rounded-lg overflow-hidden">
            <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                <h5 class="text-lg font-medium text-gray-900">Select Course</h5>
            </div>
            <div class="p-6">
                <form action="${pageContext.request.contextPath}/teacher/manage-attendance" method="get">
                    <div class="max-w-lg">
                        <label for="courseId" class="block text-sm font-medium text-gray-700">Course:</label>
                        <select class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md" 
                                id="courseId" name="courseId" onchange="this.form.submit()">
                            <option value="">Select a course</option>
                            <c:forEach items="${teacherCourses}" var="course">
                                <option value="${course.id}" ${selectedCourse != null && selectedCourse.id == course.id ? 'selected' : ''}>
                                    ${course.code} - ${course.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </form>
            </div>
        </div>
        
        <c:if test="${not empty selectedCourse}">
            <div class="bg-white shadow-lg rounded-lg overflow-hidden mt-6">
                <div class="px-4 py-5 sm:px-6 border-b border-gray-200 flex justify-between items-center">
                    <h5 class="text-lg font-medium text-gray-900">Attendance for ${selectedCourse.code} - ${selectedCourse.name}</h5>
                    <div class="space-x-4">
                        <a href="${pageContext.request.contextPath}/teacher/take-attendance?courseId=${selectedCourse.id}" 
                           class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                            Take Today's Attendance
                        </a>
                        <button type="button" 
                                class="inline-flex items-center px-4 py-2 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                                data-modal-target="selectDateModal">
                            Take Attendance for Another Date
                        </button>
                    </div>
                </div>
                <div class="p-6">
                    <c:if test="${not empty attendanceByDate}">
                        <div class="border-b border-gray-200">
                            <nav class="-mb-px flex space-x-8" aria-label="Tabs">
                                <c:forEach items="${attendanceByDate}" var="dateEntry" varStatus="status">
                                    <button class="whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm
                                            ${status.first ? 'border-indigo-500 text-indigo-600' : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'}"
                                            id="date-${dateEntry.key}-tab"
                                            data-tab-target="#date-${dateEntry.key}"
                                            type="button"
                                            role="tab">
                                        <fmt:formatDate value="${dateEntry.key}" pattern="yyyy-MM-dd" />
                                    </button>
                                </c:forEach>
                            </nav>
                        </div>
                        <div class="mt-6">
                            <c:forEach items="${attendanceByDate}" var="dateEntry" varStatus="status">
                                <div class="tab-content ${status.first ? 'block' : 'hidden'}"
                                     id="date-${dateEntry.key}"
                                     role="tabpanel">
                                    <div class="flex justify-between items-center mb-6">
                                        <h6 class="text-lg font-medium text-gray-900">
                                            Attendance for <fmt:formatDate value="${dateEntry.key}" pattern="EEEE, MMMM d, yyyy" />
                                        </h6>
                                        <a href="${pageContext.request.contextPath}/teacher/take-attendance?courseId=${selectedCourse.id}&date=<fmt:formatDate value="${dateEntry.key}" pattern="yyyy-MM-dd" />"
                                           class="inline-flex items-center px-3 py-2 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                                            Edit This Day's Attendance
                                        </a>
                                    </div>
                                    <div class="overflow-x-auto">
                                        <table class="min-w-full divide-y divide-gray-200">
                                            <thead class="bg-gray-50">
                                                <tr>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Student ID</th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Action</th>
                                                </tr>
                                            </thead>
                                            <tbody class="bg-white divide-y divide-gray-200">
                                                <c:forEach items="${enrolledStudents}" var="student">
                                                    <tr>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${student.id}</td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${student.firstName} ${student.lastName}</td>
                                                        <td class="px-6 py-4 whitespace-nowrap">
                                                            <c:choose>
                                                                <c:when test="${dateEntry.value[student.id] != null}">
                                                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium
                                                                        ${dateEntry.value[student.id] == 'Present' ? 'bg-green-100 text-green-800' : 
                                                                        dateEntry.value[student.id] == 'Late' ? 'bg-yellow-100 text-yellow-800' : 
                                                                        'bg-red-100 text-red-800'}">
                                                                        ${dateEntry.value[student.id]}
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-800">
                                                                        Not Recorded
                                                                    </span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                                            <button type="button" 
                                                                    class="inline-flex items-center px-3 py-1 border border-transparent text-sm font-medium rounded-md text-indigo-700 bg-indigo-100 hover:bg-indigo-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                                                                    data-modal-target="attendanceModal${student.id}${dateEntry.key.time}">
                                                                Update
                                                            </button>
                                                            
                                                            <!-- Attendance Modal -->
                                                            <div class="hidden fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" 
                                                                 id="attendanceModal${student.id}${dateEntry.key.time}">
                                                                <div class="fixed inset-0 z-10 overflow-y-auto">
                                                                    <div class="flex min-h-full items-end justify-center p-4 text-center sm:items-center sm:p-0">
                                                                        <div class="relative transform overflow-hidden rounded-lg bg-white text-left shadow-xl transition-all sm:my-8 sm:w-full sm:max-w-lg">
                                                                            <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
                                                                                <div class="sm:flex sm:items-start">
                                                                                    <div class="mt-3 text-center sm:mt-0 sm:text-left w-full">
                                                                                        <h3 class="text-lg font-medium leading-6 text-gray-900">
                                                                                            Update Attendance for ${student.firstName} ${student.lastName}
                                                                                        </h3>
                                                                                        <div class="mt-4">
                                                                                            <form action="${pageContext.request.contextPath}/teacher/update-attendance" method="post">
                                                                                                <input type="hidden" name="studentId" value="${student.id}">
                                                                                                <input type="hidden" name="courseId" value="${selectedCourse.id}">
                                                                                                <input type="hidden" name="date" value="<fmt:formatDate value="${dateEntry.key}" pattern="yyyy-MM-dd" />">
                                                                                                
                                                                                                <div class="space-y-4">
                                                                                                    <div class="flex items-center">
                                                                                                        <input type="radio" 
                                                                                                               id="present${student.id}${dateEntry.key.time}" 
                                                                                                               name="status" 
                                                                                                               value="Present"
                                                                                                               class="h-4 w-4 text-indigo-600 focus:ring-indigo-500 border-gray-300"
                                                                                                               ${dateEntry.value[student.id] == 'Present' ? 'checked' : ''}>
                                                                                                        <label for="present${student.id}${dateEntry.key.time}" 
                                                                                                               class="ml-3 block text-sm font-medium text-gray-700">Present</label>
                                                                                                    </div>
                                                                                                    <div class="flex items-center">
                                                                                                        <input type="radio" 
                                                                                                               id="late${student.id}${dateEntry.key.time}" 
                                                                                                               name="status" 
                                                                                                               value="Late"
                                                                                                               class="h-4 w-4 text-yellow-600 focus:ring-yellow-500 border-gray-300"
                                                                                                               ${dateEntry.value[student.id] == 'Late' ? 'checked' : ''}>
                                                                                                        <label for="late${student.id}${dateEntry.key.time}" 
                                                                                                               class="ml-3 block text-sm font-medium text-gray-700">Late</label>
                                                                                                    </div>
                                                                                                    <div class="flex items-center">
                                                                                                        <input type="radio" 
                                                                                                               id="absent${student.id}${dateEntry.key.time}" 
                                                                                                               name="status" 
                                                                                                               value="Absent"
                                                                                                               class="h-4 w-4 text-red-600 focus:ring-red-500 border-gray-300"
                                                                                                               ${dateEntry.value[student.id] == 'Absent' ? 'checked' : ''}>
                                                                                                        <label for="absent${student.id}${dateEntry.key.time}" 
                                                                                                               class="ml-3 block text-sm font-medium text-gray-700">Absent</label>
                                                                                                    </div>
                                                                                                </div>
                                                                                                
                                                                                                <div class="mt-5 sm:mt-4 sm:flex sm:flex-row-reverse">
                                                                                                    <button type="submit"
                                                                                                            class="inline-flex w-full justify-center rounded-md border border-transparent bg-indigo-600 px-4 py-2 text-base font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 sm:ml-3 sm:w-auto sm:text-sm">
                                                                                                        Save Changes
                                                                                                    </button>
                                                                                                    <button type="button"
                                                                                                            class="mt-3 inline-flex w-full justify-center rounded-md border border-gray-300 bg-white px-4 py-2 text-base font-medium text-gray-700 shadow-sm hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 sm:mt-0 sm:w-auto sm:text-sm"
                                                                                                            onclick="document.getElementById('attendanceModal${student.id}${dateEntry.key.time}').classList.add('hidden')">
                                                                                                        Cancel
                                                                                                    </button>
                                                                                                </div>
                                                                                            </form>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>
                    <c:if test="${empty attendanceByDate}">
                        <div class="rounded-md bg-blue-50 p-4">
                            <div class="flex">
                                <div class="ml-3">
                                    <p class="text-sm text-blue-700">
                                        No attendance records available for this course yet.
                                        <a href="${pageContext.request.contextPath}/teacher/take-attendance?courseId=${selectedCourse.id}" 
                                           class="font-medium text-blue-700 underline">Take attendance now</a>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
            
            <!-- Attendance Summary Card -->
            <div class="bg-white shadow-lg rounded-lg overflow-hidden mt-6">
                <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                    <h5 class="text-lg font-medium text-gray-900">Attendance Summary</h5>
                </div>
                <div class="p-6">
                    <c:if test="${not empty enrolledStudents}">
                        <div class="overflow-x-auto">
                            <table class="min-w-full divide-y divide-gray-200">
                                <thead class="bg-gray-50">
                                    <tr>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Student Name</th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Present</th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Late</th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Absent</th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Attendance Rate</th>
                                    </tr>
                                </thead>
                                <tbody class="bg-white divide-y divide-gray-200">
                                    <c:forEach items="${enrolledStudents}" var="student">
                                        <c:set var="presentCount" value="0" />
                                        <c:set var="lateCount" value="0" />
                                        <c:set var="absentCount" value="0" />
                                        <c:set var="totalDays" value="0" />
                                        
                                        <c:forEach items="${attendanceByDate}" var="dateEntry">
                                            <c:if test="${dateEntry.value[student.id] != null}">
                                                <c:set var="totalDays" value="${totalDays + 1}" />
                                                <c:choose>
                                                    <c:when test="${dateEntry.value[student.id] == 'Present'}">
                                                        <c:set var="presentCount" value="${presentCount + 1}" />
                                                    </c:when>
                                                    <c:when test="${dateEntry.value[student.id] == 'Late'}">
                                                        <c:set var="lateCount" value="${lateCount + 1}" />
                                                    </c:when>
                                                    <c:when test="${dateEntry.value[student.id] == 'Absent'}">
                                                        <c:set var="absentCount" value="${absentCount + 1}" />
                                                    </c:when>
                                                </c:choose>
                                            </c:if>
                                        </c:forEach>
                                        
                                        <c:set var="attendanceRate" value="${totalDays > 0 ? (presentCount + lateCount) * 100 / totalDays : 0}" />
                                        
                                        <tr>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${student.firstName} ${student.lastName}</td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${presentCount}</td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${lateCount}</td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${absentCount}</td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="w-full bg-gray-200 rounded-full h-2.5">
                                                    <div class="h-2.5 rounded-full ${attendanceRate >= 90 ? 'bg-green-500' : 
                                                                                    attendanceRate >= 75 ? 'bg-blue-500' : 
                                                                                    attendanceRate >= 60 ? 'bg-yellow-500' : 'bg-red-500'}"
                                                         style="width: ${attendanceRate}%">
                                                    </div>
                                                </div>
                                                <span class="text-sm text-gray-600 mt-1 block">
                                                    <fmt:formatNumber value="${attendanceRate}" pattern="#,##0.0"/>%
                                                </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                    <c:if test="${empty enrolledStudents}">
                        <div class="rounded-md bg-blue-50 p-4">
                            <div class="flex">
                                <div class="ml-3">
                                    <p class="text-sm text-blue-700">No students enrolled in this course yet.</p>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </c:if>
    </div>
    
    <!-- Select Date Modal -->
    <div class="hidden fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" id="selectDateModal">
        <div class="fixed inset-0 z-10 overflow-y-auto">
            <div class="flex min-h-full items-end justify-center p-4 text-center sm:items-center sm:p-0">
                <div class="relative transform overflow-hidden rounded-lg bg-white text-left shadow-xl transition-all sm:my-8 sm:w-full sm:max-w-lg">
                    <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
                        <div class="sm:flex sm:items-start">
                            <div class="mt-3 text-center sm:mt-0 sm:text-left w-full">
                                <h3 class="text-lg font-medium leading-6 text-gray-900" id="selectDateModalLabel">
                                    Select Date for Attendance
                                </h3>
                                <div class="mt-4">
                                    <form id="selectDateForm" action="${pageContext.request.contextPath}/teacher/take-attendance" method="get">
                                        <input type="hidden" name="courseId" value="${selectedCourse.id}">
                                        <div class="mb-4">
                                            <label for="selectDate" class="block text-sm font-medium text-gray-700">Select Date</label>
                                            <input type="date" 
                                                   class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm" 
                                                   id="selectDate" 
                                                   name="date" 
                                                   required>
                                        </div>
                                        <div class="mt-5 sm:mt-4 sm:flex sm:flex-row-reverse">
                                            <button type="submit"
                                                    class="inline-flex w-full justify-center rounded-md border border-transparent bg-indigo-600 px-4 py-2 text-base font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 sm:ml-3 sm:w-auto sm:text-sm">
                                                Go to Selected Date
                                            </button>
                                            <button type="button"
                                                    class="mt-3 inline-flex w-full justify-center rounded-md border border-gray-300 bg-white px-4 py-2 text-base font-medium text-gray-700 shadow-sm hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 sm:mt-0 sm:w-auto sm:text-sm"
                                                    onclick="document.getElementById('selectDateModal').classList.add('hidden')">
                                                Cancel
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../includes/footer.jsp" />
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Set default date in the date picker to today
            const today = new Date();
            const formattedDate = today.toISOString().substr(0, 10);
            document.getElementById('selectDate').value = formattedDate;
            
            // Tab functionality
            const tabButtons = document.querySelectorAll('[data-tab-target]');
            const tabContents = document.querySelectorAll('.tab-content');
            
            tabButtons.forEach(button => {
                button.addEventListener('click', () => {
                    const target = document.querySelector(button.dataset.tabTarget);
                    
                    tabContents.forEach(content => {
                        content.classList.add('hidden');
                    });
                    
                    tabButtons.forEach(btn => {
                        btn.classList.remove('border-indigo-500', 'text-indigo-600');
                        btn.classList.add('border-transparent', 'text-gray-500');
                    });
                    
                    target.classList.remove('hidden');
                    button.classList.remove('border-transparent', 'text-gray-500');
                    button.classList.add('border-indigo-500', 'text-indigo-600');
                });
            });
            
            // Modal functionality
            const modalButtons = document.querySelectorAll('[data-modal-target]');
            modalButtons.forEach(button => {
                button.addEventListener('click', () => {
                    const modalId = button.dataset.modalTarget;
                    document.getElementById(modalId).classList.remove('hidden');
                });
            });
        });
    </script>
</body>
</html>
