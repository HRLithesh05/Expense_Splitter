package servlet;

import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.ExpenseDAO;
import dao.MemberDAO;

@WebServlet("/ClearDatabaseServlet")
public class ClearDatabaseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private ExpenseDAO expenseDAO;
    private MemberDAO memberDAO;
    
    public ClearDatabaseServlet() {
        this.expenseDAO = new ExpenseDAO();
        this.memberDAO = new MemberDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            expenseDAO.clearAllExpenses();
            
            memberDAO.clearAllMembers();
            
            request.getSession().setAttribute("successMessage", "Database cleared successfully!");
            
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error clearing database: " + e.getMessage());
        }
        
        response.sendRedirect("summary.jsp");
    }
}