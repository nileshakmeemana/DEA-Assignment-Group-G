<%-- 
    Document   : footer
    Created on : May 10, 2025, 1:41:30 PM
    Author     : Nilesh
--%>

<style>
    footer {
        background: linear-gradient(to right, #0f2027, #203a43, #2c5364);
        padding: 50px 20px 30px;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        color: #f2f2f2;
        position: relative;
        animation: fadeInUp 1s ease-in-out;
    }

    @keyframes fadeInUp {
        0% {
            opacity: 0;
            transform: translateY(30px);
        }
        100% {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .footer-container {
        max-width: 1200px;
        margin: auto;
        display: flex;
        flex-wrap: wrap;
        justify-content: space-between;
        gap: 30px;
    }

    .footer-section {
        flex: 1 1 300px;
    }

    .footer-section h3 {
        color: #ffcc00;
        margin-bottom: 15px;
        font-size: 20px;
        position: relative;
    }

    .footer-section h3::after {
        content: '';
        display: block;
        width: 50px;
        height: 3px;
        background-color: #ffcc00;
        margin-top: 5px;
    }

    .footer-section p {
        line-height: 1.7;
        color: #d0d0d0;
        font-size: 15px;
    }

    .footer-links ul {
        list-style: none;
        padding: 0;
    }

    .footer-links a {
        text-decoration: none;
        color: #aad4ff;
        display: block;
        margin-bottom: 8px;
        font-size: 15px;
        transition: all 0.3s ease;
    }

    .footer-links a:hover {
        color: #ffcc00;
        transform: translateX(5px);
    }

    .footer-section a {
        color: #aad4ff;
        transition: color 0.3s ease;
    }

    .footer-section a:hover {
        color: #ffcc00;
    }

    .footer-bottom {
        margin-top: 30px;
        border-top: 1px solid #444;
        padding-top: 15px;
        font-size: 14px;
        color: #999;
        text-align: center;
    }

    .footer-icons {
        margin-top: 15px;
    }

    .footer-icons a {
        margin-right: 15px;
        font-size: 20px;
        color: #aad4ff;
        text-decoration: none;
        transition: color 0.3s ease;
    }

    .footer-icons a:hover {
        color: #ffcc00;
    }

    @media (max-width: 768px) {
        .footer-container {
            flex-direction: column;
            align-items: center;
        }
    }
</style>

<footer>
    <div class="footer-container">

        <!-- About Section -->
        <div class="footer-section">
            <h3>? Student Management System</h3>
            <p>A modern, efficient platform to manage students' records, courses, grades, and attendance ? streamlining academic processes with ease.</p>
        </div>

        <!-- Quick Links Section -->
        <div class="footer-section footer-links">
            <h3>? Quick Links</h3>
            <ul>
                <li><a href="index.jsp">? Home</a></li>
                <li><a href="registerStudent.jsp">? Register</a></li>
                <li><a href="login.jsp">? Login</a></li>
            </ul>
        </div>

        <!-- Contact Section -->
        <div class="footer-section">
            <h3>? Contact</h3>
            <p>Email: <a href="mailto:info@studentms.com">info@studentms.com</a></p>
            <p>Phone: <a href="tel:+1234567890">+123 456 7890</a></p>
            <div class="footer-icons">
                <a href="#"><i class="fa fa-facebook-official"></i></a>
                <a href="#"><i class="fa fa-twitter-square"></i></a>
                <a href="#"><i class="fa fa-linkedin-square"></i></a>
            </div>
        </div>

    </div>

    <div class="footer-bottom">
        © 2025 Student Management System. All rights reserved.
    </div>
</footer>

<!-- Add Font Awesome CDN for icons (if not already included) -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
