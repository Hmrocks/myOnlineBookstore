<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css" />

    <!-- font awesome cdn link  -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- custom css file link  -->
    <link rel="stylesheet" href="css/style-ee.css">

</head>
<body>

     <%@page import="model.User"%>
     
     <%
       User user = (User) session.getAttribute("user");
       String userName = user.getName();
       String email = user.getEmail();
       
       String printName;
       if(userName == null){
    	   printName = email;
       } else{
    	   printName = userName;
       }
     %>
     
  <header class="header">

   <div class="flex">
      <a href="admin.jsp" class="logo"> <img class="logo1" alt="logo1" src="image/logo1.png"> </a>
      <a href="admin_page.php" class="logo">Admin<span>Panel</span></a>

      <nav class="navbar">
         <a href="admin.jsp">home</a>
         <a href="admin_products.jsp">products</a>
         <a href="admin_orders.jsp">orders</a>
         <a href="admin_users.jsp">users</a>
         <a href="admin_message.jsp">messages</a>
      </nav>

      <div class="icons">
         <div id="menu-btn" class="fas fa-bars"></div>
         <div id="user-btn" class="fas fa-user"></div>
      </div>

      <div class="account-box">
         <p>username : <span><%=printName %></span></p>
         <p>email : <span><%=email %></span></p>
         <a href="LogoutServlet" class="delete-btn">logout</a>
         <div>new <a href="#login-form-container">login</a> | <a href="#login-form-container">register</a></div>
      </div>

   </div>

</header>

<script src="js/admin_script.js"></script>
</body>
</html>
