package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import database.DB_Conn;
import database.UserDao;

/**
 * Servlet implementation class RegisterServlet
 */
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private UserDao userDao = new UserDao();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
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
		
	   String userName = request.getParameter("user_name");
	   String email = request.getParameter("email");
	   String password = request.getParameter("password");
	   String user_type = request.getParameter("user_type");
	   
	   User user = new User();
	   user.setName(userName);
	   user.setEmail(email);
	   user.setPassword(password);
	   user.setUser_type(user_type);
	   
	   try {
		userDao.registerUser(user);
	} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	   
	   if(user_type.equals("admin")) {
 	    	HttpSession session = request.getSession();      
	    	session.setAttribute("user", user);
 	    	response.sendRedirect("admin.jsp");      	    	
	    	 
	    	
	     }else {
	    	 
	    	HttpSession session = request.getSession();      
	    	session.setAttribute("user", user);
	    	response.sendRedirect(request.getContextPath());
	     }
		
   }

}
