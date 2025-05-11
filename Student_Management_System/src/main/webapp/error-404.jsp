<%-- 
    Document   : error-404
    Created on : May 10, 2025, 1:38:33 PM
    Author     : Nilesh
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 Not Found - Student Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50">
    <jsp:include page="includes/header.jsp" />
    
    <div class="min-h-screen flex items-center justify-center py-12 px-4 sm:px-6 lg:px-8">
        <div class="max-w-md w-full">
            <div class="bg-white shadow-lg rounded-lg overflow-hidden">
                <div class="bg-yellow-500 px-4 py-5 sm:px-6">
                    <h3 class="text-center text-xl leading-6 font-medium text-white">
                        404 - Page Not Found
                    </h3>
                </div>
                <div class="px-4 py-12 sm:px-6 text-center">
                    <div class="flex justify-center mb-6">
                        <svg class="h-24 w-24 text-yellow-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9.172 16.172a4 4 0 015.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                    </div>
                    <h1 class="text-6xl font-bold text-yellow-500 mb-4">404</h1>
                    <p class="text-xl text-gray-600 mb-8">The page you are looking for does not exist or has been moved.</p>
                    <a href="${pageContext.request.contextPath}/" 
                        class="inline-flex items-center px-6 py-3 border border-transparent text-base font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                        Go to Home
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="includes/footer.jsp" />
</body>
</html>
