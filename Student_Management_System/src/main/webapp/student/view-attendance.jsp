<%-- 
    Document   : view-attendance
    Created on : May 10, 2025, 1:46:35 PM
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
    <title>My Attendance - Student Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
    <jsp:include page="../includes/header.jsp" />
    
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <h2 class="text-2xl font-bold text-gray-900 mb-6">My Attendance</h2>
        
        <div class="space-y-6">
            <div class="bg-white shadow-lg rounded-lg overflow-hidden">
                <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                    <h5 class="text-lg font-medium text-gray-900">Attendance Summary</h5>
                </div>
                <div class="p-6">
                    <c:if test="${not empty enrolledCourses}">
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                            <c:forEach items="${enrolledCourses}" var="course">
                                <div class="bg-white rounded-lg shadow-md p-6 border border-gray-200">
                                    <h5 class="text-lg font-semibold text-gray-900 mb-4">${course.code} - ${course.name}</h5>
                                    <div class="relative pt-1">
                                        <div class="overflow-hidden h-2 mb-4 text-xs flex rounded bg-gray-200">
                                            <div class="shadow-none flex flex-col text-center whitespace-nowrap text-white justify-center 
                                                ${attendancePercentages[course.id] >= 90 ? 'bg-green-500' : 
                                                attendancePercentages[course.id] >= 75 ? 'bg-blue-500' : 
                                                attendancePercentages[course.id] >= 60 ? 'bg-yellow-500' : 'bg-red-500'}"
                                                style="width: ${attendancePercentages[course.id]}%">
                                            </div>
                                        </div>
                                        <div class="text-center">
                                            <span class="text-sm font-semibold text-gray-700">
                                                <fmt:formatNumber value="${attendancePercentages[course.id]}" pattern="#,##0.0"/>%
                                            </span>
                                        </div>
                                    </div>
                                    <div class="mt-4 text-center">
                                        <c:choose>
                                            <c:when test="${attendancePercentages[course.id] >= 90}">
                                                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">Excellent</span>
                                            </c:when>
                                            <c:when test="${attendancePercentages[course.id] >= 75}">
                                                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800">Good</span>
                                            </c:when>
                                            <c:when test="${attendancePercentages[course.id] >= 60}">
                                                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800">Needs Improvement</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">Poor</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:if>
                    <c:if test="${empty enrolledCourses}">
                        <div class="rounded-md bg-blue-50 p-4">
                            <div class="flex">
                                <div class="ml-3">
                                    <p class="text-sm text-blue-700">You are not enrolled in any courses yet.</p>
                                    <div class="mt-4">
                                        <a href="${pageContext.request.contextPath}/student/course-registration" 
                                           class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                            Register for Courses
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
            
            <c:if test="${not empty attendanceByCourse}">
                <div class="bg-white shadow-lg rounded-lg overflow-hidden">
                    <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                        <h5 class="text-lg font-medium text-gray-900">Detailed Attendance Records</h5>
                    </div>
                    <div class="p-6">
                        <div class="border-b border-gray-200">
                            <nav class="-mb-px flex space-x-8" aria-label="Tabs">
                                <c:forEach items="${enrolledCourses}" var="course" varStatus="status">
                                    <button class="whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm
                                            ${status.first ? 'border-indigo-500 text-indigo-600' : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'}"
                                            id="course-${course.id}-tab"
                                            data-tab-target="#course-${course.id}"
                                            type="button"
                                            role="tab">
                                        ${course.code}
                                    </button>
                                </c:forEach>
                            </nav>
                        </div>
                        <div class="mt-6">
                            <c:forEach items="${enrolledCourses}" var="course" varStatus="status">
                                <div class="tab-content ${status.first ? 'block' : 'hidden'}"
                                     id="course-${course.id}"
                                     role="tabpanel">
                                    <h6 class="text-lg font-medium text-gray-900 mb-4">${course.name}</h6>
                                    <c:choose>
                                        <c:when test="${not empty attendanceByCourse[course.id]}">
                                            <div class="overflow-x-auto">
                                                <table class="min-w-full divide-y divide-gray-200">
                                                    <thead class="bg-gray-50">
                                                        <tr>
                                                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date</th>
                                                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Day</th>
                                                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody class="bg-white divide-y divide-gray-200">
                                                        <c:forEach items="${attendanceByCourse[course.id]}" var="attendance">
                                                            <tr>
                                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                                                    <fmt:formatDate value="${attendance.date}" pattern="yyyy-MM-dd" />
                                                                </td>
                                                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                                                    <fmt:formatDate value="${attendance.date}" pattern="EEEE" />
                                                                </td>
                                                                <td class="px-6 py-4 whitespace-nowrap">
                                                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium
                                                                        ${attendance.status == 'Present' ? 'bg-green-100 text-green-800' : 
                                                                        attendance.status == 'Late' ? 'bg-yellow-100 text-yellow-800' : 
                                                                        'bg-red-100 text-red-800'}">
                                                                        ${attendance.status}
                                                                    </span>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>

                                            <!-- Attendance Statistics -->
                                            <div class="mt-8 bg-white rounded-lg border border-gray-200 shadow-sm">
                                                <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                                                    <h6 class="text-lg font-medium text-gray-900">Attendance Statistics</h6>
                                                </div>
                                                <div class="p-6">
                                                    <c:set var="presentCount" value="0" />
                                                    <c:set var="lateCount" value="0" />
                                                    <c:set var="absentCount" value="0" />
                                                    
                                                    <c:forEach items="${attendanceByCourse[course.id]}" var="attendance">
                                                        <c:choose>
                                                            <c:when test="${attendance.status == 'Present'}">
                                                                <c:set var="presentCount" value="${presentCount + 1}" />
                                                            </c:when>
                                                            <c:when test="${attendance.status == 'Late'}">
                                                                <c:set var="lateCount" value="${lateCount + 1}" />
                                                            </c:when>
                                                            <c:when test="${attendance.status == 'Absent'}">
                                                                <c:set var="absentCount" value="${absentCount + 1}" />
                                                            </c:when>
                                                        </c:choose>
                                                    </c:forEach>
                                                    
                                                    <c:set var="totalDays" value="${presentCount + lateCount + absentCount}" />
                                                    
                                                    <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                                                        <div class="bg-gray-50 rounded-lg p-4 text-center">
                                                            <div class="text-2xl font-bold text-gray-900">${totalDays}</div>
                                                            <div class="text-sm text-gray-500">Total Classes</div>
                                                        </div>
                                                        <div class="bg-green-50 rounded-lg p-4 text-center">
                                                            <div class="text-2xl font-bold text-green-700">${presentCount}</div>
                                                            <div class="text-sm text-green-600">Present</div>
                                                        </div>
                                                        <div class="bg-yellow-50 rounded-lg p-4 text-center">
                                                            <div class="text-2xl font-bold text-yellow-700">${lateCount}</div>
                                                            <div class="text-sm text-yellow-600">Late</div>
                                                        </div>
                                                        <div class="bg-red-50 rounded-lg p-4 text-center">
                                                            <div class="text-2xl font-bold text-red-700">${absentCount}</div>
                                                            <div class="text-sm text-red-600">Absent</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="rounded-md bg-blue-50 p-4">
                                                <div class="flex">
                                                    <div class="ml-3">
                                                        <p class="text-sm text-blue-700">
                                                            No attendance records available for this course yet.
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
    
    <jsp:include page="../includes/footer.jsp" />
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
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
        });
    </script>
</body>
</html>
