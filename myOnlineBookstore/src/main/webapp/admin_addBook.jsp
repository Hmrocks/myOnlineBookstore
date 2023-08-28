<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add book page</title>

<!-- font awesome cdn link  -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
   
<link rel="stylesheet" href="css/style-ee.css">
</head>
<body>
 <%@include file="admin_header.jsp" %>
 
 <!-- add book section starts  -->

<section class="add-products">

   <h1 class="title">shop books</h1>

   <form action="" method="post" enctype="multipart/form-data">
      <h3>add book</h3>
      <input type="text" name="title" class="box" placeholder="enter book title" required>
      <input type="number" min="0" name="price" class="box" placeholder="enter book price" required>
      <input type="file" name="image" accept="image/jpg, image/jpeg, image/png" class="box" required>
      <input type="submit" value="add book" name="add_book" class="btn">
   </form>

</section>

<!-- add book section ends -->
</body>
</html>