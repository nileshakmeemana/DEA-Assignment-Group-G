<%-- 
    Document   : assign-teacher
    Created on : May 10, 2025, 1:42:09 PM
    Author     : Nilesh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assign Teacher - Student Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
    <jsp:include page="../includes/header.jsp" />
    
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <h2 class="text-2xl font-bold text-gray-900 mb-6">Assign Teacher to Course</h2>
        
        <div class="bg-white shadow-lg rounded-lg overflow-hidden">
            <div class="px-4 py-5 sm:px-6 border-b border-gray-200">
                <h3 class="text-lg font-medium text-gray-900">Assign Teacher to ${course.code} - ${course.name}</h3>
            </div>
            <div class="px-4 py-5 sm:p-6">
                <form action="${pageContext.request.contextPath}/admin/assign-teacher" method="post">
                    <input type="hidden" name="courseId" value="${course.id}">
                    
                    <div class="mb-6">
                        <label for="teacherId" class="block text-sm font-medium text-gray-700">Select Teacher</label>
                        <select id="teacherId" name="teacherId"
                            class="mt-1 block w-full py-2 px-3 border border-gray-300 bg-white rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm">
                            <option value="">None (Remove current teacher)</option>
                            <c:forEach items="${teachers}" var="teacher">
                                <option value="${teacher.id}" ${course.teacherId == teacher.id ? 'selected' : ''}>${teacher.firstName} ${teacher.lastName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="flex items-center justify-between">
                        <button type="submit"
                            class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                            Assign Teacher
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/manage-courses"
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
</html>