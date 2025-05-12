<%-- 
    Document   : view-courses
    Created on : May 10, 2025, 1:46:49 PM
    Author     : Nilesh
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Courses</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-800">
<div class="max-w-7xl mx-auto px-6 py-8">

    <h2 class="text-2xl font-bold mb-6">My Courses</h2>

    <div class="bg-white rounded-xl shadow p-6">
        <!-- Header and Register Button -->
        <div class="flex justify-between items-center mb-4">
            <h3 class="text-lg font-semibold">Enrolled Courses</h3>
            <a href="registerCourse.jsp" class="bg-indigo-600 text-white px-4 py-2 rounded hover:bg-indigo-700">
                Register for Courses
            </a>
        </div>

        <!-- Search Field -->
        <input type="text" placeholder="Search courses..." class="w-full mb-4 px-4 py-2 border rounded-md placeholder-gray-400">

        <!-- Table -->
        <div class="overflow-x-auto">
            <table class="min-w-full table-auto border-collapse border border-gray-200">
                <thead class="bg-gray-100">
                    <tr>
                        <th class="border px-4 py-2 text-left">Course Code</th>
                        <th class="border px-4 py-2 text-left">Course Name</th>
                        <th class="border px-4 py-2 text-left">Description</th>
                        <th class="border px-4 py-2 text-center">Credit Hours</th>
                        <th class="border px-4 py-2 text-left">Teacher</th>
                        <th class="border px-4 py-2 text-center">Action</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    String studentId = (String) session.getAttribute("studentId");
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/yourdb", "root", "password");
                        String sql = "SELECT c.course_code, c.course_name, c.description, c.credit_hours, c.teacher " +
                                     "FROM courses c JOIN enrollments e ON c.course_code = e.course_code " +
                                     "WHERE e.student_id = ?";
                        PreparedStatement ps = conn.prepareStatement(sql);
                        ps.setString(1, studentId);
                        ResultSet rs = ps.executeQuery();

                        while (rs.next()) {
                %>
                    <tr class="hover:bg-gray-50">
                        <td class="border px-4 py-2"><%= rs.getString("course_code") %></td>
                        <td class="border px-4 py-2"><%= rs.getString("course_name") %></td>
                        <td class="border px-4 py-2"><%= rs.getString("description") %></td>
                        <td class="border px-4 py-2 text-center"><%= rs.getInt("credit_hours") %></td>
                        <td class="border px-4 py-2"><%= rs.getString("teacher") %></td>
                        <td class="border px-4 py-2 text-center">
                            <form method="post" action="DropCourseServlet">
                                <input type="hidden" name="courseCode" value="<%= rs.getString("course_code") %>" />
                                <button type="submit" class="bg-red-600 text-white px-3 py-1 rounded hover:bg-red-700 text-sm">
                                    Drop Course
                                </button>
                            </form>
                        </td>
                    </tr>
                <%
                        }
                        rs.close();
                        ps.close();
                        conn.close();
                    } catch (Exception e) {
                        out.println("<tr><td colspan='6' class='text-center text-red-600 p-4'>Error loading courses.</td></tr>");
                        e.printStackTrace();
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>


