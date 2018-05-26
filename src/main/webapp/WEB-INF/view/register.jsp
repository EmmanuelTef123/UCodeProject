
<%@ page import="java.util.List" %>
<%@ page import="java.util.Random" %>


<!DOCTYPE html>
<html>
<head>
 <title>Register</title>
 <link rel="stylesheet" href="/css/main.css">
 <style>
   label {
     display: inline-block;
     width: 100px;
   }
 </style>
</head>
<body>

  <nav>
   <a>Chat It Up: Connecting Made Simple </a>
 </nav>
 <div id="container">
   <h1>Register</h1>

   <% if(request.getAttribute("error") != null){ %>
       <h2 style="color:red"><%= request.getAttribute("error") %></h2>
   <% } %>

   <form action="/register" method="POST">
     <label for="username">Username: </label>
     <input type="text" name="username" id="username">
     <br/>

     <label for="password">Password: </label>
     <input type="password" name="password" id="password">

     <label for="confirmPassword">Confirm Password: </label>
     <input type="password" name="confirmPassword" id="confirmPassword">
     <br/><br/>

     <form>
        <p>Please select the food you asscoiate yourelf with the most:</p>
        <div>
          <input type="radio" id="contactChoice1"
                 name="idPic" value="https://st3.depositphotos.com/1007168/14191/v/1600/depositphotos_141915462-stock-illustration-smiling-steak-cartoon.jpg">
          <label for="contactChoice1"><img src= "https://st3.depositphotos.com/1007168/14191/v/1600/depositphotos_141915462-stock-illustration-smiling-steak-cartoon.jpg" height= "50" width = "50"></label>
          <input type="radio" id="contactChoice2"
                 name="idPic" value="http://confettipark.com/wp-content/uploads/2018/03/27faf1d9640ce107eb6b0ad08cee67da.jpg">
          <label for="contactChoice2"><img src= "http://confettipark.com/wp-content/uploads/2018/03/27faf1d9640ce107eb6b0ad08cee67da.jpg" height= "50" width = "50"></label>
          <input type="radio" id="contactChoice3"
                 name="idPic" value="https://st2.depositphotos.com/1742172/9684/v/950/depositphotos_96843646-stock-illustration-textured-cartoon-salad.jpg">
          <label for="contactChoice3"><img src= "https://st2.depositphotos.com/1742172/9684/v/950/depositphotos_96843646-stock-illustration-textured-cartoon-salad.jpg" height= "50" width = "50"></label>
        </div>
      </form>
      <br/><br/>


     <%String currentPic = (String) request.getAttribute("currentPicAddress");
     System.out.println(currentPic);
     %>
     <center><img src= <%=currentPic%> alt="registrationTestPic!" width="350" height="350"></center>

     <br/><br/>
     <label for="humanVerification">Human Verification: </label>
     <input type="text" name="humanVerification" id="humanVerification">
     <p>(To get a new image, refresh this page)</p>


     <br/><br/>

     <button type="submit">Submit</button>
   </form>
   <p>Already have an account? <a href="/login">Login Here!</a></p>
 </div>
</body>
</html>
