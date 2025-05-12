<%-- 
    Document   : register
    Created on : May 10, 2025, 1:38:06 PM
    Author     : Nilesh
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Student Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
    <jsp:include page="includes/header.jsp" />
    
    <div class="min-h-screen py-12 px-4 sm:px-6 lg:px-8">
        <div class="max-w-3xl mx-auto">
            <div class="bg-white shadow-lg rounded-lg overflow-hidden">
                <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                    <h2 class="text-2xl font-semibold text-gray-800 text-center">Create your account</h2>
                </div>

                <div class="px-4 py-6 sm:p-6">
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
                    
                    <form action="register" method="post" id="registrationForm" class="space-y-6">
                        <div>
                            <label for="role" class="block text-sm font-medium text-gray-700">Register as</label>
                            <select id="role" name="role" required onchange="toggleFields()" 
                                class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 rounded-md">
                                <option value="">Select Role</option>
                                <option value="student">Student</option>
                                <option value="teacher">Teacher</option>
                            </select>
                        </div>
                        
                        <div class="grid grid-cols-1 gap-y-6 gap-x-4 sm:grid-cols-2">
                            <div>
                                <label for="username" class="block text-sm font-medium text-gray-700">Username</label>
                                <input type="text" id="username" name="username" required 
                                    class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500">
                            </div>
                            <div>
                                <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                                <input type="email" id="email" name="email" required 
                                    class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500">
                            </div>
                            <div>
                                <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                                <input type="password" id="password" name="password" required 
                                    class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500">
                            </div>
                            <div>
                                <label for="confirmPassword" class="block text-sm font-medium text-gray-700">Confirm Password</label>
                                <input type="password" id="confirmPassword" name="confirmPassword" required 
                                    class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500">
                            </div>
                        </div>

                        <!-- Additional fields that show based on role selection -->
                        <div id="additionalFields" class="hidden space-y-6">
                            <div class="grid grid-cols-1 gap-y-6 gap-x-4 sm:grid-cols-2">
                                <div>
                                    <label for="firstName" class="block text-sm font-medium text-gray-700">First Name</label>
                                    <input type="text" id="firstName" name="firstName" 
                                        class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500">
                                </div>
                                <div>
                                    <label for="lastName" class="block text-sm font-medium text-gray-700">Last Name</label>
                                    <input type="text" id="lastName" name="lastName" 
                                        class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500">
                                </div>
                                <div>
                                    <label for="dob" class="block text-sm font-medium text-gray-700">Date of Birth</label>
                                    <input type="date" id="dob" name="dob" 
                                        class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500">
                                </div>
                                <div>
                                    <label for="gender" class="block text-sm font-medium text-gray-700">Gender</label>
                                    <select id="gender" name="gender" 
                                        class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 rounded-md">
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
                                    class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"></textarea>
                            </div>

                            <div>
                                <label for="phone" class="block text-sm font-medium text-gray-700">Phone Number</label>
                                <input type="text" id="phone" name="phone" 
                                    class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500">
                            </div>

                            <!-- Teacher-specific field -->
                            <div id="qualificationField" class="hidden">
                                <label for="qualification" class="block text-sm font-medium text-gray-700">Qualifications</label>
                                <textarea id="qualification" name="qualification" rows="2" 
                                    class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm py-2 px-3 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500"></textarea>
                            </div>
                        </div>

                        <div>
                            <button type="submit" 
                                class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                                Register
                            </button>
                        </div>
                    </form>

                    <div class="mt-6 text-center">
                        <p class="text-sm text-gray-600">
                            Already have an account? 
                            <a href="login" class="font-medium text-indigo-600 hover:text-indigo-500">
                                Login here
                            </a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="includes/footer.jsp" />
    
    <script>
        function toggleFields() {
            const role = document.getElementById('role').value;
            const additionalFields = document.getElementById('additionalFields');
            const qualificationField = document.getElementById('qualificationField');
            
            if (role === 'student' || role === 'teacher') {
                additionalFields.classList.remove('hidden');
                
                if (role === 'teacher') {
                    qualificationField.classList.remove('hidden');
                } else {
                    qualificationField.classList.add('hidden');
                }
            } else {
                additionalFields.classList.add('hidden');
            }
        }
    </script>
</body>
</html>


