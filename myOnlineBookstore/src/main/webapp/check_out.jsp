<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>checkout</title>

  <!-- font awesome cdn link  -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

   <!-- custom css file link  -->
   <link rel="stylesheet" href="css/style.css">

</head>
<body>

    <%@include file="logout.jsp" %>
<% 
  if(request.getAttribute("message")!= null){
%>
<div class="message">
  <h2><%=request.getAttribute("message") %></h2>
</div>
<%
  }
%>

<div class="heading">
   <h3>checkout</h3>
   <p> <a href="AllBooks.jsp">home</a> / checkout </p>
</div>

<section class="display-order">

   <%  
      int grand_total = 0;
      String cart_id= "";
           sql = "SELECT * FROM `cart` WHERE user_email = '"+email+"'";
           st = con.prepareStatement(sql);
           rs = st.executeQuery();
           
           if(!rs.next()){   
        	   out.println("<p class=\"empty\">Your cart is empty!</p>");
        	   }else{
        		   do{
        			   cart_id=rs.getString("id");
   %>
   <p> <%=rs.getString("book_title") %> <span>(¥<%=rs.getString("price") %>)</span> </p>
   <% 
      }while(rs.next());
   }
   %>
   
      <% 
          st = con.prepareStatement("select sum(price) from cart WHERE user_email = '"+email+"'");
          rs = st.executeQuery();
          rs.next();
          if(rs.getString("sum(price)")!=null){
        	  grand_total = Integer.parseInt(rs.getString("sum(price)"));
          }else{
        	  out.println("<p class=\"empty\">Your cart is empty!</p>");
          }
          
       %>
   <div class="grand-total"> grand total : <span>¥<%=grand_total %></span> </div>

</section>

<section class="checkout">

   <form action="Order" method="post">
      <h3>place your order</h3>
      <div class="flex">
         <div class="inputBox">
            <span>your name :</span>
            <input type="text" name="name" required placeholder="enter your name">
         </div>
         <div class="inputBox">
            <span>your number :</span>
            <input type="number" name="number" required placeholder="enter your number">
         </div>
         <div class="inputBox">
            <span>your email :</span>
            <input type="email" name="email" required placeholder="enter your email">
         </div>
         <div class="inputBox">
            <span>payment method :</span>
            <select name="method">
               <option value="cash on delivery">cash on delivery</option>
               <option value="credit card">credit card</option>
               <option value="paypal">paypal</option>
               <option value="paytm">paytm</option>
            </select>
         </div>
         <div class="inputBox">
            <span>address line 01 :</span>
            <input type="number" min="0" name="flat" required placeholder="e.g. flat no.">
         </div>
         <div class="inputBox">
            <span>address line 02 :</span>
            <input type="text" name="street" required placeholder="e.g. street name">
         </div>
         <div class="inputBox">
            <span>city :</span>
            <input type="text" name="city" required placeholder="e.g. Nanjing">
         </div>
         <div class="inputBox">
            <span>state :</span>
            <input type="text" name="province" required placeholder="e.g. Jiangsu">
         </div>
         <div class="inputBox">
            <span>country :</span>
            <input type="text" name="country" required placeholder="e.g. China">
         </div>
         <div class="inputBox">
            <span>postal code :</span>
            <input type="number" min="0" name="pin_code" required placeholder="e.g. 123456">
         </div>
      </div>
      <input type="hidden" name="cart_id" value="<%=cart_id%>">
      <input type="hidden" name="email" value="<%=email%>">
      <input type="hidden" name="total_price" value="<%=grand_total%>">
      <input type="submit" value="order now" class="btn" name="order_btn">
   </form>

</section>


</body>
</html>