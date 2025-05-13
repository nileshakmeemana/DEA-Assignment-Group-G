<%-- 
    Document   : header
    Created on : May 11, 2025, 10:26:19?PM
    Author     : gmaha
--%>

<style>
    .navbar {
        background-color: #004080;
        color: white;
        padding: 15px 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-family: 'Segoe UI', sans-serif;
    }

    .navbar .nav-left {
        font-size: 20px;
        font-weight: bold;
    }

    .navbar .nav-center a {
        margin: 0 12px;
        color: white;
        text-decoration: none;
        font-weight: 500;
        transition: color 0.3s;
    }

    .navbar .nav-center a:hover {
        color: #ffcc00;
    }

    .navbar .nav-right {
        font-size: 16px;
    }
</style>

<div class="navbar">
    <div class="nav-left">Student Management System</div>
    <div class="nav-center">
        <a href="index.jsp">Home</a>
        <a href="dashboard.jsp">Dashboard</a>
        <a href="myCourses.jsp">Courses</a>
        <a href="grades.jsp">Grades</a>
        <a href="attendance.jsp">Attendance</a>
    </div>
    <div class="nav-right">Welcome, Nilesh</div>
</div>
