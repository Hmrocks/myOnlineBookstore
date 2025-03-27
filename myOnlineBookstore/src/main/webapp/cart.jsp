<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Cart</title>

   <!-- font awesome cdn link  -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

   <!-- custom css file link  -->
   <link rel="stylesheet" href="css/style-2.css">

</head>
<body>
    
    <%if(session.getAttribute("user")== null){
      response.sendRedirect("index.jsp");	
    }
    %>
    <%@include file="logout.jsp" %>
    
    <div class="heading">
       <h3>shopping cart</h3>
       <p> <a href="AllBooks.jsp">home</a> / cart </p>
    </div>

<section class="shopping-cart">

   <h1 class="title">Books added</h1>

   <div class="box-container">
      <% 
           int grand_total = 0;
           sql = "SELECT * FROM `cart` WHERE user_email = '"+email+"'";
           st = con.prepareStatement(sql);
           rs = st.executeQuery();
           
           if(!rs.next()){   
        	   out.println("<p class=\"empty\">Your cart is empty!</p>");
        	   }else{
        		   do{
      %>   
    
      <div class="box">
         <a href="cart.jsp?delete=<%=rs.getString("id") %>" class="fas fa-times" onclick="return confirm('delete this from cart?');"></a>
         <img src="image/<%=rs.getString("imageFileName") %>" alt="">
         <div class="name"><%=rs.getString("book_title") %></div>
         <div class="price">¥<%=rs.getString("price") %></div>
         <form action="" method="post">
            <input type="hidden" name="cart_id" value="<%=rs.getString("id") %>">
            <input type="submit" name="update_cart" value="update" class="option-btn">
         </form>
      </div>
      <%
        	         }while(rs.next());
        	      }
      %>
      
   </div>

     <% 
          st = con.prepareStatement("select sum(price) from cart WHERE user_email = '"+email+"'");
          rs = st.executeQuery();
          rs.next();
          if(rs.getString("sum(price)")!=null){
        	  grand_total = Integer.parseInt(rs.getString("sum(price)"));
          }
       %>

   <div style="margin-top: 2rem; text-align:center;">
      <a href="cart.jsp?delete_all" class="cartDelete <%if(grand_total<1){%>disabled<%}%>" onclick="return confirm('delete all from cart?');">delete all</a>
   </div>

   <div class="cart-total">
       
      <p>grand total : <span>¥<%=grand_total %></span></p>
      <div class="flex">
         <a href="AllBooks.jsp" class="option-btn">continue shopping</a>
         <a href="check_out.jsp" class="btn <%if(grand_total<1){%>disabled<%}%>">proceed to checkout</a>
      </div>
   </div>

</section>

   <!-- footer section starts  -->

<%@include file="footer.jsp" %>

<!-- footer section ends -->
    
</body>
</html>
