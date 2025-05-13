<%-- 
    Document   : edit-student
    Created on : May 10, 2025, 1:43:23 PM
    Author     : Nilesh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Student - Student Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
    <jsp:include page="../includes/header.jsp" />
    
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <h2 class="text-2xl font-bold text-gray-900 mb-6">Edit Student</h2>
        
        <div class="bg-white shadow-lg rounded-lg overflow-hidden">
            <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                <h3 class="text-lg font-medium text-gray-900">Edit Student Information</h3>
            </div>
            <div class="px-4 py-5 sm:p-6">
                <form action="${pageContext.request.contextPath}/admin/edit-student" method="post">
                    <input type="hidden" name="id" value="${student.id}">
                    
                    <div class="grid grid-cols-1 gap-y-6 gap-x-4 sm:grid-cols-2">
                        <div>
                            <label for="firstName" class="block text-sm font-medium text-gray-700">First Name</label>
                            <input type="text" id="firstName" name="firstName" value="${student.firstName}" required
                                class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                        </div>
                        
                        <div>
                            <label for="lastName" class="block text-sm font-medium text-gray-700">Last Name</label>
                            <input type="text" id="lastName" name="lastName" value="${student.lastName}" required
                                class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                        </div>
                        
                        <div>
                            <label for="email" class="block text-sm font-medium text-gray-700">Email</label>
                            <input type="email" id="email" name="email" value="${user.email}" required
                                class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                        </div>
                        
                        <div>
                            <label for="dob" class="block text-sm font-medium text-gray-700">Date of Birth</label>
                            <input type="date" id="dob" name="dob" value="<fmt:formatDate value="${student.dob}" pattern="yyyy-MM-dd" />"
                                class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                        </div>
                        
                        <div>
                            <label for="gender" class="block text-sm font-medium text-gray-700">Gender</label>
                            <select id="gender" name="gender"
                                class="mt-1 block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                                <option value="">Select Gender</option>
                                <option value="Male" ${student.gender == 'Male' ? 'selected' : ''}>Male</option>
                                <option value="Female" ${student.gender == 'Female' ? 'selected' : ''}>Female</option>
                                <option value="Other" ${student.gender == 'Other' ? 'selected' : ''}>Other</option>
                            </select>
                        </div>
                        
                        <div>
                            <label for="phone" class="block text-sm font-medium text-gray-700">Phone Number</label>
                            <input type="text" id="phone" name="phone" value="${student.phone}"
                                class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">
                        </div>
                    </div>
                    
                    <div class="mt-6">
                        <label for="address" class="block text-sm font-medium text-gray-700">Address</label>
                        <textarea id="address" name="address" rows="3"
                            class="mt-1 focus:ring-indigo-500 focus:border-indigo-500 block w-full shadow-sm sm:text-sm border-gray-300 rounded-md">${student.address}</textarea>
                    </div>
                    
                    <div class="mt-6 flex items-center justify-between">
                        <button type="submit"
                            class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                            Update Student
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/manage-students"
                            class="inline-flex justify-center py-2 px-4 border border-gray-300 shadow-sm text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                            Cancel
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <jsp:include page="../includes/footer.jsp" />
</body>
</html>s