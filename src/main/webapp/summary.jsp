<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.MemberDAO" %>
<%@ page import="dao.ExpenseDAO" %>
<%@ page import="model.Member" %>
<%@ page import="model.Expense" %>
<%@ page import="service.BalanceCalculator" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Summary - Split.it</title>
    <style>
        :root {
            --primary-color: #6c63ff;
            --light-purple: #f0f0ff;
            --text-color: #4a4a4a;
            --secondary-text: #7b7b8f;
            --background-color: #f9f9fb;
            --card-background: #ffffff;
            --border-radius: 12px;
            --box-shadow: 0 8px 30px rgba(0, 0, 0, 0.08);
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--background-color);
            color: var(--text-color);
            line-height: 1.6;
            padding: 0;
            margin: 0;
        }
        
        .header {
            display: flex;
            align-items: center;
            padding: 15px 30px;
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }
        
        .logo {
            display: flex;
            align-items: center;
            font-size: 24px;
            font-weight: bold;
            color: var(--primary-color);
            text-decoration: none;
        }
        
        .logo-icon {
            margin-right: 10px;
            font-size: 28px;
        }
        
        .container {
            max-width: 1100px;
            margin: 30px auto;
            padding: 0 20px;
        }
        
        .page-title {
            font-size: 2.5rem;
            text-align: center;
            color: var(--primary-color);
            margin-bottom: 15px;
        }
        
        .subtitle {
            text-align: center;
            color: var(--secondary-text);
            margin-bottom: 40px;
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .card {
            background-color: var(--card-background);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 30px;
            margin-bottom: 30px;
        }
        
        .section-title {
            color: var(--primary-color);
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        th {
            color: #555;
            font-weight: 600;
            background-color: #f8f8fb;
        }
        
        tr:hover {
            background-color: #fafafa;
        }
        
        .positive {
            color: #1cac78;
            font-weight: 600;
        }
        
        .negative {
            color: #ff5e5b;
            font-weight: 600;
        }
        
        .zero {
            color: var(--secondary-text);
        }
        
        .no-data {
            text-align: center;
            padding: 40px 20px;
            color: var(--secondary-text);
            background-color: #f9f9fb;
            border-radius: 10px;
        }
        
        .no-data a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }
        
        .no-data a:hover {
            text-decoration: underline;
        }
        
        .settlement {
            background-color: var(--light-purple);
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 15px;
            border-left: 4px solid var(--primary-color);
        }
        
        .expense-info {
            background-color: #f8f8fb;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        
        .expense-info p {
            margin-bottom: 10px;
            font-size: 1.1em;
        }
        
        .expense-info strong {
            color: var(--primary-color);
        }
        
        .button-container {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 30px;
        }
        
        .button {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            display: flex;
            align-items: center;
            transition: all 0.3s ease;
            text-decoration: none;
        }
        
        .button:hover {
            background-color: #5652d6;
            transform: translateY(-2px);
        }
        
        .button svg, .button i {
            margin-right: 8px;
        }
        
        .clear-button {
            background-color: #ff5e5b;
            padding: 16px;
        }
        
        .clear-button:hover {
            background-color: #e54a4a;
        }
        
        .view-button {
            background-color: #6c63ff;
        }
        
        .success-message {
            background-color: #e7f7ef;
            color: #1cac78;
            padding: 15px;
            margin: 15px 0;
            border-radius: 8px;
            text-align: center;
            border-left: 4px solid #1cac78;
        }
        
        .error-message {
            background-color: #ffefef;
            color: #ff5e5b;
            padding: 15px;
            margin: 15px 0;
            border-radius: 8px;
            text-align: center;
            border-left: 4px solid #ff5e5b;
        }
        
        /* Simple icons */
        .icon {
            font-size: 24px;
            margin-right: 10px;
        }
        
        @media (max-width: 768px) {
            .button-container {
                flex-direction: column;
            }
            
            .card {
                padding: 20px;
            }
            
            th, td {
                padding: 10px;
            }
        }
    </style>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="header">
        <a href="index.jsp" class="logo">
            <i class="fas fa-coins logo-icon"></i>
            Split.it
        </a>
    </div>

    <div class="container">
        <h1 class="page-title">Expense Summary</h1>
        <p class="subtitle">
            Review your shared expenses, see who owes what, and get a simple settlement plan.
        </p>
        
        <%
            MemberDAO memberDAO = new MemberDAO();
            ExpenseDAO expenseDAO = new ExpenseDAO();
            BalanceCalculator calculator = new BalanceCalculator();
            
            List<Member> members = null;
            List<Expense> expenses = null;
            Map<Integer, Double> balances = null;
            List<Map<String, Object>> settlements = null;
            double totalExpense = 0;
            double perPersonShare = 0;
            
            DecimalFormat df = new DecimalFormat("0.00");
            
            try {
                members = memberDAO.getAllMembers();
                expenses = expenseDAO.getAllExpenses();
                balances = calculator.calculateBalances();
                settlements = calculator.generateSettlementSummary();
                totalExpense = expenseDAO.getTotalExpenses();
                
                if (members.size() > 0) {
                    perPersonShare = totalExpense / members.size();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        
        <div class="card">
            <h2 class="section-title"><i class="fas fa-users icon"></i> Members</h2>
            <% if (members == null || members.isEmpty()) { %>
                <div class="no-data">No members added yet. <a href="addMember.jsp">Add a member</a></div>
            <% } else { %>
                <table>
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                    </tr>
                    <% for (Member member : members) { %>
                        <tr>
                            <td><%= member.getName() %></td>
                            <td><%= member.getEmail() %></td>
                        </tr>
                    <% } %>
                </table>
            <% } %>
        </div>
        
        <div class="card">
            <h2 class="section-title"><i class="fas fa-receipt icon"></i> Expenses</h2>
            <% if (expenses == null || expenses.isEmpty()) { %>
                <div class="no-data">No expenses added yet. <a href="addExpense.jsp">Add an expense</a></div>
            <% } else { %>
                <div class="expense-info">
                    <p><strong>Total Expenses:</strong> ₹<%= df.format(totalExpense) %></p>
                    <p><strong>Per Person Share:</strong> ₹<%= df.format(perPersonShare) %></p>
                </div>
                
                <table>
                    <tr>
                        <th>Description</th>
                        <th>Amount</th>
                        <th>Paid By</th>
                        <th>Date</th>
                    </tr>
                    <% for (Expense expense : expenses) { %>
                        <tr>
                            <td><%= expense.getDescription() %></td>
                            <td>₹<%= df.format(expense.getAmount()) %></td>
                            <td><%= expense.getPaidByName() %></td>
                            <td><%= expense.getDateAdded() %></td>
                        </tr>
                    <% } %>
                </table>
            <% } %>
        </div>
        
        <% if (members != null && !members.isEmpty() && expenses != null && !expenses.isEmpty()) { %>
            <div class="card">
                <h2 class="section-title"><i class="fas fa-balance-scale icon"></i> Balance Summary</h2>
                <table>
                    <tr>
                        <th>Member</th>
                        <th>Paid</th>
                        <th>Share</th>
                        <th>Balance</th>
                    </tr>
                    <% for (Member member : members) { %>
                        <% 
                            int memberId = member.getMemberId();
                            double paid = expenseDAO.getTotalPaidByMember(memberId);
                            double balance = balances.get(memberId);
                            String balanceClass = balance > 0 ? "positive" : (balance < 0 ? "negative" : "zero");
                        %>
                        <tr>
                            <td><%= member.getName() %></td>
                            <td>₹<%= df.format(paid) %></td>
                            <td>₹<%= df.format(perPersonShare) %></td>
                            <td class="<%= balanceClass %>">
                                <% if (balance > 0) { %>
                                    Gets back: ₹<%= df.format(balance) %>
                                <% } else if (balance < 0) { %>
                                    Owes: ₹<%= df.format(-balance) %>
                                <% } else { %>
                                    Settled
                                <% } %>
                            </td>
                        </tr>
                    <% } %>
                </table>
            </div>
            
            <div class="card">
                <h2 class="section-title"><i class="fas fa-exchange-alt icon"></i> Settlement Plan</h2>
                <% if (settlements.isEmpty()) { %>
                    <div class="no-data">All expenses are already settled!</div>
                <% } else { %>
                    <% for (Map<String, Object> settlement : settlements) { %>
                        <div class="settlement">
                            <strong><%= settlement.get("fromName") %></strong> should pay 
                            <strong>₹<%= df.format(settlement.get("amount")) %></strong> to 
                            <strong><%= settlement.get("toName") %></strong>
                        </div>
                    <% } %>
                <% } %>
            </div>
        <% } %>
        
        <% if(request.getSession().getAttribute("successMessage") != null) { %>
            <div class="success-message">
                <%= request.getSession().getAttribute("successMessage") %>
                <% request.getSession().removeAttribute("successMessage"); %>
            </div>
        <% } %>
        
        <% if(request.getSession().getAttribute("errorMessage") != null) { %>
            <div class="error-message">
                <%= request.getSession().getAttribute("errorMessage") %>
                <% request.getSession().removeAttribute("errorMessage"); %>
            </div>
        <% } %>
        
        <div class="button-container">
	        <a href="index.jsp" class="button view-button">
	                <i class="fas fa-home"></i> Home
	        </a>
            <a href="addMember.jsp" class="button">
                <i class="fas fa-user-plus"></i> Add Member
            </a>
            <a href="addExpense.jsp" class="button">
                <i class="fas fa-file-invoice-dollar"></i> Add Expense
            </a>
            
            <form action="ClearDatabaseServlet" method="post" style="display: inline;" onsubmit="return confirm('Are you sure you want to clear all data? This action cannot be undone.')">
                <button type="submit" class="button clear-button">
                    <i class="fas fa-trash-alt"></i> Clear All Data
                </button>
            </form>
        </div>
    </div>
</body>
</html>