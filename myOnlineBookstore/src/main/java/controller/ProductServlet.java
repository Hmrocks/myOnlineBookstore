package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import database.DB_Conn;

/**
 * Servlet implementation class ProductServlet
 */
@MultipartConfig
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
System.out.println(request.getParameter(request.getParameter("delete")));
		
		if(request.getParameter("delete")!=null) {
			String delete_isbn = request.getParameter("delete");
		    String sql ="SELECT imageFileName FROM books WHERE ISBN=?";
		    
		    try(Connection connection = new DB_Conn().getConnection();
   	    		 
	    	         //Creating preparedStatement using connection object
	    	         PreparedStatement preparedStatement = connection.prepareStatement(sql);){
		    	preparedStatement.setString(1,delete_isbn);
		    	
		    	ResultSet rs = preparedStatement.executeQuery();
		    	rs.next();
		    	File file = new File("C:/Users/ASUS/eclipse-workspace/myOnlineBookstore/src/main/webapp/image/"+rs.getString("imageFileName"));
		    	if(file.delete()) {
		    	   System.out.println("File succesfully deleted! ");	
		    	}
		    	
		        int result = preparedStatement.executeUpdate("DELETE FROM books WHERE ISBN='"+delete_isbn+"'"); 
		    	
		    } catch (SQLException | ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		    request.getRequestDispatcher("admin_products.jsp").forward(request,response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
		if(request.getParameter("update_book")!=null) {
			 System.out.println("Within if condition");
			//Part file = request.getPart("image");
			//String imageFileName = file.getSubmittedFileName();
			//System.out.println("Selected fileName: "+imageFileName);
			
			//String uploadPath = "C:/Users/ASUS/eclipse-workspace/myOnlineBookstore/src/main/webapp/image/"+imageFileName;
			
			String update_ISBN = request.getParameter("update_isbn");
			String update_title = request.getParameter("update_title");
			String update_price = request.getParameter("update_price");
			
			String sql ="UPDATE books SET title=?,price=? WHERE ISBN=?";
			
			 try(
	    		     Connection connection = new DB_Conn().getConnection();
	    	    		 
	    	         //Creating preparedStatement using connection object
	    	         PreparedStatement preparedStatement = connection.prepareStatement(sql);){
	    			 
	        		 preparedStatement.setString(1, update_title);
	        		 preparedStatement.setString(2, update_price);
	        		 preparedStatement.setString(3, update_ISBN);
	        		 
	        		 System.out.println(preparedStatement);
	        		 //Execute or update the query
	        		 int result = preparedStatement.executeUpdate();
	        		 
	    		 } catch (ClassNotFoundException | SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}	
			 
			
			 
			 request.getRequestDispatcher("admin_products.jsp").forward(request,response);
		}
		
		
		if(request.getParameter("add_book")!=null) {
			String title = request.getParameter("title");
			String price = request.getParameter("price");
			String isbn = request.getParameter("isbn");
			String author = request.getParameter("author");
			String category = request.getParameter("category");
			String publisher = request.getParameter("publisher");		
			String year = request.getParameter("year");
			
			Part file = request.getPart("image");
			String imageFileName = file.getSubmittedFileName();
			System.out.println("Selected fileName: "+imageFileName);
			
			String uploadPath = "C:/Users/ASUS/eclipse-workspace/myOnlineBookstore/src/main/webapp/image/"+imageFileName;
			System.out.println("Selected uploadpath: "+uploadPath);
			try {
				
				FileOutputStream fileOutputstream = new FileOutputStream(uploadPath);
				InputStream inputStream = file.getInputStream();
				
				byte[] b = new byte[inputStream.available()];
				inputStream.read(b);
				fileOutputstream.write(b);
				fileOutputstream.close();
				} catch(Exception ex) {
					ex.printStackTrace();
				}
			
			String sql ="INSERT INTO books(ISBN,author,title,category,publisher,year,price,imageFileName)"
					+" VALUES(?,?,?,?,?,?,?,?)";
			
			try(
	    		     Connection connection = new DB_Conn().getConnection();
	    	    		 
	    	         //Creating preparedStatement using connection object
	    	         PreparedStatement preparedStatement = connection.prepareStatement(sql);){
	    			 
	        		 preparedStatement.setString(1, isbn);
	        		 preparedStatement.setString(2, author);
	        		 preparedStatement.setString(3, title);
	        		 preparedStatement.setString(4, category);
	        		 preparedStatement.setString(5, publisher);
	        		 preparedStatement.setString(6, year);
	        		 preparedStatement.setString(7, price);
	        		 preparedStatement.setString(8, imageFileName);
	        		
	        		 
	        		 System.out.println(preparedStatement);
	        		 //Execute or update the query
	        		 int result = preparedStatement.executeUpdate();
	        		 
	    		 } catch (ClassNotFoundException | SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}	
			 request.getRequestDispatcher("admin_products.jsp").forward(request,response);
		}
		
		
	}

}
