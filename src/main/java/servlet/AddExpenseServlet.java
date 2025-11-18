package servlet;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.ExpenseDAO;
import model.Expense;

@WebServlet("/AddExpenseServlet")
public class AddExpenseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ExpenseDAO expenseDAO;
    
    public AddExpenseServlet() {
        this.expenseDAO = new ExpenseDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String description = request.getParameter("description");
        String amountStr = request.getParameter("amount");
        String paidByStr = request.getParameter("paidBy");
        
        try {
            if (description != null && !description.trim().isEmpty() 
                    && amountStr != null && !amountStr.trim().isEmpty()
                    && paidByStr != null && !paidByStr.trim().isEmpty()) {
                
                double amount = Double.parseDouble(amountStr);
                int paidBy = Integer.parseInt(paidByStr);
                
                if (amount <= 0) {
                    request.setAttribute("errorMessage", "Amount must be greater than zero.");
                    request.getRequestDispatcher("/addExpense.jsp").forward(request, response);
                    return;
                }
                
                Expense expense = new Expense(description, amount, paidBy);
                
                try {
                    int expenseId = expenseDAO.addExpense(expense);
                    
                    if (expenseId > 0) {
                        request.setAttribute("successMessage", "Expense added successfully!");
                    } else {
                        request.setAttribute("errorMessage", "Failed to add expense. Please try again.");
                    }
                } catch (SQLException | ClassNotFoundException e) {
                    request.setAttribute("errorMessage", "Database error: " + e.getMessage());
                    e.printStackTrace();
                }
            } else {
                request.setAttribute("errorMessage", "All fields are required.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid amount or member selection.");
        }
        
        request.getRequestDispatcher("/addExpense.jsp").forward(request, response);
    }
}