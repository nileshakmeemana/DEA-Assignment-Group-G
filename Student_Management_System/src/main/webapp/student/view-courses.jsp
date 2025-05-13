 <%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Courses</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 0;
            padding: 20px;
            background: #f5f7fa;
            color: #333;
        }

        h2 {
            color: #2c3e50;
            text-align: center;
            margin-bottom: 30px;
        }

        .header-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .header-bar h3 {
            margin: 0;
            color: #004080;
        }

        .btn-group button {
            background-color: #0066cc;
            color: white;
            border: none;
            padding: 10px 15px;
            margin-left: 10px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn-group button:hover {
            background-color: #004080;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #ffffff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            margin-top: 10px;
        }

        th, td {
            padding: 12px 16px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        th {
            background-color: #004080;
            color: white;
        }

        .drop-btn {
            background-color: #e74c3c;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .drop-btn:hover {
            background-color: #c0392b;
        }

        .no-data {
            text-align: center;
            padding: 20px;
            color: #777;
        }
    </style>
</head>
<body>

    <h2>My Courses</h2>

    <div class="header-bar">
        <h3>Enrolled Courses</h3>
        <div class="btn-group">
            <button onclick="location.href='enrollCourses.jsp'">Register for Courses</button>
            <button onclick="location.href='searchCourses.jsp'">Search Courses</button>
        </div>
    </div>

    <table>
        <thead>
            <tr>
                <th>Course Code</th>
                <th>Course Name</th>
                <th>Description</th>
                <th>Credit Hours</th>
                <th>Teacher</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/studentdb", "root", "yourpassword");
                stmt = conn.createStatement();
                rs = stmt.executeQuery("SELECT * FROM enrolled_courses");

                boolean hasRows = false;
                while (rs.next()) {
                    hasRows = true;
        %>
            <tr>
                <td><%= rs.getString("course_code") %></td>
                <td><%= rs.getString("course_name") %></td>
                <td><%= rs.getString("description") %></td>
                <td><%= rs.getInt("credit_hours") %></td>
                <td><%= rs.getString("teacher") %></td>
                <td>
                    <form method="post" action="DropCourseServlet">
                        <input type="hidden" name="courseCode" value="<%= rs.getString("course_code") %>">
                        <button type="submit" class="drop-btn">Drop Course</button>
                    </form>
                </td>
            </tr>
        <%
                }
                if (!hasRows) {
        %>
            <tr>
                <td colspan="6" class="no-data">You are not enrolled in any courses.</td>
            </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='6' class='no-data'>Database Error: " + e.getMessage() + "</td></tr>");
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception e) {}
                try { if (stmt != null) stmt.close(); } catch (Exception e) {}
                try { if (conn != null) conn.close(); } catch (Exception e) {}
            }
        %>
        </tbody>
    </table>

</body>
</html>
