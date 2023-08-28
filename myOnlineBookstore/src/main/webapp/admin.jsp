<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin page</title>

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
  <!-- admin dashboard section starts  -->

<section class="dashboard">

   <h1 class="title">dashboard</h1>

   <div class="box-container">

      <div class="box">
         <% 
            int total_pendings = 0;
            String sql  ="SELECT total_price FROM `orders` WHERE payment_status = 'pending'";
            Connection con = new DB_Conn().getConnection();
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

             if(rs.next()){   
            	do{
            		int total_price = Integer.parseInt(rs.getString("total_price"));
            		total_pendings += total_price;
            	}while(rs.next());
            	
            }
          %>
         <h3>¥<%=total_pendings%></h3>
         <p>total pendings</p>
      </div>

      <div class="box">
      
               
         <%
            int total_completed = 0;
            PreparedStatement st2 = con.prepareStatement("SELECT total_price FROM `orders` WHERE payment_status = 'completed'");
            ResultSet rs2 = st2.executeQuery();
            if(rs2.next()){   
            	do{
            		int total_price = Integer.parseInt(rs2.getString("total_price"));
            		total_completed += total_price;
            	}while(rs.next());
            	
            }
            %>
         <h3>¥<%=total_completed%></h3>
         <p>completed payments</p>
      </div>

      <div class="box">
        <%
          st2 = con.prepareStatement("select count(*) as orders_placed from orders");
          System.out.println(st2);
          rs2 = st2.executeQuery();
          rs2.next();
          String orders =rs2.getString("orders_placed");
        %>
         <h3><%=orders%></h3>
         <p>order placed</p>
      </div>

      <div class="box">
         <%
          st2 = con.prepareStatement("select count(*) as productsAdded from books");
          System.out.println(st2);
          rs2 = st2.executeQuery();
          rs2.next();
          String products =rs2.getString("productsAdded");
          %>
         <h3><%=products %></h3>
         <p>products added</p>
      </div>

      <div class="box">
          <%
          st2 = con.prepareStatement("select count(*) as normalUsers from `users` where user_type='user'");
          rs2 = st2.executeQuery();
          rs2.next();
          String normalUsers =rs2.getString("normalUsers");
        %>
         <h3><%=normalUsers%></h3>
         <p>normal users</p>
      </div>

      <div class="box">
          <%
          st2 = con.prepareStatement("select count(*) as adminUsers from `users` where user_type='admin'");
          rs2 = st2.executeQuery();
          rs2.next();
          String adminUsers =rs2.getString("adminUsers");
        %>
         <h3><%=adminUsers%></h3>
         <p>admin users</p>
      </div>

      <div class="box">
         <%
          st2 = con.prepareStatement("select count(*) as users from `users`");
          rs2 = st2.executeQuery();
          rs2.next();
          String users =rs2.getString("users");
        %>
         <h3><%=users%></h3>
         <p>total accounts</p>
      </div>

      <div class="box">
         <?php 
            $select_messages = mysqli_query($conn, "SELECT * FROM `message`") or die('query failed');
            $number_of_messages = mysqli_num_rows($select_messages);
         ?>
         <%
          st2 = con.prepareStatement("select count(*) from `message`");
          rs2 = st2.executeQuery();
          rs2.next();
          String messages =rs2.getString("count(*)");
        %>
         <h3><%=messages%></h3>
         <p>new messages</p>
      </div>

   </div>

</section>

<!-- admin dashboard section ends -->

<!-- custom admin js file link  -->
<script src="js/admin_script.js"></script>

</body>
</html>