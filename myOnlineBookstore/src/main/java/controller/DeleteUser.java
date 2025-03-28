package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

// Add logger imports
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import database.DB_Conn;

@WebServlet("/DeleteUser")
public class DeleteUser extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DELETE_PARAM = "delete"; // Constant for parameter name
    private static final String MESSAGE_ATTR = "message"; // Constant for message attribute
    private static final Logger logger = LoggerFactory.getLogger(DeleteUser.class);

    public DeleteUser() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        handleDeleteRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        handleDeleteRequest(request, response);
    }

    private void handleDeleteRequest(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        if(request.getParameter(DELETE_PARAM) != null) {
            String deleteId = request.getParameter(DELETE_PARAM); // Renamed variable
            String sql = "DELETE FROM users WHERE id = ?"; // Parameterized query
            
            try (Connection connection = new DB_Conn().getConnection();
                 PreparedStatement pstatement = connection.prepareStatement(sql)) {
                
                pstatement.setString(1, deleteId);
                logger.debug("Delete statement: {}", pstatement); // Replaced System.out
                
                pstatement.executeUpdate(); // Removed unused result variable
                
                String message = "User has been successfully deleted!";
                request.setAttribute(MESSAGE_ATTR, message);
                RequestDispatcher rd = request.getRequestDispatcher("admin_users.jsp");
                rd.forward(request, response);
                
            } catch (ClassNotFoundException | SQLException e) {
                logger.error("Database error during deletion", e);
                request.setAttribute(MESSAGE_ATTR, "Error deleting user: " + e.getMessage());
                RequestDispatcher rd = request.getRequestDispatcher("error.jsp");
                rd.forward(request, response);
            }
        }
    }
}
