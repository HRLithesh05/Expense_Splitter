package dao;



import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.Expense;
import utility.DBConnection;

public class ExpenseDAO {
    
    public int addExpense(Expense expense) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO expenses (description, amount, paid_by) VALUES (?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setString(1, expense.getDescription());
            pstmt.setDouble(2, expense.getAmount());
            pstmt.setInt(3, expense.getPaidBy());
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
        }
        return -1; 
    }
    
    public List<Expense> getAllExpenses() throws SQLException, ClassNotFoundException {
        List<Expense> expenses = new ArrayList<>();
        String sql = "SELECT e.*, m.name as paid_by_name FROM expenses e " +
                     "JOIN members m ON e.paid_by = m.member_id";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Expense expense = new Expense();
                expense.setExpenseId(rs.getInt("expense_id"));
                expense.setDescription(rs.getString("description"));
                expense.setAmount(rs.getDouble("amount"));
                expense.setPaidBy(rs.getInt("paid_by"));
                expense.setDateAdded(rs.getTimestamp("date_added"));
                expense.setPaidByName(rs.getString("paid_by_name"));
                expenses.add(expense);
            }
        }
        return expenses;
    }
    
    public double getTotalExpenses() throws SQLException, ClassNotFoundException {
        String sql = "SELECT SUM(amount) as total FROM expenses";
        
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getDouble("total");
            }
        }
        return 0;
    }
    
    public double getTotalPaidByMember(int memberId) throws SQLException, ClassNotFoundException {
        String sql = "SELECT SUM(amount) as total FROM expenses WHERE paid_by = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, memberId);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("total");
                }
            }
        }
        return 0;
    }
    
    public void clearAllExpenses() throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM expenses";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.executeUpdate();
        }
    }
}