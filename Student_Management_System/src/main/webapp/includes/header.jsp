

 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Management System</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
        }
        .header {
            background-color: #004080;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 30px;
        }
        .header-title {
            font-size: 20px;
            font-weight: bold;
        }
        .center-button, .right-buttons a {
            text-decoration: none;
            padding: 8px 16px;
            background-color: #0066cc;
            color: white;
            border: none;
            border-radius: 4px;
            font-weight: 500;
            margin-left: 10px;
            transition: all 0.3s ease;
        }
        .center-button:hover, .right-buttons a:hover {
            background-color: rgba(255, 255, 255, 0.2);
            color: black;
            backdrop-filter: blur(4px);
        }
        .header-center {
            flex: 1;
            text-align: center;
        }
        .right-buttons {
            display: flex;
            gap: 10px;
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-title">Student Management System</div>
        <div class="header-center">
            <a href="index.jsp" class="center-button">Home</a>
        </div>
        <div class="right-buttons">
            <a href="login.jsp">Login</a>
            <a href="registerStudent.jsp">Register</a>
        </div>
    </div>
</body>
</html>
