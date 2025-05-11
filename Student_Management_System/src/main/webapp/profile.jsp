<%-- 
    Document   : profile
    Created on : May 10, 2025, 1:37:56 PM
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
    <title>User Profile - Student Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
    <jsp:include page="includes/header.jsp" />
    
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <h2 class="text-2xl font-bold text-gray-900 mb-6">User Profile</h2>
        
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
        
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div class="md:col-span-1">
                <div class="bg-white shadow-lg rounded-lg overflow-hidden">
                    <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                        <h5 class="text-lg font-medium text-gray-900">Account Information</h5>
                    </div>
                    <div class="p-6">
                        <dl class="space-y-4">
                            <div>
                                <dt class="text-sm font-medium text-gray-500">Username</dt>
                                <dd class="mt-1 text-sm text-gray-900">${user.username}</dd>
                            </div>
                            <div>
                                <dt class="text-sm font-medium text-gray-500">Email</dt>
                                <dd class="mt-1 text-sm text-gray-900">${user.email}</dd>
                            </div>
                            <div>
                                <dt class="text-sm font-medium text-gray-500">Role</dt>
                                <dd class="mt-1 text-sm text-gray-900">${user.role}</dd>
                            </div>
                            <div>
                                <dt class="text-sm font-medium text-gray-500">Account Created</dt>
                                <dd class="mt-1 text-sm text-gray-900"><fmt:formatDate value="${user.createdAt}" pattern="yyyy-MM-dd" /></dd>
                            </div>
                        </dl>
                        
                        <div class="mt-6 space-y-3">
                            <button type="button" onclick="openModal('changePasswordModal')"
                                    class="w-full inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                                Change Password
                            </button>
                            <button type="button" onclick="openModal('changeEmailModal')"
                                    class="w-full inline-flex justify-center py-2 px-4 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                                Update Email
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="md:col-span-2">
                <div class="bg-white shadow-lg rounded-lg overflow-hidden">
                    <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                        <h5 class="text-lg font-medium text-gray-900">Personal Information</h5>
                    </div>
                    <div class="p-6">
                        <c:choose>
                            <c:when test="${user.role eq 'student' && student != null}">
                                <form action="${pageContext.request.contextPath}/profile/update-student" method="post">
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                        <div>
                                            <label for="firstName" class="block text-sm font-medium text-gray-700">First Name</label>
                                            <input type="text" id="firstName" name="firstName" value="${student.firstName}" required
                                                   class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                                        </div>
                                        <div>
                                            <label for="lastName" class="block text-sm font-medium text-gray-700">Last Name</label>
                                            <input type="text" id="lastName" name="lastName" value="${student.lastName}" required
                                                   class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                                        </div>
                                        <div>
                                            <label for="dob" class="block text-sm font-medium text-gray-700">Date of Birth</label>
                                            <input type="date" id="dob" name="dob" value="<fmt:formatDate value="${student.dob}" pattern="yyyy-MM-dd" />"
                                                   class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                                        </div>
                                        <div>
                                            <label for="gender" class="block text-sm font-medium text-gray-700">Gender</label>
                                            <select id="gender" name="gender"
                                                    class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md">
                                                <option value="">Select Gender</option>
                                                <option value="Male" ${student.gender == 'Male' ? 'selected' : ''}>Male</option>
                                                <option value="Female" ${student.gender == 'Female' ? 'selected' : ''}>Female</option>
                                                <option value="Other" ${student.gender == 'Other' ? 'selected' : ''}>Other</option>
                                            </select>
                                        </div>
                                    </div>
                                    
                                    <div class="mt-6">
                                        <label for="address" class="block text-sm font-medium text-gray-700">Address</label>
                                        <textarea id="address" name="address" rows="2"
                                                  class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">${student.address}</textarea>
                                    </div>
                                    
                                    <div class="mt-6">
                                        <label for="phone" class="block text-sm font-medium text-gray-700">Phone Number</label>
                                        <input type="text" id="phone" name="phone" value="${student.phone}"
                                               class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                                    </div>
                                    
                                    <div class="mt-6">
                                        <button type="submit"
                                                class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                                            Update Profile
                                        </button>
                                    </div>
                                </form>
                            </c:when>
                            <c:when test="${user.role eq 'teacher' && teacher != null}">
                                <form action="${pageContext.request.contextPath}/profile/update-teacher" method="post">
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                        <div>
                                            <label for="firstName" class="block text-sm font-medium text-gray-700">First Name</label>
                                            <input type="text" id="firstName" name="firstName" value="${teacher.firstName}" required
                                                   class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                                        </div>
                                        <div>
                                            <label for="lastName" class="block text-sm font-medium text-gray-700">Last Name</label>
                                            <input type="text" id="lastName" name="lastName" value="${teacher.lastName}" required
                                                   class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                                        </div>
                                        <div>
                                            <label for="dob" class="block text-sm font-medium text-gray-700">Date of Birth</label>
                                            <input type="date" id="dob" name="dob" value="<fmt:formatDate value="${teacher.dob}" pattern="yyyy-MM-dd" />"
                                                   class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                                        </div>
                                        <div>
                                            <label for="gender" class="block text-sm font-medium text-gray-700">Gender</label>
                                            <select id="gender" name="gender"
                                                    class="mt-1 block w-full pl-3 pr-10 py-2 text-base border-gray-300 focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm rounded-md">
                                                <option value="">Select Gender</option>
                                                <option value="Male" ${teacher.gender == 'Male' ? 'selected' : ''}>Male</option>
                                                <option value="Female" ${teacher.gender == 'Female' ? 'selected' : ''}>Female</option>
                                                <option value="Other" ${teacher.gender == 'Other' ? 'selected' : ''}>Other</option>
                                            </select>
                                        </div>
                                    </div>
                                    
                                    <div class="mt-6">
                                        <label for="address" class="block text-sm font-medium text-gray-700">Address</label>
                                        <textarea id="address" name="address" rows="2"
                                                  class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">${teacher.address}</textarea>
                                    </div>
                                    
                                    <div class="mt-6">
                                        <label for="phone" class="block text-sm font-medium text-gray-700">Phone Number</label>
                                        <input type="text" id="phone" name="phone" value="${teacher.phone}"
                                               class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                                    </div>
                                    
                                    <div class="mt-6">
                                        <label for="qualification" class="block text-sm font-medium text-gray-700">Qualifications</label>
                                        <textarea id="qualification" name="qualification" rows="2"
                                                  class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">${teacher.qualification}</textarea>
                                    </div>
                                    
                                    <div class="mt-6">
                                        <button type="submit"
                                                class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                                            Update Profile
                                        </button>
                                    </div>
                                </form>
                            </c:when>
                            <c:when test="${user.role eq 'admin'}">
                                <div class="rounded-md bg-blue-50 p-4 mb-6">
                                    <p class="text-sm text-blue-700">As an administrator, you can manage all aspects of the system.</p>
                                    <p class="mt-2 text-sm text-blue-700">Use the navigation menu to access different management sections.</p>
                                </div>
                                <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                                    <div class="bg-white rounded-lg border border-gray-200 shadow-sm p-6 text-center">
                                        <svg class="h-12 w-12 text-indigo-600 mx-auto mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" />
                                        </svg>
                                        <h5 class="text-lg font-medium text-gray-900 mb-2">Manage Students</h5>
                                        <a href="${pageContext.request.contextPath}/admin/manage-students"
                                           class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700">
                                            Go
                                        </a>
                                    </div>
                                    <div class="bg-white rounded-lg border border-gray-200 shadow-sm p-6 text-center">
                                        <svg class="h-12 w-12 text-indigo-600 mx-auto mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" />
                                        </svg>
                                        <h5 class="text-lg font-medium text-gray-900 mb-2">Manage Teachers</h5>
                                        <a href="${pageContext.request.contextPath}/admin/manage-teachers"
                                           class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700">
                                            Go
                                        </a>
                                    </div>
                                    <div class="bg-white rounded-lg border border-gray-200 shadow-sm p-6 text-center">
                                        <svg class="h-12 w-12 text-indigo-600 mx-auto mb-4" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253" />
                                        </svg>
                                        <h5 class="text-lg font-medium text-gray-900 mb-2">Manage Courses</h5>
                                        <a href="${pageContext.request.contextPath}/admin/manage-courses"
                                           class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700">
                                            Go
                                        </a>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="rounded-md bg-yellow-50 p-4">
                                    <div class="flex">
                                        <div class="flex-shrink-0">
                                            <svg class="h-5 w-5 text-yellow-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                                            </svg>
                                        </div>
                                        <div class="ml-3">
                                            <p class="text-sm text-yellow-700">No profile information available.</p>
                                        </div>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Change Password Modal -->
    <div id="changePasswordModal" class="fixed inset-0 bg-gray-500 bg-opacity-75 hidden">
        <div class="flex items-center justify-center min-h-screen">
            <div class="bg-white rounded-lg overflow-hidden shadow-xl max-w-lg w-full">
                <div class="px-4 py-5 sm:px-6 border-b border-gray-200 flex justify-between items-center">
                    <h3 class="text-lg font-medium text-gray-900">Change Password</h3>
                    <button type="button" onclick="closeModal('changePasswordModal')" class="text-gray-400 hover:text-gray-500">
                        <span class="sr-only">Close</span>
                        <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                        </svg>
                    </button>
                </div>
                <form action="${pageContext.request.contextPath}/profile/change-password" method="post">
                    <div class="px-4 py-5 sm:p-6">
                        <div class="space-y-4">
                            <div>
                                <label for="currentPassword" class="block text-sm font-medium text-gray-700">Current Password</label>
                                <input type="password" id="currentPassword" name="currentPassword" required
                                       class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                            </div>
                            <div>
                                <label for="newPassword" class="block text-sm font-medium text-gray-700">New Password</label>
                                <input type="password" id="newPassword" name="newPassword" required
                                       class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                            </div>
                            <div>
                                <label for="confirmPassword" class="block text-sm font-medium text-gray-700">Confirm New Password</label>
                                <input type="password" id="confirmPassword" name="confirmPassword" required
                                       class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                            </div>
                        </div>
                    </div>
                    <div class="px-4 py-3 bg-gray-50 text-right sm:px-6">
                        <button type="submit"
                                class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                            Change Password
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Change Email Modal -->
    <div id="changeEmailModal" class="fixed inset-0 bg-gray-500 bg-opacity-75 hidden">
        <div class="flex items-center justify-center min-h-screen">
            <div class="bg-white rounded-lg overflow-hidden shadow-xl max-w-lg w-full">
                <div class="px-4 py-5 sm:px-6 border-b border-gray-200 flex justify-between items-center">
                    <h3 class="text-lg font-medium text-gray-900">Update Email</h3>
                    <button type="button" onclick="closeModal('changeEmailModal')" class="text-gray-400 hover:text-gray-500">
                        <span class="sr-only">Close</span>
                        <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                        </svg>
                    </button>
                </div>
                <form action="${pageContext.request.contextPath}/profile/update-email" method="post">
                    <div class="px-4 py-5 sm:p-6">
                        <div class="space-y-4">
                            <div>
                                <label for="currentEmail" class="block text-sm font-medium text-gray-700">Current Email</label>
                                <input type="email" id="currentEmail" value="${user.email}" readonly
                                       class="mt-1 block w-full border-gray-300 rounded-md shadow-sm bg-gray-50 sm:text-sm">
                            </div>
                            <div>
                                <label for="newEmail" class="block text-sm font-medium text-gray-700">New Email</label>
                                <input type="email" id="newEmail" name="newEmail" required
                                       class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                            </div>
                            <div>
                                <label for="password" class="block text-sm font-medium text-gray-700">Password (to confirm)</label>
                                <input type="password" id="password" name="password" required
                                       class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                            </div>
                        </div>
                    </div>
                    <div class="px-4 py-3 bg-gray-50 text-right sm:px-6">
                        <button type="submit"
                                class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                            Update Email
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <jsp:include page="includes/footer.jsp" />
    
    <script>
        // Modal functions
        function openModal(modalId) {
            document.getElementById(modalId).classList.remove('hidden');
        }
        
        function closeModal(modalId) {
            document.getElementById(modalId).classList.add('hidden');
        }
        
        // Password confirmation validation
        document.addEventListener('DOMContentLoaded', function() {
            const newPasswordField = document.getElementById('newPassword');
            const confirmPasswordField = document.getElementById('confirmPassword');
            
            if (newPasswordField && confirmPasswordField) {
                const validatePasswords = function() {
                    if (newPasswordField.value !== confirmPasswordField.value) {
                        confirmPasswordField.setCustomValidity("Passwords don't match");
                    } else {
                        confirmPasswordField.setCustomValidity('');
                    }
                };
                
                newPasswordField.addEventListener('input', validatePasswords);
                confirmPasswordField.addEventListener('input', validatePasswords);
            }
        });
    </script>
</body>
</html>