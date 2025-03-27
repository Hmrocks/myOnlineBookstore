<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Users</title>

 <!-- font awesome cdn link  -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
   
<link rel="stylesheet" href="css/style-ee.css">
</head>
<body>
<%@include file="admin_header.jsp" %>

  <% 
  if(request.getAttribute("message")!= null){
%>
<div class="message2">
  <h2><%=request.getAttribute("message")%></h2>
</div>
<%
  }
        
%>
        <%@page import="java.sql.ResultSet"%>
        <%@page import="java.sql.Statement"%>
        <%@page import="java.sql.PreparedStatement"%>
        <%@page import="database.DB_Conn"%>
        <%@page import="java.sql.Connection"%>
        
 <section class="users">

   <h1 class="title"> user accounts </h1>

   <div class="box-container">
      <% 
          String sql = "SELECT * FROM users";
           Connection con = new DB_Conn().getConnection();
           Statement st = con.createStatement();
           ResultSet rs = st.executeQuery(sql);

         while(rs.next()){
       %>
      <div class="box">
         <p> user id : <span><%=rs.getString("id") %></span> </p>
         <p> username : <span><%=rs.getString("name") %></span> </p>
         <p> email : <span><%=rs.getString("email") %></span> </p>
         <p> user type : <span style="color:<%if(rs.getString("user_type") == "admin"){%>'var(--orange)'<%}%>"><%=rs.getString("user_type") %></span> </p>
         <a href="DeleteUser?delete=<%=rs.getString("id") %>" onclick="return confirm('delete this user?');" class="delete-btn">delete user</a>
      </div>
     <%
         }
     %>
   </div>

</section>

<!-- custom admin js file link  -->
<script src="js/admin_script.js"></script>
   
</body>
</html>
