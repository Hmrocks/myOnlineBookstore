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

import database.DB_Conn;

/**
 * Servlet implementation class DeleteUser
 */
public class DeleteUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String DELETE_PARAMETER = "delete";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if(request.getParameter(DELETE_PARAMETER)!=null){
			  String delete_id =  request.getParameter(DELETE_PARAMETER);
			  String sql ="DELETE FROM `users` WHERE id ='"+delete_id+"'";
			   try(			  
			    		Connection connection = new DB_Conn().getConnection();
						PreparedStatement pstatement = connection.prepareStatement(sql);){
	    		    
	    		   System.out.println(pstatement);
					  int rs = pstatement.executeUpdate();
					  
					  String message = "user has succesfully been deleted!";
					  request.setAttribute("message", message);
		              RequestDispatcher rd =request.getRequestDispatcher("admin_users.jsp");
		              rd.forward(request, response);
	    	   } catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		  }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		if(request.getParameter(DELETE_PARAMETER)!=null){
			  String delete_id =  request.getParameter(DELETE_PARAMETER);
			  String sql ="DELETE FROM `users` WHERE id ='"+delete_id+"'";
			   try(			  
			    		Connection connection = new DB_Conn().getConnection();
						PreparedStatement pstatement = connection.prepareStatement(sql);){
	    		    
	    		   System.out.println(pstatement);
					  int rs = pstatement.executeUpdate();
					  
					  String message = "user has succesfully been deleted!";
					  request.setAttribute("message", message);
		              RequestDispatcher rd =request.getRequestDispatcher("admin_users.jsp");
		              rd.forward(request, response);
	    	   } catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		  }
	}

}
