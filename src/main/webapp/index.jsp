<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Expense Splitter</title>
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
            max-width: 1000px;
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
        
        .hero {
            text-align: center;
            margin: 50px 0;
        }
        
        .hero h1 {
            font-size: 3rem;
            color: var(--primary);
            margin-bottom: 20px;
            font-weight: 700;
        }
        
        .hero p {
            font-size: 1.1rem;
            color: var(--text-light);
            max-width: 600px;
            margin: 0 auto 30px;
            line-height: 1.6;
        }
        
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin: 50px 0;
        }
        
        .feature-card {
            background-color: var(--white);
            border-radius: 12px;
            padding: 30px;
            text-align: center;
            box-shadow: var(--card-shadow);
            transition: var(--transition);
        }
        
        .feature-card:hover {
            transform: translateY(-5px);
        }
        
        .feature-card i {
            font-size: 40px;
            color: var(--primary);
            margin-bottom: 20px;
        }
        
        .feature-card h3 {
            margin-bottom: 15px;
            font-weight: 600;
            color: var(--text);
        }
        
        .feature-card p {
            color: var(--text-light);
            line-height: 1.6;
        }
        
        .cta {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin: 50px 0;
        }
        
        .button {
            display: inline-flex;
            align-items: center;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 500;
            text-decoration: none;
            transition: var(--transition);
            font-size: 1rem;
            gap: 8px;
        }
        
        .primary-button {
            background-color: var(--primary);
            color: var(--white);
        }
        
        .primary-button:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
        }
        
        .secondary-button {
            background-color: var(--white);
            color: var(--primary);
            border: 1px solid var(--primary);
        }
        
        .secondary-button:hover {
            background-color: rgba(99, 102, 241, 0.05);
            transform: translateY(-2px);
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
            .hero h1 {
                font-size: 2.5rem;
            }
            
            .features {
                grid-template-columns: 1fr;
            }
            
            .cta {
                flex-direction: column;
                align-items: center;
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
        <section class="hero">
            <h1>Split Expenses Effortlessly</h1>
            <p>Keep track of shared expenses and settle debts with friends, roommates, or travel companions with our easy-to-use expense splitting tool.</p>
        </section>

        <section class="features">
            <div class="feature-card">
                <i class="fas fa-user-plus"></i>
                <h3>Add Members</h3>
                <p>Add people to your group and easily track who's involved in shared expenses.</p>
            </div>
            <div class="feature-card">
                <i class="fas fa-receipt"></i>
                <h3>Record Expenses</h3>
                <p>Log expenses as they happen and specify who paid for what.</p>
            </div>
            <div class="feature-card">
                <i class="fas fa-balance-scale"></i>
                <h3>View Balances</h3>
                <p>See who owes what and get a simple settlement plan to square up.</p>
            </div>
        </section>

        <section class="cta">
            <a href="addMember.jsp" class="button primary-button">
                <i class="fas fa-user-plus"></i> Add Member
            </a>
            <a href="addExpense.jsp" class="button primary-button">
                <i class="fas fa-receipt"></i> Add Expense
            </a>
            <a href="summary.jsp" class="button secondary-button">
                <i class="fas fa-chart-pie"></i> View Summary
            </a>
        </section>
    </div>

    <footer>
        <p>&copy; <%= java.time.Year.now() %> Split.it Expense Splitter. All rights reserved.</p>
    </footer>
</body>
</html>