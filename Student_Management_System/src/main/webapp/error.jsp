<%-- 
    Document   : error
    Created on : May 10, 2025, 1:38:21 PM
    Author     : Nilesh
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Student Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
    <jsp:include page="includes/header.jsp" />
    
    <div class="min-h-screen flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
        <div class="max-w-md w-full">
            <div class="bg-white shadow-lg rounded-lg overflow-hidden">
                <div class="bg-red-600 px-4 py-5 sm:px-6">
                    <h3 class="text-center text-xl leading-6 font-medium text-white">
                        Error
                    </h3>
                </div>
                <div class="px-4 py-8 sm:px-6 text-center">
                    <div class="flex justify-center mb-6">
                        <svg class="h-16 w-16 text-red-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                        </svg>
                    </div>
                    <h4 class="text-lg font-semibold text-gray-900 mb-2">An error has occurred</h4>
                    <p class="text-gray-600 mb-8">${errorMessage != null ? errorMessage : 'Something went wrong. Please try again later.'}</p>
                    <a href="${pageContext.request.contextPath}/" 
                        class="inline-flex items-center px-4 py-2 border border-transparent text-base font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                        Go to Home
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="includes/footer.jsp" />
</body>
</html>
