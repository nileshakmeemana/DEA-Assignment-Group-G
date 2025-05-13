<%-- 
    Document   : manage-courses
    Created on : May 10, 2025, 1:44:32 PM
    Author     : Nilesh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Courses - Student Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
    <jsp:include page="../includes/header.jsp" />
    
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <h2 class="text-2xl font-bold text-gray-900 mb-6">Manage Courses</h2>
        
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
        
        <div class="bg-white shadow rounded-lg">
            <div class="px-4 py-5 border-b border-gray-200 sm:px-6 flex justify-between items-center">
                <h3 class="text-lg leading-6 font-medium text-gray-900">Course List</h3>
                <button type="button" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" onclick="document.getElementById('addCourseModal').classList.remove('hidden')">
                    Add New Course
                </button>
            </div>
            <div class="px-4 py-5 sm:p-6">
                <div class="mb-4">
                    <input type="text" class="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md" id="courseSearch" placeholder="Search courses...">
                </div>
                
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200" id="courseTable">
                        <thead class="bg-gray-50">
                            <tr>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Code</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Credit Hours</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Teacher</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <c:forEach items="${courses}" var="course">
                                <tr>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${course.id}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${course.code}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${course.name}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${course.creditHours}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                        ${teacherNames[course.id] != null ? teacherNames[course.id] : 'Not Assigned'}
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium space-x-2">
                                        <a href="${pageContext.request.contextPath}/admin/edit-course?id=${course.id}" 
                                           class="text-indigo-600 hover:text-indigo-900">Edit</a>
                                        <a href="${pageContext.request.contextPath}/admin/assign-teacher?id=${course.id}" 
                                           class="text-blue-600 hover:text-blue-900">Assign Teacher</a>
                                        <a href="${pageContext.request.contextPath}/admin/delete-course?id=${course.id}" 
                                           class="text-red-600 hover:text-red-900"
                                           onclick="return confirmDelete('Are you sure you want to delete this course?')">Delete</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Add Course Modal -->
    <div id="addCourseModal" class="fixed inset-0 overflow-y-auto hidden" aria-labelledby="modal-title" role="dialog" aria-modal="true">
        <div class="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
            <div class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" aria-hidden="true"></div>
            <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>
            <div class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full">
                <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
                    <div class="sm:flex sm:items-start">
                        <div class="mt-3 text-center sm:mt-0 sm:text-left w-full">
                            <h3 class="text-lg leading-6 font-medium text-gray-900" id="modal-title">Add New Course</h3>
                            <div class="mt-4">
                                <form action="${pageContext.request.contextPath}/admin/add-course" method="post" class="space-y-4">
                                    <div>
                                        <label for="code" class="block text-sm font-medium text-gray-700">Course Code</label>
                                        <input type="text" id="code" name="code" required
                                               class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                                    </div>
                                    
                                    <div>
                                        <label for="name" class="block text-sm font-medium text-gray-700">Course Name</label>
                                        <input type="text" id="name" name="name" required
                                               class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                                    </div>
                                    
                                    <div>
                                        <label for="description" class="block text-sm font-medium text-gray-700">Description</label>
                                        <textarea id="description" name="description" rows="3"
                                                  class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md"></textarea>
                                    </div>
                                    
                                    <div>
                                        <label for="creditHours" class="block text-sm font-medium text-gray-700">Credit Hours</label>
                                        <input type="number" id="creditHours" name="creditHours" min="1" max="6" required
                                               class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                                    </div>
                                    
                                    <div>
                                        <label for="teacherId" class="block text-sm font-medium text-gray-700">Teacher (Optional)</label>
                                        <select id="teacherId" name="teacherId"
                                                class="mt-1 block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                                            <option value="">Select Teacher</option>
                                            <c:forEach items="${teachers}" var="teacher">
                                                <option value="${teacher.id}">${teacher.firstName} ${teacher.lastName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    
                                    <div class="mt-5 sm:mt-4 sm:flex sm:flex-row-reverse">
                                        <button type="submit"
                                                class="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-indigo-600 text-base font-medium text-white hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:ml-3 sm:w-auto sm:text-sm">
                                            Add Course
                                        </button>
                                        <button type="button"
                                                class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:mt-0 sm:w-auto sm:text-sm"
                                                onclick="document.getElementById('addCourseModal').classList.add('hidden')">
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
    
    <jsp:include page="../includes/footer.jsp" />
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Filter table based on search input
            const searchInput = document.getElementById('courseSearch');
            const table = document.getElementById('courseTable');
            const rows = table.getElementsByTagName('tr');

            searchInput.addEventListener('keyup', function() {
                const filter = searchInput.value.toLowerCase();
                
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
        });

        function confirmDelete(message) {
            return confirm(message);
        }
    </script>
</body>
</html>