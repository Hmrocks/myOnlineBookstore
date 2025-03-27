<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>contact us</title>

 <!-- font awesome cdn link  -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

   <!-- custom css file link  -->
   <link rel="stylesheet" href="css/style-2.css">
</head>
<body>

     <%
        if(session.getAttribute("user")==null){ 
     %>
     
     <%@include file="JoinNow.jsp" %>
     
     <%
        }else{ 
     %>
     
     <%@include file="logout.jsp" %>
     
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

<div class="heading">
   <h3>contact us</h3>
   <p> <a href="home.php">home</a> / contact </p>
</div>

<section class="contact">

   <form action="ContactUs" method="post">
      <h3>say something!</h3>
      <input type="text" name="name" required placeholder="enter your name" class="box">
      <input type="email" name="email" required placeholder="enter your email" class="box">
      <input type="number" name="number" required placeholder="enter your number" class="box">
      <textarea name="message" class="box" placeholder="enter your message" id="" cols="30" rows="10"></textarea>
      <input type="submit" value="send message" name="send" class="btn">
   </form>

</section>

<!-- footer section starts  -->

<%@include file="footer.jsp" %>

<!-- footer section ends -->

<!-- custom js file link  -->

<script src="js/cy_script.js"></script>

</body>
</html>
