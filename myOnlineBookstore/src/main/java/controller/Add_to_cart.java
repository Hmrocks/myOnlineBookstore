package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
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

/**
 * Servlet implementation class Add_to_cart
 */
public class Add_to_cart extends HttpServlet {
	private static final long serialVersionUID = 1L;
        private static final String MESSAGE_ATTRIBUTE = "message";
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Add_to_cart() {
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
		
		PrintWriter out = response.getWriter();
 		
		String book_title = (String) request.getParameter("book_title"),
				book_price= (String) request.getParameter("book_price"),book_imgFileName= (String) request.getParameter("book_imgFileName");
		
		
		String sql = "select * from cart where book_title=? and user_email=?";
		
		System.out.println(request.getSession().getAttribute("user"));
		if(request.getSession().getAttribute("user")!=null) {
			HttpSession session = request.getSession();
			User user = (User)session.getAttribute("user");
			String userEmail=user.getEmail();
			System.out.println(userEmail);
			  try(
			    		Connection connection = new DB_Conn().getConnection();
						PreparedStatement pstatement = connection.prepareStatement(sql);){
				  pstatement.setString(1, book_title);
				  pstatement.setString(2, userEmail);
				  
				  System.out.println(pstatement);
				  ResultSet rs = pstatement.executeQuery();
				  
				  if(rs.next()) {
					  String message = "You already have this item in your cart!";
					  request.setAttribute(MESSAGE_ATTRIBUTE, message);
		              RequestDispatcher rd =request.getRequestDispatcher("index.jsp");
		              rd.forward(request, response);
				  }else {
					  sql ="insert into cart(user_email,book_title,price,imageFileName)"+" values(?,?,?,?)";
					  PreparedStatement pstatement2= connection.prepareStatement(sql);
					  pstatement2.setString(1,userEmail);
					  pstatement2.setString(2,book_title);
					  pstatement2.setString(3,book_price);
					  pstatement2.setString(4,book_imgFileName);
					  
					  System.out.println(pstatement2);
					  int result = pstatement2.executeUpdate();
					  String message = "Book succesfully added to cart!";
					  request.setAttribute(MESSAGE_ATTRIBUTE, message);
					  request.getRequestDispatcher("AllBooks.jsp").forward(request,response);
				  }
			      
			    } catch (ClassNotFoundException | SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			  
		}else {
			String message = "Please login first!";
			  request.setAttribute(MESSAGE_ATTRIBUTE, message);
            RequestDispatcher rd =request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);
		}
				
		
	}

}
