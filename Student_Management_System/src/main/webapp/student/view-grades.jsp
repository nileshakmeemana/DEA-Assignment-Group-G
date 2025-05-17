<%-- 
    Document   : view-grades
    Created on : May 10, 2025, 1:47:06 PM
    Author     : Nilesh
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Grades - Student Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
    <jsp:include page="../includes/header.jsp" />
    
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <h2 class="text-2xl font-bold text-gray-900 mb-6">My Grades</h2>
        
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
                <h5 class="text-lg font-medium text-gray-900">Course Grades</h5>
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
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Assignment Score</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Midterm Score</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Final Score</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Total Score</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Grade</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Grade Point</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Credits Earned</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <c:forEach items="${enrolledCourses}" var="course">
                                    <c:set var="grade" value="${courseGradeMap[course.id]}" />
                                    <tr>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${course.code}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${course.name}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${course.creditHours}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                            ${grade != null && grade.assignmentScore != null ? grade.assignmentScore : 'N/A'}
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                            ${grade != null && grade.midtermScore != null ? grade.midtermScore : 'N/A'}
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                            ${grade != null && grade.finalScore != null ? grade.finalScore : 'N/A'}
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                            ${grade != null && grade.totalScore != null ? grade.totalScore : 'N/A'}
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <c:choose>
                                                <c:when test="${grade != null && grade.grade != null}">
                                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium
                                                        ${grade.grade == 'A' ? 'bg-green-100 text-green-800' : 
                                                        grade.grade == 'B' ? 'bg-blue-100 text-blue-800' : 
                                                        grade.grade == 'C' ? 'bg-indigo-100 text-indigo-800' : 
                                                        grade.grade == 'D' ? 'bg-yellow-100 text-yellow-800' : 'bg-red-100 text-red-800'}">
                                                        ${grade.grade}
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-800">
                                                        Not Graded
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                            ${grade != null && grade.gradePoint != null ? grade.gradePoint : 'N/A'}
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                            ${earnedCreditsMap[course.id] != null ? earnedCreditsMap[course.id] : '0'}
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <c:choose>
                                                <c:when test="${grade != null}">
                                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium
                                                        ${grade.academicStatus == 'Excellent' ? 'bg-green-100 text-green-800' : 
                                                        grade.academicStatus == 'Very Good' ? 'bg-blue-100 text-blue-800' : 
                                                        grade.academicStatus == 'Good' ? 'bg-indigo-100 text-indigo-800' : 
                                                        grade.academicStatus == 'Satisfactory' ? 'bg-gray-100 text-gray-800' : 
                                                        grade.academicStatus == 'Poor' ? 'bg-yellow-100 text-yellow-800' : 'bg-red-100 text-red-800'}">
                                                        ${grade.academicStatus}
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-800">
                                                        Not Available
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    
                    <div class="mt-8 grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <canvas id="gradeChart" class="w-full"></canvas>
                        </div>
                        <div class="bg-white rounded-lg border border-gray-200 p-6">
                            <h6 class="text-lg font-medium text-gray-900 mb-4">Grade Legend</h6>
                            <ul class="space-y-3">
                                <li class="flex justify-between items-center">
                                    <span class="text-sm text-gray-600">A (90-100) - 4.0 Points</span>
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-green-100 text-green-800">Excellent</span>
                                </li>
                                <li class="flex justify-between items-center">
                                    <span class="text-sm text-gray-600">B (80-89) - 3.0 Points</span>
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-blue-100 text-blue-800">Good</span>
                                </li>
                                <li class="flex justify-between items-center">
                                    <span class="text-sm text-gray-600">C (70-79) - 2.0 Points</span>
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-indigo-100 text-indigo-800">Average</span>
                                </li>
                                <li class="flex justify-between items-center">
                                    <span class="text-sm text-gray-600">D (60-69) - 1.0 Points</span>
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800">Poor</span>
                                </li>
                                <li class="flex justify-between items-center">
                                    <span class="text-sm text-gray-600">F (0-59) - 0.0 Points</span>
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-red-100 text-red-800">Failing</span>
                                </li>
                            </ul>
                        </div>
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
                                <div class="mt-4">
                                    <a href="${pageContext.request.contextPath}/student/course-registration" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-blue-700 bg-blue-100 hover:bg-blue-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                        Register for Courses
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    
    <jsp:include page="../includes/footer.jsp" />
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const gradeCanvas = document.getElementById('gradeChart');
            
            if (gradeCanvas) {
                let gradeA = 0, gradeB = 0, gradeC = 0, gradeD = 0, gradeF = 0, notGraded = 0;
                
                <c:forEach items="${enrolledCourses}" var="course">
                    <c:set var="grade" value="${courseGradeMap[course.id]}" />
                    <c:choose>
                        <c:when test="${grade != null && grade.grade != null}">
                            <c:choose>
                                <c:when test="${grade.grade == 'A'}">
                                    gradeA++;
                                </c:when>
                                <c:when test="${grade.grade == 'B'}">
                                    gradeB++;
                                </c:when>
                                <c:when test="${grade.grade == 'C'}">
                                    gradeC++;
                                </c:when>
                                <c:when test="${grade.grade == 'D'}">
                                    gradeD++;
                                </c:when>
                                <c:when test="${grade.grade == 'F'}">
                                    gradeF++;
                                </c:when>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            notGraded++;
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                
                const gradeChart = new Chart(gradeCanvas, {
                    type: 'pie',
                    data: {
                        labels: ['A', 'B', 'C', 'D', 'F', 'Not Graded'],
                        datasets: [{
                            data: [gradeA, gradeB, gradeC, gradeD, gradeF, notGraded],
                            backgroundColor: [
                                '#34D399', // Green
                                '#60A5FA', // Blue
                                '#818CF8', // Indigo
                                '#FBBF24', // Yellow
                                '#F87171', // Red
                                '#9CA3AF'  // Gray
                            ]
                        }]
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            legend: {
                                position: 'bottom'
                            },
                            title: {
                                display: true,
                                text: 'Grade Distribution',
                                color: '#111827',
                                font: {
                                    size: 16,
                                    weight: 'bold'
                                }
                            }
                        }
                    }
                });
            }
        });
    </script>
</body>
</html>

