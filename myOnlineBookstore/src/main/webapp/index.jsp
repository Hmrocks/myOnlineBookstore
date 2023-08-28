<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cyrus' online bookstore</title>

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
<!-- header section starts  -->
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
<!-- header section ends -->

<% 
  if(request.getAttribute("message")!= null){
%>
<div class="message">
  <h2><%=request.getAttribute("message") %></h2>
</div>
<%
  }
%>
<!-- featured section starts  -->

<section class="featured" id="featured">

    <h1 class="heading"> <span>featured books</span> </h1>

    <div class="swiper featured-slider">

        <div class="swiper-wrapper">
            <%
           String sql = "SELECT * FROM books";
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

<!-- featured section ends -->

<!-- icons section starts  -->

<section class="icons-container">

    <div class="icons">
        <i class="fas fa-shipping-fast"></i>
        <div class="content">
            <h3>free shipping</h3>
            <p>order over 100</p>
        </div>
    </div>

    <div class="icons">
        <i class="fas fa-lock"></i>
        <div class="content">
            <h3>secure payment</h3>
            <p>100 secure payment</p>
        </div>
    </div>

    <div class="icons">
        <i class="fas fa-redo-alt"></i>
        <div class="content">
            <h3>easy returns</h3>
            <p>10 days returns</p>
        </div>
    </div>

    <div class="icons">
        <i class="fas fa-headset"></i>
        <div class="content">
            <h3>24/7 support</h3>
            <p>call us anytime</p>
        </div>
    </div>

</section>

<!-- icons section ends -->

<!-- home section starts  -->

<section class="home" id="home">

    <div class="row">

        <div class="content">
            <h3>upto 75% off</h3>
            <p> Starting from next month and valid for a whole week, for at least three From His Lips bought, you get up to 75% off your purchase!</p>
            <a href="#" class="btn">shop now</a>
        </div>

        <div class="swiper books-slider">
            <div class="swiper-wrapper">
        <%
           sql = "SELECT * FROM books WHERE title like'%From His Lips%'";
           st = con.createStatement();
           rs = st.executeQuery(sql);
           
           while (rs.next()){   	             
        %>
                <a href="#" class="swiper-slide"><img src="image/<%=rs.getString("imageFileName") %>" alt=""></a>
        <% 
           }        
        %> 
            </div>
            <img src="image/stand.png" class="stand" alt="">
        </div>

    </div>

</section>

<!-- home section ends here  -->


<!-- newsletter section starts -->

<section class="newsletter">

    <form action="">
        <h3>subscribe for latest updates</h3>
        <input type="email" name="" placeholder="enter your email" id="" class="box">
        <input type="submit" value="subscribe" class="btn">
    </form>

</section>

<!-- newsletter section ends -->

<!-- arrivals section starts  -->

<section class="arrivals" id="arrivals">

    <h1 class="heading"> <span>new arrivals</span> </h1>

    <div class="swiper arrivals-slider">

        <div class="swiper-wrapper">
         <%
           sql = "SELECT * FROM books WHERE category ='religion'";
           st = con.createStatement();
           rs = st.executeQuery(sql);
           
           while (rs.next()){ 
     	      author = rs.getString("author");
     	      title = rs.getString("title");
     	      price = rs.getString("price");
     	      imageFileName = rs.getString("imageFileName");   	      
         
        %>
          <a href="#" class="swiper-slide box">
             <form action="Add_to_cart" method="post">
                <div class="image">
                        <img src="image/<%=imageFileName%>" alt="" >
                </div>
                <div class="content">
                    <h3>new arrivals</h3>
                    <div class="price">¥ <%=price%></div>
                    <div class="stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                </div>
             </form>
            </a>
        <% 
           }        
        %> 
            

        </div>

    </div>

    <div class="swiper arrivals-slider">

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
         <a href="#" class="swiper-slide box">
             <form action="Add_to_cart" method="post">
                <div class="image">
                     <img src="image/<%=imageFileName%>" alt="" >
                </div>
                <div class="content">
                    <h3>new arrivals</h3>
                    <div class="price">¥ <%=price%></div>
                    <div class="stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                </div>
              </form>
         </a>
       <% 
           }        
        %> 

        </div>

    </div>

</section>

<!-- arrivals section ends -->

<!-- deal section starts  -->

<section class="deal">

    <div class="content">
        <h3>deal of the day</h3>
        <h1>upto 50% off</h1>
        <p>Lorem ipsum dolor sit amet consectetur, adipisicing elit. Unde perspiciatis in atque dolore tempora quaerat at fuga dolorum natus velit.</p>
        <a href="#" class="btn">shop now</a>
    </div>

    <div class="image">
        <img src="image/deal-img.jpg" alt="">
    </div>

</section>

<!-- deal section ends -->

<!-- reviews section starts  -->

<section class="reviews" id="reviews">

    <h1 class="heading"> <span>client's reviews</span> </h1>

    <div class="swiper reviews-slider">

        <div class="swiper-wrapper">

            <div class="swiper-slide box">
                <img src="image/pic-1.png" alt="">
                <h3>john deo</h3>
                <p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Aspernatur nihil ipsa placeat. Aperiam at sint, eos ex similique facere hic.</p>
                <div class="stars">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star-half-alt"></i>
                </div>
            </div>

            <div class="swiper-slide box">
                <img src="image/pic-2.png" alt="">
                <h3>john deo</h3>
                <p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Aspernatur nihil ipsa placeat. Aperiam at sint, eos ex similique facere hic.</p>
                <div class="stars">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star-half-alt"></i>
                </div>
            </div>

            <div class="swiper-slide box">
                <img src="image/pic-3.png" alt="">
                <h3>john deo</h3>
                <p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Aspernatur nihil ipsa placeat. Aperiam at sint, eos ex similique facere hic.</p>
                <div class="stars">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star-half-alt"></i>
                </div>
            </div>
            <div class="swiper-slide box">
                <img src="image/pic-4.png" alt="">
                <h3>john deo</h3>
                <p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Aspernatur nihil ipsa placeat. Aperiam at sint, eos ex similique facere hic.</p>
                <div class="stars">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star-half-alt"></i>
                </div>
            </div>

            <div class="swiper-slide box">
                <img src="image/pic-5.png" alt="">
                <h3>john deo</h3>
                <p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Aspernatur nihil ipsa placeat. Aperiam at sint, eos ex similique facere hic.</p>
                <div class="stars">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star-half-alt"></i>
                </div>
            </div>

            <div class="swiper-slide box">
                <img src="image/pic-6.png" alt="">
                <h3>john deo</h3>
                <p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Aspernatur nihil ipsa placeat. Aperiam at sint, eos ex similique facere hic.</p>
                <div class="stars">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star-half-alt"></i>
                </div>
            </div>

        </div>

    </div>
    
</section>

<!-- reviews section ends -->

<!-- blogs section starts  -->

<section class="blogs" id="blogs">

    <h1 class="heading"> <span>our blogs</span> </h1>

    <div class="swiper blogs-slider">

        <div class="swiper-wrapper">

            <div class="swiper-slide box">
                <div class="image">
                    <img src="image/blog-1.jpg" alt="">
                </div>
                <div class="content">
                    <h3>blog title goes here</h3>
                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Optio, odio.</p>
                    <a href="#" class="btn">read more</a>
                </div>
            </div>

            <div class="swiper-slide box">
                <div class="image">
                    <img src="image/blog-2.jpg" alt="">
                </div>
                <div class="content">
                    <h3>blog title goes here</h3>
                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Optio, odio.</p>
                    <a href="#" class="btn">read more</a>
                </div>
            </div>

            <div class="swiper-slide box">
                <div class="image">
                    <img src="image/blog-3.jpg" alt="">
                </div>
                <div class="content">
                    <h3>blog title goes here</h3>
                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Optio, odio.</p>
                    <a href="#" class="btn">read more</a>
                </div>
            </div>

            <div class="swiper-slide box">
                <div class="image">
                    <img src="image/blog-4.jpg" alt="">
                </div>
                <div class="content">
                    <h3>blog title goes here</h3>
                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Optio, odio.</p>
                    <a href="#" class="btn">read more</a>
                </div>
            </div>

            <div class="swiper-slide box">
                <div class="image">
                    <img src="image/blog-5.jpg" alt="">
                </div>
                <div class="content">
                    <h3>blog title goes here</h3>
                    <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Optio, odio.</p>
                    <a href="#" class="btn">read more</a>
                </div>
            </div>

        </div>

    </div>

</section>

<!-- blogs section ends -->

<!-- footer section starts  -->

<%@include file="footer.jsp" %>

<!-- footer section ends -->

<!-- loader  -->

<!-- <div class="loader-container">
    <img src="image/loader-img.gif" alt="">
</div> -->
















<script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>

<!-- custom js file link  -->

<script src="js/cy_script.js"></script>
</body>
</html>