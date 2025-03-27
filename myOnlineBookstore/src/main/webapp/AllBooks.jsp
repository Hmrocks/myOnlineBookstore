<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Complete Responsive Online Bookstore Website Design Tutorial</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css" />

    <!-- font awesome cdn link  -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <!-- custom css file link  -->
    <link rel="stylesheet" href="css/style-2.css">

</head>
<body>
        <%@page import="java.sql.ResultSet"%>
        <%@page import="java.sql.Statement"%>
        <%@page import="database.DB_Conn"%>
        <%@page import="java.sql.Connection"%>
        <%@page import="java.util.ArrayList"%>
        
        <%
        if(session.getAttribute("user")==null){ 
     %>
     
     <%@include file="JoinNow.jsp" %>
     
     <%
        }else{ 
     %>
     
     <%@include file="logout.jsp" %>
     <%
       if(request.getAttribute("delete")!=null){
    	   String delete_id = request.getParameter("delete");
    	   st = con.prepareStatement("DELETE FROM cart WHERE id='"+delete_id+"'");
           int result = st.executeUpdate();
       }
    
       if(request.getParameter("delete_all")!=null){
    	   st = con.prepareStatement("DELETE FROM cart WHERE user_email='"+email+"'");
           int result = st.executeUpdate();
       }
    %>
     <%
        } 
     %>
        
        <% 
  if(request.getAttribute("message")!= null){
%>
<div class="message2">
  <h2><%=request.getAttribute("message")%></h2>
</div>
<%
  }
        
%>
   <!-- Religion category starts here -->
<section class="allBooks" id="religion">

    <h1 class="heading"> <span>Religion</span> </h1>
  
    <div class="swiper allBooks-slider">
         
        <div class="swiper-wrapper">
        <%
           String sql = "SELECT * FROM books WHERE category ='religion'";
           Connection con = new DB_Conn().getConnection();
           Statement st = con.createStatement();
           ResultSet rs = st.executeQuery(sql);
           String title, author, price, category, imageFileName;
           
           while (rs.next()){ 
     	      author = rs.getString("author");
     	      title = rs.getString("title");
     	      price = rs.getString("price");
     	      imageFileName = rs.getString("imageFileName");   	      
         
        %>
            <div class="swiper-slide box">
              <div class="icons">
                   <a href="#" class="fas fa-search"></a>
                   <a href="#" class="fas fa-heart"></a>
                   <a href="#" class="fas fa-eye"></a>
              </div>
           <form action="Add_to_cart" method="post">
              <div class="image">
                   <img src="image/<%=imageFileName%>" alt="" >
              </div>
              <div class="content">
                   <div class="title"><h3><%=title%></h3></div> 
                   <h2><%=author%></h2>
                   <div class="price">¥<%=price%> <span>¥20.99</span></div>
                   <input type="hidden" name="book_title" value="<%=rs.getString("title") %>">
            	   <input type="hidden" name="book_price" value="<%=rs.getString("price") %>">
                   <input type="hidden" name="book_imgFileName" value="<%=rs.getString("imageFileName") %>">
   			       <input type="submit" class="btn" value="add to cart" name="add_to_cart">
              </div>
           </form>
         </div>
        <% 
           }        
        %> 
         
        </div>
        
        <div class="swiper-button-next"></div>
        <div class="swiper-button-prev"></div>
    
    </div>
  
</section>
   <!-- Religion category ends here -->
   
   <!-- Computer Science category starts here -->>
   
   <section class="allBooks" id="religion">

    <h1 class="heading"> <span>Computer Science</span> </h1>
  
    <div class="swiper allBooks-slider">
         
        <div class="swiper-wrapper">
        <%
            sql = "SELECT * FROM books WHERE category ='computer science'";
            rs = st.executeQuery(sql); 
           while (rs.next()){ 
     	      author = rs.getString("author");
     	      title = rs.getString("title");
     	      price = rs.getString("price");
     	      imageFileName = rs.getString("imageFileName");   	      
         
        %>
            <div class="swiper-slide box">
              <div class="icons">
                   <a href="#" class="fas fa-search"></a>
                   <a href="#" class="fas fa-heart"></a>
                   <a href="#" class="fas fa-eye"></a>
              </div>
         <form action="Add_to_cart" method="post">
              <div class="image">
                   <img src="image/<%=imageFileName%>" alt="" >
              </div>
              <div class="content">
                   <div class="title"><h3><%=title%></h3></div>
                   <h2><%=author%></h2>
                   <div class="price">¥<%=price%></div>
                   <input type="hidden" name="book_title" value="<%=rs.getString("title") %>">
            	   <input type="hidden" name="book_price" value="<%=rs.getString("price") %>">
                   <input type="hidden" name="book_imgFileName" value="<%=rs.getString("imageFileName") %>">
   			       <input type="submit" class="btn" value="add to cart" name="add_to_cart">
              </div>
           </form>
         </div>
        <% 
           }        
        %> 
         
        </div>
        
        <div class="swiper-button-next"></div>
        <div class="swiper-button-prev"></div>
    
    </div>
  
</section>
   
   <!-- Computer Science category ends here -->
   
   
   
   <!-- footer section starts  -->

<%@include file="footer.jsp" %>

<!-- footer section ends -->
   
   
   
   
<script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>

<!-- custom js file link  -->
<script src="js/script-.js"></script>
<script src="js/script-2.js"></script>
   
</body>
</html>
