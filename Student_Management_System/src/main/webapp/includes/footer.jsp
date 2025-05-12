<%-- 
    Document   : footer
    Created on : May 10, 2025, 1:41:30 PM
    Author     : Nilesh
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<footer class="bg-gray-800 text-white mt-10">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div>
                <h5 class="text-lg font-semibold mb-4">Student Management System</h5>
                <p class="text-gray-300">A comprehensive system for managing student records, courses, grades, and attendance.</p>
            </div>
            <div>
                <h5 class="text-lg font-semibold mb-4">Quick Links</h5>
                <ul class="space-y-2">
                    <li><a href="${pageContext.request.contextPath}/" class="text-gray-300 hover:text-white transition-colors">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/login" class="text-gray-300 hover:text-white transition-colors">Login</a></li>
                    <li><a href="${pageContext.request.contextPath}/register" class="text-gray-300 hover:text-white transition-colors">Register</a></li>
                </ul>
            </div>
            <div>
                <h5 class="text-lg font-semibold mb-4">Contact</h5>
                <address class="text-gray-300 not-italic">
                    <p class="mb-2">Email: <a href="mailto:info@sms.edu" class="hover:text-white transition-colors">info@sms.edu</a></p>
                    <p>Phone: +1 (123) 456-7890</p>
                </address>
            </div>
        </div>
        <div class="border-t border-gray-700 mt-8 pt-8 text-center">
            <p class="text-gray-300">&copy; <%= java.time.Year.now() %> Student Management System. All rights reserved.</p>
        </div>
    </div>
</footer>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
