<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO" %>
<%@ page import="model.Member" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Expense - Expense Splitter</title>
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
            --warning: #f59e0b;
            --warning-bg: #fef3c7;
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
        
        .no-members {
            background-color: var(--warning-bg);
            color: var(--warning);
            text-align: center;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        
        .no-members a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
            transition: var(--transition);
        }
        
        .no-members a:hover {
            text-decoration: underline;
            color: var(--primary-dark);
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
        
        input[type="text"], input[type="number"], select {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-family: 'Poppins', sans-serif;
            font-size: 1rem;
            color: var(--text);
            transition: var(--transition);
        }
        
        input[type="text"]:focus, input[type="number"]:focus, select:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.2);
        }
        
        select {
            appearance: none;
            background-image: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="%2364748b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="6 9 12 15 18 9"></polyline></svg>');
            background-repeat: no-repeat;
            background-position: right 12px center;
            background-size: 16px;
            padding-right: 40px;
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
        
        .input-icon {
            position: relative;
        }
        
        .input-icon input {
            padding-left: 40px;
        }
        
        .input-icon i {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-light);
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
                
            </nav>
        </div>
    </header>

    <div class="container">
        <div class="content-card">
            <h1>Add Expense</h1>
            
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
            
            <%
                MemberDAO memberDAO = new MemberDAO();
                List<Member> members = null;
                try {
                    members = memberDAO.getAllMembers();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
            
            <% if (members == null || members.isEmpty()) { %>
                <div class="no-members">
                    <i class="fas fa-exclamation-triangle" style="font-size: 24px; margin-bottom: 10px;"></i>
                    <p>You need to add members before adding expenses.</p>
                    <p style="margin-top: 10px;"><a href="addMember.jsp">Add a member now</a></p>
                </div>
            <% } else { %>
                <form action="AddExpenseServlet" method="post">
                    <div class="form-group">
                        <label for="description">Description</label>
                        <div class="input-icon">
                            <i class="fas fa-file-invoice"></i>
                            <input type="text" id="description" name="description" placeholder="What was this expense for?" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="amount">Amount (₹)</label>
                        <div class="input-icon">
                            <i class="fas fa-indian-rupee-sign"></i>
                            <input type="number" id="amount" name="amount" step="0.01" min="0.01" placeholder="0.00" required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="paidBy">Paid By</label>
                        <select id="paidBy" name="paidBy" required>
                            <option value="">Select who paid</option>
                            <% for (Member member : members) { %>
                                <option value="<%= member.getMemberId() %>"><%= member.getName() %></option>
                            <% } %>
                        </select>
                    </div>
                    
                    <button type="submit" class="button primary-button">
                        <i class="fas fa-plus-circle"></i> Add Expense
                    </button>
                </form>
            <% } %>
            
            <div class="nav-links">
                <a href="index.jsp" class="nav-link">
                    <i class="fas fa-home"></i> Home
                </a>
                <a href="addMember.jsp" class="nav-link">
                    <i class="fas fa-user-plus"></i> Add Member
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
</body>
</html>