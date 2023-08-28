<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css" />

    <!-- font awesome cdn link  -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- custom css file link  -->
    <link rel="stylesheet" href="css/style-2.css">
 
</head>
<body>

     <%@page import="model.User"%>
     <%@page import="java.sql.ResultSet"%>
     <%@page import="java.sql.PreparedStatement"%>
     <%@page import="database.DB_Conn"%>
     <%@page import="java.sql.Connection"%>
     
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

     <header class="header logout-header">

           <div class="header-1">

                <a href="index.jsp" class="logo"> <img class="logo1" alt="logo1" src="image/logo1.png"> </a>

                <form action="searchPage.jsp" method="post" class="search-form">
                    <input type="search" name="query" placeholder="search book by title/author/category/isbn..." id="search-box">
                    <button type="submit" id="searchBtn"><label for="search-box" class="fas fa-search"></label></button> 
                </form>
          
                <div class="icons">
                    <div id="search-btn" class="fas fa-search"></div>
                    <!-- <a href="#" class="fas fa-heart"></a> -->
                    <!-- <div id="user-btn" class="fas fa-user"></div> -->
                    <%
                       String sql ="select count(*) from cart where user_email='"+email+"'";
                	
               	       Connection con = new DB_Conn().getConnection();
               	       PreparedStatement st = con.prepareStatement(sql);
               	       ResultSet rs = st.executeQuery();
               	       rs.next();
                    %>
                    <a href="cart.jsp" class="fas fa-shopping-cart"> <span><%=rs.getString("count(*)")%></span> </a>
                    
                     <div class="user_details">
                      
                   
                         <a href="userInfo.jsp" ><%=printName%></a>
                         <button type="button"  class="delete-btn"> <a href="LogoutServlet">logout</a></button>
                     </div>
                </div>
           
           </div>

           <div class="header-2">
           
               <nav class="navbar">
                   <a href="AllBooks.jsp">Category</a>
                   <a href="#featured">featured</a>
                   <a href="#arrivals">arrivals</a>
                   <a href="#reviews">reviews</a>
                   <a href="contactUs.jsp">contact us</a>
                   <a href="#blogs">FAQ</a>
               </nav> 
     
           </div>
           
     </header>
     
</body>
</html>