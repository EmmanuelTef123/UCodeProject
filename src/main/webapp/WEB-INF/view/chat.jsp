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
<%@ page import="java.util.List" %>
<%@ page import="codeu.model.data.Conversation" %>
<%@ page import="codeu.model.data.Message" %>
<%@ page import="codeu.model.store.basic.UserStore" %>
<%@ page import="codeu.model.data.User" %>
<%
Conversation conversation = (Conversation) request.getAttribute("conversation");
List<Message> messages = (List<Message>) request.getAttribute("messages");
String url = (String) request.getAttribute("image");
UserStore currentUserStash = UserStore.getInstance();
%>

<!DOCTYPE html>
<html>
    <nav>
        <a id="navTitle" href="/">Chat It Up!</a>
        <% if(request.getSession().getAttribute("user") == null){ %>
          <a href="/about.jsp">About</a>
          <a href="/login">Login</a>
          <a href="/register">Register</a>
        <% } else { %>
          <a href="/about.jsp">About</a>
          <a href="/activityFeed">Recent Chatter</a>
          <a href="/conversations">Conversations</a>
          <a> | </a>
          <a>Hello <%= request.getSession().getAttribute("user") %>!</a>
          <a href="/login">Logout</a>
        <% } %>
      </nav>
<head>
  <title><%= conversation.getTitle() %></title>
  <link rel="stylesheet" href="/css/main.css" type="text/css">

  <style>
    #chat {
      background-color: white;
      height: 500px;
      overflow-y: scroll
    }
  </style>

  <script>
    // scroll the chat div to the bottom
    function scrollChat() {
      var chatDiv = document.getElementById('chat');
      chatDiv.scrollTop = chatDiv.scrollHeight;
    };
  </script>
</head>
<body onload="scrollChat()">

  <div id="container">

    <h1><%= conversation.getTitle() %>
      <a href="" style="float: right">&#8635;</a></h1>

    <hr/>

    <div id="chat">
      <!--<ul>-->
    <%
      for (Message message : messages) {
        //User userCurrent = (User) UserStore.getInstance()
          //.getUser(message.getAuthorId());
        String author = UserStore.getInstance()
          .getUser(message.getAuthorId()).getName();
          User currentUser = (User) UserStore.getInstance()
          .getUser(message.getAuthorId());

    %>


    <% if(request.getSession().getAttribute("user").equals(author)){ %>
        <!--<div align="right" id="myTexts">
          <hgroup class="speech-bubbles">
            <h5><%= message.getContent() %></h5>
          </hgroup>
          <br>
          <strong><%= author %>:</strong>
          <% if(message.getPicture() != null) { %>
          <img align="right" src=<%= message.getPicture() %> height= "50" width = "50">
        </div>
        <% } else { %>
        <% } %>-->
    <table style="margin-left: auto; margin-right: 0;" id="myText" cellspacing="50">
      <td float="right" align="right">
        <div float="right" align="right"><% if(message.getPicture() != null) { %>
                <img src=<%= message.getPicture() %> height= "50" width = "50">
            <% } else { %>
            <% } %></div>
      </td>
      <td  float="right" align="right">
        <div align="right"><hgroup class="speech-bubbles">
              <h5 text-align: right><%= message.getContent() %></h5>
          </hgroup></div>
          <!--<strong><%= author %>:</strong>-->
      </td>



    </table>


    <% } else { %>
    <table id="otherText" cellspacing="50">
      <td align="left">
        <div align="left"><hgroup class="speech-bubble">
              <h5><%= message.getContent() %></h5>
          </hgroup></div>
          <strong><%= author %>:</strong>
          <% if(currentUser.getPicture() != null) { %>
                <img src=<%= currentUser.getPicture() %> height= "50" width = "50">
            <% } else { %>
            <% } %>


      </td>
      <td>
        <div align="left"><% if(message.getPicture() != null) { %>
                <img align = "left" src=<%= message.getPicture() %> height= "50" width = "50">
            <% } else { %>
            <% } %></div>
      </td>

    </table>


      <!--<div style="inline-block" align="left" id="otherText" >

      </div>
      <div id="otherpicture">

          <br>

      </div>-->

    <% } %>

    <%}
    %>


     <!-- </ul>-->
    </div>

    <hr/>

    <% if (request.getSession().getAttribute("user") != null) { %>
    <form action="/chat/<%= conversation.getTitle() %>" method="POST">
        <input type="text" name="message">
        <br/>
        <button type="submit">Send</button>
    </form>
    <% } else { %>
      <p><a href="/login">Login</a> to send a message.</p>
    <% } %>

    <hr/>

  </div>

</body>
</html>
