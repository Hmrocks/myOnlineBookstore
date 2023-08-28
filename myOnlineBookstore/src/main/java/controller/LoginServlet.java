package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import database.DB_Conn;
import database.UserDao;

/**
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
	    String userEmail = request.getParameter("email");
	    String userPassword = request.getParameter("password");
	    String sql = "SELECT * FROM users WHERE email=? AND password=?";
		
	    String userID,userName, user_type;
	    User user = new User();
	    
	    try(
   		     Connection connection = new DB_Conn().getConnection();
   	    		 
   	         //Creating preparedStatement using connection object
   	         PreparedStatement preparedStatement = connection.prepareStatement(sql);){
   			 
       		 preparedStatement.setString(1,userEmail);
       		 preparedStatement.setString(2,userPassword);
       		 
       		 System.out.println(preparedStatement);
       		 //Execute or update the query
       		 ResultSet rs = preparedStatement.executeQuery();
       		 
             if(rs.next()) {
            	 userName = rs.getString("name");
            	 user_type = rs.getString("user_type");
            	 
            	 user.setName(userName);
          	     user.setEmail(userEmail);
          	     user.setPassword(userPassword);
          	     user.setUser_type(user_type);
          	     
          	    if(user_type.equals("admin")) {
          	    	HttpSession session = request.getSession();      
         	    	session.setAttribute("user", user);
          	    	response.sendRedirect("admin.jsp");      	    	
       	    	 
       	    	
       	     }else {
       	    	 
       	    	HttpSession session = request.getSession();      
      	    	session.setAttribute("user", user);
      	    	response.sendRedirect(request.getContextPath());
       	     }
            	     	   
             } else {
            	String message ="Sorry your credentials do not match any account in our system. Please try again or create a new account!!";
            	request.setAttribute("message", message);
            	RequestDispatcher rd =request.getRequestDispatcher("index.jsp");
            	rd.forward(request, response);
             }
       		 
   		 }	catch(SQLException ex) {
   		 
   		 ex.printStackTrace();
   	 } catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

}
