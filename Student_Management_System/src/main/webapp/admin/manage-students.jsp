<%-- 
    Document   : manage-students
    Created on : May 10, 2025, 1:44:50 PM
    Author     : Nilesh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Students - Student Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
    <jsp:include page="../includes/header.jsp" />
    
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <h2 class="text-2xl font-bold text-gray-900 mb-6">Manage Students</h2>
        
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
                <h3 class="text-lg leading-6 font-medium text-gray-900">Student List</h3>
                <button type="button" class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" onclick="document.getElementById('addStudentModal').classList.remove('hidden')">
                    Add New Student
                </button>
            </div>
            <div class="px-4 py-5 sm:p-6">
                <div class="mb-4">
                    <input type="text" class="shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md" id="studentSearch" placeholder="Search students...">
                </div>
                
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200" id="studentTable">
                        <thead class="bg-gray-50">
                            <tr>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Email</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Gender</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Phone</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Enrollment Date</th>
                                <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <c:forEach items="${students}" var="student">
                                <tr>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${student.id}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${student.firstName} ${student.lastName}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${userMap[student.id].email}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${student.gender}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${student.phone}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                        <fmt:formatDate value="${student.enrollmentDate}" pattern="yyyy-MM-dd" />
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium space-x-2">
                                        <a href="${pageContext.request.contextPath}/admin/edit-student?id=${student.id}" 
                                           class="text-indigo-600 hover:text-indigo-900">Edit</a>
                                        <a href="${pageContext.request.contextPath}/admin/delete-student?id=${student.id}" 
                                           class="text-red-600 hover:text-red-900"
                                           onclick="return confirmDelete('Are you sure you want to delete this student?')">Delete</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Add Student Modal -->
    <div id="addStudentModal" class="fixed inset-0 overflow-y-auto hidden" aria-labelledby="modal-title" role="dialog" aria-modal="true">
        <div class="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
            <div class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" aria-hidden="true"></div>
            <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>
            <div class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full">
                <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
                    <div class="sm:flex sm:items-start">
                        <div class="mt-3 text-center sm:mt-0 sm:text-left w-full">
                            <h3 class="text-lg leading-6 font-medium text-gray-900" id="modal-title">Add New Student</h3>
                            <div class="mt-4">
                                <form action="${pageContext.request.contextPath}/admin/add-student" method="post" class="space-y-4">
                                    <div class="grid grid-cols-2 gap-4">
                                        <div>
                                            <label for="username" class="block text-sm font-medium text-gray-700">Username</label>
                                            <input type="text" id="username" name="username" required
                                                   class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                                        </div>
                                        <div>
                                            <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                                            <input type="email" id="email" name="email" required
                                                   class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                                        </div>
                                    </div>

                                    <div class="grid grid-cols-2 gap-4">
                                        <div>
                                            <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                                            <input type="password" id="password" name="password" required
                                                   class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                                        </div>
                                        <div>
                                            <label for="confirmPassword" class="block text-sm font-medium text-gray-700">Confirm Password</label>
                                            <input type="password" id="confirmPassword" name="confirmPassword" required
                                                   class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                                        </div>
                                    </div>

                                    <div class="grid grid-cols-2 gap-4">
                                        <div>
                                            <label for="firstName" class="block text-sm font-medium text-gray-700">First Name</label>
                                            <input type="text" id="firstName" name="firstName" required
                                                   class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                                        </div>
                                        <div>
                                            <label for="lastName" class="block text-sm font-medium text-gray-700">Last Name</label>
                                            <input type="text" id="lastName" name="lastName" required
                                                   class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                                        </div>
                                    </div>

                                    <div class="grid grid-cols-2 gap-4">
                                        <div>
                                            <label for="dob" class="block text-sm font-medium text-gray-700">Date of Birth</label>
                                            <input type="date" id="dob" name="dob"
                                                   class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                                        </div>
                                        <div>
                                            <label for="gender" class="block text-sm font-medium text-gray-700">Gender</label>
                                            <select id="gender" name="gender"
                                                    class="mt-1 block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                                                <option value="">Select Gender</option>
                                                <option value="Male">Male</option>
                                                <option value="Female">Female</option>
                                                <option value="Other">Other</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div>
                                        <label for="address" class="block text-sm font-medium text-gray-700">Address</label>
                                        <textarea id="address" name="address" rows="2"
                                                  class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md"></textarea>
                                    </div>

                                    <div>
                                        <label for="phone" class="block text-sm font-medium text-gray-700">Phone Number</label>
                                        <input type="text" id="phone" name="phone"
                                               class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                                    </div>

                                    <div class="mt-5 sm:mt-4 sm:flex sm:flex-row-reverse">
                                        <button type="submit"
                                                class="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 bg-indigo-600 text-base font-medium text-white hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:ml-3 sm:w-auto sm:text-sm">
                                            Add Student
                                        </button>
                                        <button type="button"
                                                class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:mt-0 sm:w-auto sm:text-sm"
                                                onclick="document.getElementById('addStudentModal').classList.add('hidden')">
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
            const searchInput = document.getElementById('studentSearch');
            const table = document.getElementById('studentTable');
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
            
            // Password confirmation validation
            const passwordField = document.getElementById('password');
            const confirmPasswordField = document.getElementById('confirmPassword');
            
            if (passwordField && confirmPasswordField) {
                confirmPasswordField.addEventListener('input', function() {
                    if (passwordField.value !== confirmPasswordField.value) {
                        confirmPasswordField.setCustomValidity("Passwords don't match");
                    } else {
                        confirmPasswordField.setCustomValidity('');
                    }
                });
                
                passwordField.addEventListener('input', function() {
                    if (passwordField.value !== confirmPasswordField.value) {
                        confirmPasswordField.setCustomValidity("Passwords don't match");
                    } else {
                        confirmPasswordField.setCustomValidity('');
                    }
                });
            }
        });

        function confirmDelete(message) {
            return confirm(message);
        }
    </script>
</body>
</html>
