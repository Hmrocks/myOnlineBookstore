<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>admin_products</title>
 <!-- font awesome cdn link  -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
   
<link rel="stylesheet" href="css/style-ee.css">
</head>
<body>
 <%@include file="admin_header.jsp" %>
 
 <!-- add book section starts  -->

<section class="add-products">

   <h1 class="title">shop books</h1>

   <form action="ProductServlet" method="post" enctype="multipart/form-data">
      <h3>add book</h3>
      <input type="text" name="title" class="box" placeholder="enter book title" required>
      <input type="number" min="0" name="price" class="box" placeholder="enter book price" required>
      <input type="text" name="isbn" class="box" placeholder="enter book isbn" required>
      <input type="text" name="author" class="box" placeholder="enter book author" required>
      <input type="text" name="category" class="box" placeholder="enter book category" required>
      <input type="text" name="publisher" class="box" placeholder="enter publisher name" required>
      <input type="number" min="0" name="year" class="box" placeholder="enter year of publication" required>
      <input type="file" name="image" accept="image/jpg, image/jpeg, image/png" class="box" required>
      <input type="submit" value="add book" name="add_book" class="btn">
   </form>

</section>

<!-- add book section ends -->
 
<!-- show books starts here -->
        <%@page import="java.sql.ResultSet"%>
        <%@page import="java.sql.PreparedStatement"%>
        <%@page import="database.DB_Conn"%>
        <%@page import="java.sql.Connection"%>
        <%@page import="java.util.ArrayList"%>
        <%@page import="java.io.PrintWriter"%>
        
<section class="show-products">

   <div class="box-container">
       <%@page import="java.io.PrintWriter" %>
       <%
           String sql = "SELECT * FROM books";
           Connection con = new DB_Conn().getConnection();
           PreparedStatement st = con.prepareStatement(sql);
           ResultSet rs = st.executeQuery();
           String title, author, price, category, imageFileName,ISBN;
           
           while (rs.next()){ 
     	      author = rs.getString("author");
     	      title = rs.getString("title");
     	      price = rs.getString("price");
     	      imageFileName = rs.getString("imageFileName");   	      
     	      ISBN = rs.getString("ISBN");
        %>
      <div class="box">
        <img src="image/<%=imageFileName%>" alt="" >
        <div class="name"><%=title%></div>
        <div class="price"><%=price%>¥</div>
        <a href="admin_products.jsp?update=<%=ISBN%>" class="option-btn">update</a>
        <a href="ProductServlet?delete=<%=ISBN%>" class="delete-btn" onclick="return confirm('delete this product?');">delete</a>
      </div>
      <% 
      }
      %>
   </div>

</section>
<!-- show books ends here -->



<!-- edit section starts here -->

 <section class="edit-product-form">

   <% 
      if(request.getParameter("update")!= null){
         String update_isbn = request.getParameter("update");
         
         sql = "SELECT * FROM books WHERE ISBN='"+update_isbn+"';";
         st = con.prepareStatement(sql);
         rs = st.executeQuery();
         
            while (rs.next()){
    %>
   <form action="ProductServlet" method="post" enctype="multipart/form-data">

      <input type="hidden" name="update_isbn" value="<%=rs.getString("ISBN") %>">
      <input type="hidden" name="old_image" value="<%=rs.getString("imageFileName") %>">
      <img src="image/<%=rs.getString("imageFileName") %>" alt="">
      <input type="text" name="update_title" value="<%=rs.getString("title") %>" class="box" required placeholder="enter product name">
      <input type="number" name="update_price" value="<%=rs.getString("price") %>" min="0" class="box" required placeholder="enter product price">
      <input type="file" class="box" name="new_image" accept="image/jpg, image/jpeg, image/png"> 
      <input type="submit" value="update" name="update_book" class="btn">
      <input type="reset" value="cancel" id="close-update" class="option-btn">
   </form>
   <script type="text/javascript">
   document.querySelector('#close-update').onclick = () =>{
	   document.querySelector('.edit-product-form').style.display = 'none';
	   window.location.href = 'admin_products.jsp';
	}
   </script>
   <% 
         }
      }else{
         out.println("<script>document.querySelector(\".edit-product-form\").style.display = \"none\";</script>");
      }
   %>

</section>
 
<!-- edit section ends here -->

<!-- custom admin js file link  -->
<script src="js/admin_script.js"></script> 

</body>
</html>
