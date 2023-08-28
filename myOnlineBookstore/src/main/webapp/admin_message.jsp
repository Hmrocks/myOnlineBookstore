<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Messages</title>

 <!-- font awesome cdn link  -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

   <!-- custom admin css file link  -->
   <link rel="stylesheet" href="css/style-ee.css">

</head>
<body>

 <%@include file="admin_header.jsp" %>
     <%@page import="java.sql.ResultSet"%>
     <%@page import="java.sql.PreparedStatement"%>
     <%@page import="database.DB_Conn"%>
     <%@page import="java.sql.Connection"%>

<section class="messages">

   <h1 class="title"> messages </h1>

   <div class="box-container">
   <% 
           String sql = "SELECT * FROM `message`";
           Connection con = new DB_Conn().getConnection();
           PreparedStatement st = con.prepareStatement(sql);
           ResultSet rs = st.executeQuery();
           
           if(!rs.next()){   
        	   out.println("<p class=\"empty\">you have no messages!</p>");
        	   }else{
        		   do{
      %>   
   <div class="box">
      <p> name : <span><%=rs.getString("name") %></span> </p>
      <p> number : <span><%=rs.getString("number") %></span> </p>
      <p> email : <span><%=rs.getString("email") %></span> </p>
      <p> message : <span><%=rs.getString("message") %></span> </p>
      <a href="admin_message.jsp?delete=<%=rs.getString("id") %>" onclick="return confirm('delete this message?');" class="delete-btn">delete message</a>
   </div>
    <%
        	         }while(rs.next());
        	      }
      %>
   </div>

</section>
<%
  if(request.getParameter("delete")!=null){
	  String delete_id = request.getParameter("delete");
	  sql="DELETE FROM `message` WHERE id ='"+delete_id+"'";
	  st = con.prepareStatement(sql);
	  int result = st.executeUpdate();
	  RequestDispatcher rd =request.getRequestDispatcher("admin_message.jsp");
      rd.forward(request, response);
  }
%>
<!-- custom admin js file link  -->
<script src="js/admin_script.js"></script>


</body>
</html>