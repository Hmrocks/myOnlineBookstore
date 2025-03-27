<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin orders</title>

  <!-- font awesome cdn link  -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

   <!-- custom admin css file link  -->
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
     <%@page import="java.sql.PreparedStatement"%>
     <%@page import="database.DB_Conn"%>
     <%@page import="java.sql.Connection"%>
<section class="orders">

   <h1 class="title">placed orders</h1>

   <div class="box-container">
       <% 
           int grand_total = 0;
           String sql = "SELECT * FROM `orders`";
           Connection con = new DB_Conn().getConnection();
           PreparedStatement st = con.prepareStatement(sql);
           ResultSet rs = st.executeQuery();
           
           if(!rs.next()){   
        	   out.println("<p class=\"empty\">no orders placed yet!</p>");
        	   }else{
        		   do{
      %>   
      <div class="box">
         <p> user id : <span><%=rs.getString("id") %></span> </p>
         <p> placed on : <span><%=rs.getString("placed_on") %></span> </p>
         <p> name : <span><%=rs.getString("name") %></span> </p>
         <p> number : <span><%=rs.getString("number") %></span> </p>
         <p> email : <span><%=rs.getString("user_email") %></span> </p>
         <p> address : <span><%=rs.getString("address") %></span> </p>
         <p> total products : <span><%=rs.getString("total_products") %></span> </p>
         <p> total price : <span>¥<%=rs.getString("total_price") %></span> </p>
         <p> payment method : <span><%=rs.getString("method") %></span> </p>
         <form action="Order" method="post">
            <input type="hidden" name="order_id" value="<%=rs.getString("id") %>">
            <select name="update_payment">
               <option value="" selected disabled><%=rs.getString("payment_status") %></option>
               <option value="pending">pending</option>
               <option value="completed">completed</option>
            </select>
            <input type="submit" value="update" name="update_order" class="option-btn">
            <a href="Order?delete=<%=rs.getString("id") %>" onclick="return confirm('delete this order?');" class="delete-btn">delete</a>
         </form>
      </div>
      <%
        	         }while(rs.next());
        	      }
      %>
   </div>

</section>
<!-- custom admin js file link  -->
<script src="js/admin_script.js"></script>

</body>
</html>
