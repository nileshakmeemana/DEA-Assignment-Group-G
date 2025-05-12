<%-- 
    Document   : dashboard
    Created on : May 10, 2025, 1:46:11 PM
    Author     : Nilesh
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Student Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-gray-800">

<div class="max-w-7xl mx-auto p-6">
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">

        <!-- Left Section -->
        <div class="md:col-span-2">
            <h1 class="text-3xl font-bold mb-6">Student Dashboard</h1>

            <!-- Welcome Card -->
            <div class="bg-white p-6 rounded-xl shadow mb-6">
                <h2 class="text-xl font-semibold mb-2">
                    Welcome, <%= request.getAttribute("studentName") != null ? request.getAttribute("studentName") : "Student" %>
                </h2>
                <p>Student ID: <%= request.getAttribute("studentId") %></p>
                <p>Email: <%= request.getAttribute("studentEmail") %></p>
                <p>Enrollment Date: <%= request.getAttribute("enrollDate") %></p>
            </div>

            <!-- Academic Summary -->
            <div class="bg-white p-6 rounded-xl shadow mb-6">
                <h2 class="text-lg font-semibold mb-4">Academic Summary</h2>
                <div class="overflow-x-auto">
                    <table class="w-full text-center border border-gray-200 rounded-lg">
                        <thead class="bg-gray-100">
                            <tr>
                                <th class="p-2 border">Current GPA</th>
                                <th class="p-2 border">Credits Earned</th>
                                <th class="p-2 border">Academic Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="p-2 border"><%= request.getAttribute("gpa") != null ? request.getAttribute("gpa") : "N/A" %></td>
                                <td class="p-2 border"><%= request.getAttribute("credits") != null ? request.getAttribute("credits") : "N/A" %></td>
                                <td class="p-2 border">
                                    <span class="inline-block px-3 py-1 rounded-full text-sm font-medium 
                                        <%
                                            Object gpaObj = request.getAttribute("gpa");
                                            if (gpaObj != null && gpaObj instanceof Double) {
                                                double gpa = (Double) gpaObj;
                                                if (gpa >= 3.5) {
                                                    out.print("bg-green-100 text-green-700");
                                                } else if (gpa >= 2.0) {
                                                    out.print("bg-yellow-100 text-yellow-700");
                                                } else {
                                                    out.print("bg-red-100 text-red-700");
                                                }
                                            } else {
                                                out.print("bg-gray-100 text-gray-500");
                                            }
                                        %>">
                                        <%
                                            if (gpaObj != null && gpaObj instanceof Double) {
                                                double gpa = (Double) gpaObj;
                                                out.print(gpa >= 3.5 ? "Excellent" : (gpa >= 2.0 ? "Good" : "Needs Improvement"));
                                            } else {
                                                out.print("N/A");
                                            }
                                        %>
                                    </span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Enrolled Courses -->
            <div class="bg-white p-6 rounded-xl shadow mb-6">
                <h2 class="text-lg font-semibold mb-4">Enrolled Courses</h2>
                <div class="overflow-x-auto">
                    <table class="w-full border text-left">
                        <thead class="bg-gray-100">
                            <tr>
                                <th class="p-2 border">Course Code</th>
                                <th class="p-2 border">Course Name</th>
                                <th class="p-2 border">Credit Hours</th>
                                <th class="p-2 border">Teacher</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Course> courses = (List<Course>) request.getAttribute("enrolledCourses");
                                if (courses != null && !courses.isEmpty()) {
                                    for (Course course : courses) {
                            %>
                            <tr class="hover:bg-gray-50">
                                <td class="p-2 border"><%= course.getCourseCode() %></td>
                                <td class="p-2 border"><%= course.getCourseName() %></td>
                                <td class="p-2 border"><%= course.getCredits() %></td>
                                <td class="p-2 border"><%= course.getTeacher() %></td>
                            </tr>
                            <% 
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="4" class="p-2 text-center border">No courses enrolled.</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                <a href="view-courses.jsp" class="inline-block mt-4 px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">View All Courses</a>
            </div>
        </div>

        <!-- Sidebar -->
        <div class="space-y-6">
            <!-- Quick Links -->
            <div class="bg-white rounded-xl shadow p-6">
                <h2 class="text-lg font-semibold mb-4">Quick Links</h2>
                <ul class="space-y-2">
                    <li><a href="view-grades.jsp" class="text-blue-600 hover:underline">View Grades</a></li>
                    <li><a href="view-attendance.jsp" class="text-blue-600 hover:underline">View Attendance</a></li>
                    <li><a href="course-registration.jsp" class="text-blue-600 hover:underline">Edit Profile</a></li>
                </ul>
            </div>

            <!-- Deadlines -->
            <div class="bg-white rounded-xl shadow p-6">
                <h2 class="text-lg font-semibold mb-4">Upcoming Deadlines</h2>
                <div class="mb-4">
                    <strong>Assignment 1</strong>
                    <p>Complete the first programming assignment</p>
                    <small class="text-gray-500">Due: 2025-05-15</small>
                </div>
                <hr class="my-4">
                <div>
                    <strong>Midterm Exam</strong>
                    <p>Prepare for the midterm examination</p>
                    <small class="text-gray-500">Due: 2025-05-20</small>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
