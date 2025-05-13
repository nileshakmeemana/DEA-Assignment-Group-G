 <%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Student Management System</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f4f6f9;
        }

        .header {
            background: linear-gradient(90deg, #004080, #0059b3);
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 40px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .header-title {
            font-size: 24px;
            font-weight: bold;
            letter-spacing: 1px;
        }

        .header-center {
            flex: 1;
            text-align: center;
        }

        .header-center .center-button {
            text-decoration: none;
            padding: 10px 22px;
            background-color: #0099ff;
            color: white;
            border-radius: 30px;
            font-weight: 600;
            transition: transform 0.3s ease, background-color 0.3s ease;
        }

        .header-center .center-button:hover {
            background-color: #66c2ff;
            color: #00264d;
            transform: scale(1.05);
        }

        .right-buttons a {
            text-decoration: none;
            padding: 10px 18px;
            background-color: #007acc;
            color: white;
            border-radius: 20px;
            font-weight: 500;
            transition: background-color 0.3s ease, transform 0.2s;
        }

        .right-buttons a:hover {
            background-color: #3399ff;
            color: #001f3f;
            transform: translateY(-2px);
        }

        .right-buttons {
            display: flex;
            gap: 15px;
        }

        @media screen and (max-width: 768px) {
            .header {
                flex-direction: column;
                text-align: center;
            }
            .header-center {
                margin: 10px 0;
            }
            .right-buttons {
                flex-direction: column;
                gap: 10px;
                margin-top: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-title">🎓 Student Management System</div>
        <div class="header-center">
            <a href="index.jsp" class="center-button">🏠 Home</a>
        </div>
        <div class="right-buttons">
            <a href="login.jsp">🔐 Login</a>
            <a href="registerStudent.jsp">📝 Register</a>
        </div>
    </div>
</body>
</html>
