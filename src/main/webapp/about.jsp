<%--
  Copyright 2017 Google Inc.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>
<!DOCTYPE html>
<html>
    <nav>
        <a id="navTitle" href="/">Chat It Up!</a>
        <% if(request.getSession().getAttribute("user") == null){ %>
          <a href="/login">Login</a>
          <a href="/register">Register</a>
        <% } else { %>
          <a href="/activityFeed">Recent Chatter</a>
          <a href="/conversations">Conversations</a>
          <a> | </a>
          <a>Hello <%= request.getSession().getAttribute("user") %>!</a>
          <a href="/login">Logout</a>
        <% } %>
      </nav>
<head>
  <title>CodeU Chat App</title>
  <link rel="stylesheet" href="/css/main.css">
</head>
<body>
  <div id="container">
    <div
      style="width:75%; margin-left:auto; margin-right:auto; margin-top: 50px;">

      <h1>About the CodeU Chat App</h1>
      <p>
        This is Chat It Up! Created by Emmanuel Teferi and Fran Penaranda, this 
        application is designed to be the next step in major chatting applications. 
        We want to create a secure chat app where users can easily communicate with 
        friends and check if there friends are users and what they are saying. 
        We also want this app to show message appropriate pictures to enhance 
        the chat experience. SPECIAL SHOUTOUT TO OUR ADVISOR KEVIN WANG FOR THE 
        AROUND THE CLOCK SUPPORT!
      </p>

      <ul>
        <li><strong>Picture messages:</strong> We've redesigned messaging as you know it to 
          have automatic visual display. Users have their own log in icon and our message
          design layout is top of the line! </li>
        <li><strong>Look and feel:</strong> We updated the design and user experience 
          from the basic layout we were given. New fonts, color schemes, navigations, 
          pages, and more have been altered to enhance your experience. An activity feed 
        feature allows you to see who else is in our Chat It Up community and see what 
        they are talking about. </li>
        <li><strong>Security:</strong> We have made sure that no user can access 
          the app before registering and loging in. We encrypt all stored passwords to 
          secure the information of our users. We also have a log in test designed
          to prevent malicious server attacks by making many fake users (human verification)</li>
      </ul>

      <p>
        This is your community! Feel free to post and tell your friends about ChatItUp: Connecting Made Simple.
      </p>
    </div>
  </div>
</body>
</html>
