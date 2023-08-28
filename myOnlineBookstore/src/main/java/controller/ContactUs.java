package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import database.DB_Conn;

/**
 * Servlet implementation class ContactUs
 */
public class ContactUs extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ContactUs() {
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
		
		if(request.getParameter("send")!=null) {
			String name =request.getParameter("name");
			String email =request.getParameter("email");
			String number =request.getParameter("number");
			String msg =request.getParameter("message");
			
			String sql="SELECT * FROM message WHERE name=? AND email=? AND number=? AND message=?";
			try(			  
		    		Connection connection = new DB_Conn().getConnection();
					PreparedStatement pstatement = connection.prepareStatement(sql);){
				    pstatement.setString(1, name);
				    pstatement.setString(2, email); 
				    pstatement.setString(3, number); 
				    pstatement.setString(4, msg); 
				
    		   System.out.println(pstatement);
				  ResultSet rs = pstatement.executeQuery();
				  if(rs.next()) {
					  String message = "message already sent!";
					  request.setAttribute("message", message);
		              RequestDispatcher rd =request.getRequestDispatcher("index.jsp");
		              rd.forward(request, response);
				  }else {
					  User user =(User)request.getSession().getAttribute("user");
					  
					  sql="INSERT INTO `message`(name, email, number, message) VALUES(?,?,?,?)";
					  PreparedStatement pstatement2 = connection.prepareStatement(sql);
					  pstatement2.setString(1, name);
					  pstatement2.setString(2, email); 
					  pstatement2.setString(3, number); 
					  pstatement2.setString(4, msg); 
					  
					  System.out.println(pstatement);
					  int result = pstatement2.executeUpdate();
					  
					  String message = "message sent successfully!";
					  request.setAttribute("message", message);
		              RequestDispatcher rd =request.getRequestDispatcher("contactUs.jsp");
		              rd.forward(request, response);
				  }
				  
    	   } catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
		}
		
	}

}
