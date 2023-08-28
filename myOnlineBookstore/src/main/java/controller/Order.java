package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

import database.DB_Conn;

/**
 * Servlet implementation class Order
 */
public class Order extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Order() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if(request.getParameter("delete")!=null){

	    	   String delete_id = request.getParameter("delete"); 
	    	   String update_payment = request.getParameter("update_payment"); 
	    	   String sql= "DELETE FROM `orders` WHERE id ='"+delete_id+"'";
	    	   try(			  
			    		Connection connection = new DB_Conn().getConnection();
						PreparedStatement pstatement = connection.prepareStatement(sql);){
	    		    
	    		   System.out.println(pstatement);
					  int rs = pstatement.executeUpdate();
					  
					  String message = "order has succesfully been deleted!";
					  request.setAttribute("message", message);
		              RequestDispatcher rd =request.getRequestDispatcher("admin_orders.jsp");
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
		
		if(request.getParameter("update_order")!=null){

	    	   String order_update_id = request.getParameter("order_id"); 
	    	   String update_payment = request.getParameter("update_payment"); 
	    	   String sql= "UPDATE `orders` SET payment_status = '"+update_payment+"' WHERE id = '"+order_update_id+"'";
	    	   try(			  
			    		Connection connection = new DB_Conn().getConnection();
						PreparedStatement pstatement = connection.prepareStatement(sql);){
	    		    
	    		   System.out.println(pstatement);
					  int rs = pstatement.executeUpdate();
					  
					  String message = "payment status has been updated!";
					  request.setAttribute("message", message);
		              RequestDispatcher rd =request.getRequestDispatcher("admin_orders.jsp");
		              rd.forward(request, response);
	    	   } catch (ClassNotFoundException | SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    	   
	    	   

	    	}

		if(request.getParameter("order_btn")!=null) {
			
			String placed_on = new SimpleDateFormat("dd MMM yyyy hh:mm:ss a").format(Calendar.getInstance().getTime());
			
			String id = request.getParameter("cart_id");
			String name = request.getParameter("name");
			String number = request.getParameter("number");
			String user_email = request.getParameter("email");
			String method = request.getParameter("method");
			String address = request.getParameter("flat")+" "+request.getParameter("street")+","+request.getParameter("city")+","+request.getParameter("province");
			String total_products = request.getParameter("cart_id");
			String total_price = request.getParameter("total_price");
			
			String sql = "select * from orders where name=? and number=? and user_email=? and method=? and address=? and total_products=? and total_price=?";
			  try(			  
			    		Connection connection = new DB_Conn().getConnection();
						PreparedStatement pstatement = connection.prepareStatement(sql);){
				  pstatement.setString(1, name);
				  pstatement.setString(2, number);
				  pstatement.setString(3, user_email);
				  pstatement.setString(4, method);
				  pstatement.setString(5, address);
				  pstatement.setString(6, total_products);
				  pstatement.setString(7, total_price);
				  
				  System.out.println(pstatement);
				  ResultSet rs = pstatement.executeQuery();
				  
				  if(rs.next()) {
					  String message = "This order has already been placed!";
					  request.setAttribute("message", message);
		              RequestDispatcher rd =request.getRequestDispatcher("check_out.jsp");
		              rd.forward(request, response);
				  }else {
					  sql ="insert into orders(name,number,user_email,method,address,total_products,total_price,placed_on)"+" values(?,?,?,?,?,?,?,?)";
					  PreparedStatement pstatement2= connection.prepareStatement(sql);
					  pstatement2.setString(1, name);
					  pstatement2.setString(2, number);
					  pstatement2.setString(3, user_email);
					  pstatement2.setString(4, method);
					  pstatement2.setString(5, address);
					  pstatement2.setString(6, total_products);
					  pstatement2.setString(7, total_price);
					  pstatement2.setString(8, placed_on );
					  
					  System.out.println(pstatement2);
					  int result = pstatement2.executeUpdate();
					  
					  pstatement2= connection.prepareStatement("DELETE FROM cart WHERE id="+id);
					  result = pstatement2.executeUpdate();
					  
					  String message = "Order succesfully placed!";
					  request.setAttribute("message", message);
					  request.getRequestDispatcher("AllBooks.jsp").forward(request,response);
				  }
			      
			    } catch (ClassNotFoundException | SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			
		}
	}

}
