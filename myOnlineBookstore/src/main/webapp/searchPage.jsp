<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search book page</title>
  <!-- font awesome cdn link  -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

   <!-- custom css file link  -->
   <link rel="stylesheet" href="css/style-ee.css">
</head>
<body>
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
        <%@page import="java.sql.ResultSet"%>
        <%@page import="java.sql.PreparedStatement"%>
        <%@page import="database.DB_Conn"%>
        <%@page import="java.sql.Connection"%>
<%
     if(request.getParameter("add_to_cart")!=null){
    	 
    	 String book_title = request.getParameter("book_title");
    	 String book_price = request.getParameter("book_price");
    	 String book_imgFileName = request.getParameter("book_imgFileName");
    	 User user= (User)session.getAttribute("user");
    	 String userEmail=user.getEmail();
    	 String sql2 ="select * from cart where title='"+book_title+"' and user_email='"+userEmail+"'";
    	
    	 Connection con = new DB_Conn().getConnection();
    	 PreparedStatement st = con.prepareStatement(sql2);
    	 ResultSet rs = st.executeQuery();
    	 
    	 if(rs.next()){
    		 out.println("<p class=\"empty\">Already added to cart!</p>");
    	 }else{
    		 
    		 sql2 ="insert into cart(user_email,title,price,imageFileName)"+" values(?,?,?,?)";
    		 st= con.prepareStatement(sql2);
    		 st.setString(1,userEmail);
    		 st.setString(1,book_title);
    		 st.setString(1,book_price);
    		 st.setString(1,book_imgFileName);
    		 
    		 rs = st.executeQuery();
    	 }
     }
   %>
   
   <section class="products" style="padding-top: 0;">
       <div class="box-container">
         <%
           if(request.getParameter("query")!=null && request.getParameter("query")!=""){
        	   System.out.println(request.getParameter("query"));
        	   String search_item = request.getParameter("query");
        	   String sql = "select * from books where concat_ws(author,title,publisher,category,ISBN) like ('%"+search_item+"%')";
        	   Connection con = new DB_Conn().getConnection();
               PreparedStatement st = con.prepareStatement(sql);
               ResultSet rs = st.executeQuery();
        	   
               if(!rs.next()){   
            	   out.println("<p class=\"empty\">no result found!</p>");
            	   }else{
            		   do{
           %>
            			   <form action="Add_to_cart" method="post" class="box">
            			      <img src="image/<%=rs.getString("imageFileName") %>" alt="" class="image">
            			      <div class="name"><%=rs.getString("title") %></div>
            			      <div class="price">¥<%=rs.getString("price") %></div>
            			      <input type="hidden" name="book_title" value="<%=rs.getString("title") %>">
            			      <input type="hidden" name="book_price" value="<%=rs.getString("price") %>">
            			      <input type="hidden" name="book_imgFileName" value="<%=rs.getString("imageFileName") %>">
            			      <input type="submit" class="btn" value="add to cart" name="add_to_cart">
            			   </form>
            			<%    
            		   }while(rs.next());
                    
            	   }
               }else{
                out.println("<p class=\"empty\">search something!</p>");
               }
         %>           
       </div>
   
   </section>
   
   
<!-- footer section starts  -->

<%@include file="footer.jsp" %>

<!-- footer section ends -->

<!-- custom js file link  -->

<script src="js/cy_script.js"></script>
</body>
</html>