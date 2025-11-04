<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Member - Expense Splitter</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary: #6366f1;
            --primary-dark: #4f46e5;
            --secondary: #f59e0b;
            --text: #334155;
            --text-light: #64748b;
            --bg: #f8fafc;
            --white: #ffffff;
            --success: #10b981;
            --success-bg: #d1fae5;
            --error: #ef4444;
            --error-bg: #fee2e2;
            --card-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
            --transition: all 0.3s ease;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--bg);
            color: var(--text);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        .container {
            max-width: 800px;
            width: 90%;
            margin: 40px auto;
            flex: 1;
        }
        
        header {
            background-color: var(--white);
            padding: 20px 0;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        
        .header-content {
            max-width: 1000px;
            width: 90%;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
            color: var(--primary);
        }
        
        .logo i {
            font-size: 24px;
        }
        
        .logo h2 {
            font-weight: 600;
            font-size: 24px;
        }
        
        .content-card {
            background-color: var(--white);
            border-radius: 12px;
            padding: 30px;
            box-shadow: var(--card-shadow);
        }
        
        h1 {
            color: var(--primary);
            text-align: center;
            margin-bottom: 30px;
            font-size: 2rem;
            font-weight: 600;
        }
        
        .message {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .success {
            background-color: var(--success-bg);
            color: var(--success);
        }
        
        .error {
            background-color: var(--error-bg);
            color: var(--error);
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text);
        }
        
        input[type="text"], input[type="email"] {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-family: 'Poppins', sans-serif;
            font-size: 1rem;
            color: var(--text);
            transition: var(--transition);
        }
        
        input[type="text"]:focus, input[type="email"]:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.2);
        }
        
        .button {
            display: inline-flex;
            align-items: center;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.3s ease;
            font-size: 1rem;
            gap: 8px;
            cursor: pointer;
            border: none;
            font-family: 'Poppins', sans-serif;
        }
        
        .primary-button {
            background-color: var(--primary);
            color: var(--white);
            width: 100%;
            justify-content: center;
        }
        
        .primary-button:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
        }
        
        .nav-links {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 30px;
        }
        
        .nav-link {
            display: flex;
            align-items: center;
            gap: 5px;
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
            transition: var(--transition);
        }
        
        .nav-link:hover {
            color: var(--primary-dark);
        }
        
        footer {
            background-color: var(--white);
            padding: 20px 0;
            margin-top: auto;
            text-align: center;
            color: var(--text-light);
            font-size: 0.9rem;
        }
        
        @media (max-width: 768px) {
            .container {
                width: 95%;
            }
        }
    </style>
</head>
<body>
    <header>
        <div class="header-content">
            <a href="index.jsp" class="logo">
                <i class="fas fa-coins"></i>
                <h2>Split.it</h2>
            </a>
            <nav>
                <!-- Can be expanded with additional navigation items if needed -->
            </nav>
        </div>
    </header>

    <div class="container">
        <div class="content-card">
            <h1>Add Member</h1>
            
            <% if (request.getAttribute("successMessage") != null) { %>
                <div class="message success">
                    <i class="fas fa-check-circle"></i>
                    <%= request.getAttribute("successMessage") %>
                </div>
            <% } %>
            
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="message error">
                    <i class="fas fa-exclamation-circle"></i>
                    <%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>
            
            <form action="AddMemberServlet" method="post" id="memberForm" onsubmit="return validateEmail()">
                <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" id="name" name="name" placeholder="Enter member's name" required>
                </div>
                
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" placeholder="Enter member's email address (e.g., name@example.com)" required>
                    <small id="emailError" style="color: var(--error); display: none;">Please enter a valid email address (e.g., name@gmail.com)</small>
                </div>
                
                <button type="submit" class="button primary-button">
                    <i class="fas fa-user-plus"></i> Add Member
                </button>
            </form>
            
            <div class="nav-links">
                <a href="index.jsp" class="nav-link">
                    <i class="fas fa-home"></i> Home
                </a>
                <a href="addExpense.jsp" class="nav-link">
                    <i class="fas fa-receipt"></i> Add Expense
                </a>
                <a href="summary.jsp" class="nav-link">
                    <i class="fas fa-chart-pie"></i> View Summary
                </a>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; <%= java.time.Year.now() %> Split.it Expense Splitter. All rights reserved.</p>
    </footer>
    
    <script>
        function validateEmail() {
            const email = document.getElementById('email').value;
            const emailError = document.getElementById('emailError');
            const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
            
            if (!emailRegex.test(email)) {
                emailError.style.display = 'block';
                return false;
            } else {
                emailError.style.display = 'none';
                return true;
            }
        }
        
        // Add event listener to validate on input
        document.getElementById('email').addEventListener('input', function() {
            // Only validate if there's some content
            if (this.value.length > 0) {
                validateEmail();
            } else {
                document.getElementById('emailError').style.display = 'none';
            }
        });
    </script>
</body>
</html>