<%-- 
    Document   : manage-grades
    Created on : May 10, 2025, 1:48:31 PM
    Author     : Nilesh
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Grades - Student Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
    <jsp:include page="../includes/header.jsp" />
    
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <h2 class="text-2xl font-bold text-gray-900 mb-6">Manage Grades</h2>
        
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
        
        <div class="bg-white shadow-lg rounded-lg overflow-hidden mb-6">
            <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                <h5 class="text-lg font-medium text-gray-900">Select Course</h5>
            </div>
            <div class="p-6">
                <form action="${pageContext.request.contextPath}/teacher/manage-grades" method="get">
                    <div class="mb-4">
                        <label for="courseId" class="block text-sm font-medium text-gray-700 mb-2">Course:</label>
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
            <div class="bg-white shadow-lg rounded-lg overflow-hidden">
                <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                    <h5 class="text-lg font-medium text-gray-900">Grades for ${selectedCourse.code} - ${selectedCourse.name} (${selectedCourse.creditHours} Credits)</h5>
                </div>
                <div class="p-6">
                    <c:if test="${not empty enrolledStudents}">
                        <div class="mb-4">
                            <input type="text" class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" 
                                   id="studentSearch" placeholder="Search students...">
                        </div>
                        
                        <div class="overflow-x-auto">
                            <table class="min-w-full divide-y divide-gray-200" id="studentTable">
                                <thead class="bg-gray-50">
                                    <tr>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Student ID</th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Assignment Score</th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Midterm Score</th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Final Score</th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Total Score</th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Grade</th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Grade Point</th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Credits Earned</th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Academic Status</th>
                                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Action</th>
                                    </tr>
                                </thead>
                                <tbody class="bg-white divide-y divide-gray-200">
                                    <c:forEach items="${enrolledStudents}" var="student">
                                        <tr>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${student.id}</td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${student.firstName} ${student.lastName}</td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${gradeMap[student.id] != null ? gradeMap[student.id].assignmentScore : 'N/A'}</td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${gradeMap[student.id] != null ? gradeMap[student.id].midtermScore : 'N/A'}</td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${gradeMap[student.id] != null ? gradeMap[student.id].finalScore : 'N/A'}</td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${gradeMap[student.id] != null ? gradeMap[student.id].totalScore : 'N/A'}</td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium
                                                    ${gradeMap[student.id] != null && gradeMap[student.id].grade == 'A' ? 'bg-green-100 text-green-800' : 
                                                    gradeMap[student.id] != null && gradeMap[student.id].grade == 'B' ? 'bg-blue-100 text-blue-800' : 
                                                    gradeMap[student.id] != null && gradeMap[student.id].grade == 'C' ? 'bg-indigo-100 text-indigo-800' : 
                                                    gradeMap[student.id] != null && gradeMap[student.id].grade == 'D' ? 'bg-yellow-100 text-yellow-800' : 
                                                    gradeMap[student.id] != null && gradeMap[student.id].grade == 'F' ? 'bg-red-100 text-red-800' : 'bg-gray-100 text-gray-800'}">
                                                    ${gradeMap[student.id] != null ? gradeMap[student.id].grade : 'N/A'}
                                                </span>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${gradeMap[student.id] != null ? gradeMap[student.id].gradePoint : 'N/A'}</td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${earnedCreditsMap[student.id] != null ? earnedCreditsMap[student.id] : '0'}</td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium
                                                    ${academicStatusMap[student.id] == 'Excellent' ? 'bg-green-100 text-green-800' : 
                                                    academicStatusMap[student.id] == 'Very Good' ? 'bg-blue-100 text-blue-800' : 
                                                    academicStatusMap[student.id] == 'Good' ? 'bg-indigo-100 text-indigo-800' : 
                                                    academicStatusMap[student.id] == 'Satisfactory' ? 'bg-gray-100 text-gray-800' : 
                                                    academicStatusMap[student.id] == 'Poor' ? 'bg-yellow-100 text-yellow-800' : 
                                                    academicStatusMap[student.id] == 'Failing' ? 'bg-red-100 text-red-800' : 'bg-gray-100 text-gray-800'}">
                                                    ${academicStatusMap[student.id] != null ? academicStatusMap[student.id] : 'Not Graded'}
                                                </span>
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                                <button type="button" class="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                                                        onclick="openGradeModal('${student.id}')">
                                                    Update Grade
                                                </button>
                                                
                                                <!-- Grade Modal -->
                                                <div id="gradeModal${student.id}" class="hidden fixed inset-0 bg-gray-500 bg-opacity-75 flex items-center justify-center">
                                                    <div class="bg-white rounded-lg overflow-hidden shadow-xl transform transition-all sm:max-w-lg sm:w-full">
                                                        <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
                                                            <div class="sm:flex sm:items-start">
                                                                <div class="mt-3 text-center sm:mt-0 sm:text-left w-full">
                                                                    <h3 class="text-lg leading-6 font-medium text-gray-900 mb-4">
                                                                        Update Grade for ${student.firstName} ${student.lastName}
                                                                    </h3>
                                                                    <form action="${pageContext.request.contextPath}/teacher/update-grade" method="post">
                                                                        <input type="hidden" name="studentId" value="${student.id}">
                                                                        <input type="hidden" name="courseId" value="${selectedCourse.id}">
                                                                        
                                                                        <div class="mb-4">
                                                                            <label for="assignmentScore${student.id}" class="block text-sm font-medium text-gray-700 mb-2">
                                                                                Assignment Score (30%)
                                                                            </label>
                                                                            <input type="number" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                                                                                   id="assignmentScore${student.id}" name="assignmentScore" 
                                                                                   value="${gradeMap[student.id] != null ? gradeMap[student.id].assignmentScore : ''}" 
                                                                                   min="0" max="100" step="0.01">
                                                                        </div>
                                                                        
                                                                        <div class="mb-4">
                                                                            <label for="midtermScore${student.id}" class="block text-sm font-medium text-gray-700 mb-2">
                                                                                Midterm Score (30%)
                                                                            </label>
                                                                            <input type="number" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                                                                                   id="midtermScore${student.id}" name="midtermScore" 
                                                                                   value="${gradeMap[student.id] != null ? gradeMap[student.id].midtermScore : ''}" 
                                                                                   min="0" max="100" step="0.01">
                                                                        </div>
                                                                        
                                                                        <div class="mb-4">
                                                                            <label for="finalScore${student.id}" class="block text-sm font-medium text-gray-700 mb-2">
                                                                                Final Score (40%)
                                                                            </label>
                                                                            <input type="number" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                                                                                   id="finalScore${student.id}" name="finalScore" 
                                                                                   value="${gradeMap[student.id] != null ? gradeMap[student.id].finalScore : ''}" 
                                                                                   min="0" max="100" step="0.01">
                                                                        </div>
                                                                        
                                                                        <div class="mt-5 sm:mt-4 sm:flex sm:flex-row-reverse">
                                                                            <button type="submit" class="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-indigo-600 text-base font-medium text-white hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:ml-3 sm:w-auto sm:text-sm">
                                                                                Save Changes
                                                                            </button>
                                                                            <button type="button" class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:mt-0 sm:w-auto sm:text-sm"
                                                                                    onclick="closeGradeModal('${student.id}')">
                                                                                Cancel
                                                                            </button>
                                                                        </div>
                                                                    </form>
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
                    </c:if>
                    <c:if test="${empty enrolledStudents}">
                        <div class="rounded-md bg-blue-50 p-4">
                            <div class="flex">
                                <div class="flex-shrink-0">
                                    <svg class="h-5 w-5 text-blue-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                                        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd" />
                                    </svg>
                                </div>
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
    
    <jsp:include page="../includes/footer.jsp" />
    
    <script>
        function filterTable(searchInput, tableId) {
            const input = document.getElementById(searchInput);
            const table = document.getElementById(tableId);
            
            input.addEventListener('keyup', function() {
                const filter = input.value.toLowerCase();
                const rows = table.getElementsByTagName('tr');
                
                for (let i = 1; i < rows.length; i++) {
                    const row = rows[i];
                    const cells = row.getElementsByTagName('td');
                    let found = false;
                    
                    for (let j = 0; j < cells.length; j++) {
                        const cell = cells[j];
                        if (cell) {
                            const text = cell.textContent || cell.innerText;
                            if (text.toLowerCase().indexOf(filter) > -1) {
                                found = true;
                                break;
                            }
                        }
                    }
                    
                    row.style.display = found ? '' : 'none';
                }
            });
        }
        
        function openGradeModal(studentId) {
            document.getElementById('gradeModal' + studentId).classList.remove('hidden');
        }
        
        function closeGradeModal(studentId) {
            document.getElementById('gradeModal' + studentId).classList.add('hidden');
        }
        
        document.addEventListener('DOMContentLoaded', function() {
            filterTable('studentSearch', 'studentTable');
        });
    </script>
</body>
</html>
