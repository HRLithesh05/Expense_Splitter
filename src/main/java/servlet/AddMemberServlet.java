package servlet;


import java.io.IOException;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.MemberDAO;
import model.Member;

@WebServlet("/AddMemberServlet")
public class AddMemberServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private MemberDAO memberDAO;
    
    public AddMemberServlet() {
        this.memberDAO = new MemberDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        
        // Email validation regex pattern
        String emailRegex = "^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$";
        
        if (name != null && !name.trim().isEmpty() && email != null && !email.trim().isEmpty()) {
            // Validate email format on server side
            if (!email.matches(emailRegex)) {
                request.setAttribute("errorMessage", "Please enter a valid email address (e.g., name@gmail.com)");
            } else {
                Member member = new Member(name, email);
                
                try {
                    int memberId = memberDAO.addMember(member);
                    
                    if (memberId > 0) {
                        request.setAttribute("successMessage", "Member added successfully!");
                    } else {
                        request.setAttribute("errorMessage", "Failed to add member. Please try again.");
                    }
                } catch (SQLException | ClassNotFoundException e) {
                    request.setAttribute("errorMessage", "Database error: " + e.getMessage());
                    e.printStackTrace();
                }
            }
        } else {
            request.setAttribute("errorMessage", "Name and email are required fields.");
        }
        
        request.getRequestDispatcher("/addMember.jsp").forward(request, response);
    }
}