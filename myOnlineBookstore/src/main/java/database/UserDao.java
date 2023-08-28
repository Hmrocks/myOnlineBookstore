package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import model.User;


public class UserDao {
     public int registerUser(User user) throws ClassNotFoundException {
    	 String INSERT_USERS_SQL = "INSERT INTO users" + 
    		       " (name, email, password, user_type) VALUES" + "(?,?,?,?);";
    			
    		     int result = 0;
    	 
    		 try(
    		     Connection connection = new DB_Conn().getConnection();
    	    		 
    	         //Creating preparedStatement using connection object
    	         PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USERS_SQL);){
    			 
        		 preparedStatement.setString(1, user.getName());
        		 preparedStatement.setString(2, user.getEmail());
        		 preparedStatement.setString(3, user.getPassword());
        		 preparedStatement.setString(4, user.getUser_type());
        		 
        		 System.out.println(preparedStatement);
        		 //Execute or update the query
        		 result = preparedStatement.executeUpdate();
        		 
    		 }	catch(SQLException ex) {
    		 
    		 ex.printStackTrace();
    	 }
    	 return result;
     }
}
