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
    <link rel="stylesheet" href="css/style-2.css">
</head>
<body>
    <header class="header">

    <div class="header-1">

        <a href="index.jsp" class="logo"> <img class="logo1" alt="logo1" src="image/logo1.png"> </a>

        <form action="searchPage.jsp" method="post" class="search-form">
             <input type="search" name="query" placeholder="search book by title/author/category/isbn..." id="search-box">
             <button type="submit" id="searchBtn"><label for="search-box" class="fas fa-search"></label></button> 
        </form>
    
        <div class="icons">
            <div id="search-btn" class="fas fa-search"></div>
             <!-- <a href="#" class="fas fa-heart"></a> -->
            <div id="login-btn" class="fas fa-user"></div>
            <a href="cart.jsp" class="fas fa-shopping-cart"></a>
            <div id="menu-btn" class="fas fa-bars"></div>
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


       
    
    
<!-- login & register form start here -->

<div class="login-form-container">
    
    
    <div id="close-login-btn" class="fas fa-times"></div>

    <div>
        <form action="LoginServlet" method="post">
            <h3>sign in</h3>
            <span>username</span>
            <input type="email" name="email" class="box" placeholder="enter your email" id="">
            <span>password</span>
            <input type="password" name="password" class="box" placeholder="enter your password" id="">
            <div class="checkbox">
               <input type="checkbox" name="" id="remember-me">
               <label for="remember-me"> remember me</label>
            </div>
            <input type="submit" value="sign in" class="btn">
           <p>forgot password ? <a href="#">click here</a></p>

        </form>
    </div>
     
    <div>
       <form  id="form" action="RegisterServlet" method="post">
        <h3>Register</h3>
     <div class="input-control">
        <span>username</span>
        <input type="text" name="user_name" class="box" placeholder="enter your name" id="username">
         <div class="error"></div>
     </div>
     <div class="input-control">
        <span>e-mail</span>
        <input type="email" name="email" class="box" placeholder="enter your email" id="email">
        <div class="error"></div>
     </div>
     <div class="input-control">
        <span>password</span>
        <input type="password" name="password" class="box" placeholder="enter your password" id="password">
        <div class="error"></div>
     </div> 
     <div class="input-control">
        <input type="password" name="password2" class="box" placeholder="confirm password" id="password2">
        <div class="error"></div>
     </div> 
        <select name="user_type" class="">
            <option value="user">user</option>
            <option value="admin">admin</option>
        </select>
        <div class="checkbox">
            <input type="checkbox" name="" id="remember-me">
            <label for="remember-me"> remember me</label>
        </div>
        <input type="submit" value="sign up" class="btn">
        <p>forgot password ? <a href="#">click here</a></p>
    </form>
    </div>
</div>
<!-- login & register form end here -->
 
 
 <!-- js file link -->
 
</body>
</html>
