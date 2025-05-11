<%-- 
    Document   : footer
    Created on : May 10, 2025, 1:41:30?PM
    Author     : Nilesh
--%>

<style>
    footer {
        background-color: #1a1a1a; /* Dark background */
        padding: 40px 20px;
        border-top: 2px solid #444;
        font-family: Arial, sans-serif;
        color: #f0f0f0; /* Light text */
        background-color: #143D60;
    }

    .footer-container {
        max-width: 1100px;
        margin: auto;
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
    }

    .footer-section {
        flex: 1;
        min-width: 250px;
        margin: 20px;
    }

    .footer-section h3 {
        color: #ffcc00; /* Highlight color */
        margin-bottom: 10px;
    }

    .footer-section p {
        line-height: 1.6;
        color: #ccc;
    }

    .footer-links ul {
        list-style: none;
        padding: 0;
    }

    .footer-links a {
        text-decoration: none;
        color: #aad4ff;
        display: block;
        margin-bottom: 5px;
        transition: color 0.3s;
    }

    .footer-links a:hover {
        color: #ffcc00;
    }

    .footer-bottom {
        margin-top: 20px;
        border-top: 1px solid #444;
        padding-top: 10px;
        font-size: 14px;
        color: #888;
        text-align: center;
    }

    a {
        color: #aad4ff;
    }

    a:hover {
        color: #ffcc00;
    }
</style>

<footer>
    <div class="footer-container">
        
        <!-- About Section -->
        <div class="footer-section">
            <h3>Student Management System</h3>
            <p>A comprehensive platform for managing students' records, courses, grades, and attendance. Designed to simplify academic administration.</p>
        </div>

        <!-- Quick Links Section -->
        <div class="footer-section footer-links">
            <h3>Quick Links</h3>
            <ul>
                <li><a href="index.jsp">Home</a></li>
                <li><a href="registerStudent.jsp">Register</a></li>
                <li><a href="login.jsp">Login</a></li>
            </ul>
        </div>

        <!-- Contact Section -->
        <div class="footer-section">
            <h3>Contact</h3>
            <p>Email: <a href="mailto:info@studentms.com">info@studentms.com</a></p>
            <p>Phone: <a href="tel:+1234567890">+123 456 7890</a></p>
        </div>
    </div>

    <div class="footer-bottom">
        © 2025 Student Management System. All rights reserved.
    </div>
</footer>