<%--
This is the Activity Page's front-end jsp file. It displays all conversations.
--%>

<%@ page import="java.util.List" %>
<%@ page import="codeu.model.data.Conversation" %>
<%@ page import="codeu.model.data.Message" %>
<%@ page import="codeu.model.data.User" %>

<!DOCTYPE html>

<%--
The following chunk displays the purple navigation menu that goes on top of every page.
--%>
<html>
    <nav>
        <a id="navTitle" href="/">Chat It Up!</a>
        <a href="/conversations">Conversations</a>
        <% if(request.getSession().getAttribute("user") != null){ %>
          <a>Hello <%= request.getSession().getAttribute("user") %>!</a>
        <% } else{ %>
          <a href="/login">Login</a>
          <a href="/register">Register</a>
        <% } %>
        <a href="/about.jsp">About</a>
			</nav>
			
<%--
This code sets the style of the page to be a premade stylesheet and sets title.
--%>
<head>
  <title>Conversations</title>
  <link rel="stylesheet" href="/css/main.css">
</head>
<body>
  <div id="container">


<%--
Deals with errors.
--%>
    <% if(request.getAttribute("error") != null){ %>
        <h2 style="color:red"><%= request.getAttribute("error") %></h2>
		<% } %>
    <% if(request.getSession().getAttribute("user") != null){ %>
      <h1>New Conversation</h1>
      <form action="/conversations" method="POST">
          <div class="form-group">
            <label class="form-control-label">Title:</label>
          <input type="text" name="conversationTitle">
        </div>

        <button type="submit">Create</button>
      </form>

      <hr/>
		<% } %>
		

<%--
Lists all conversations and time they were made. Has hyperlinks so the user can click and see what was said. 
--%>
    <h1>Recent Chatter:</h1>
    <%
    List<Conversation> conversations =
      (List<Conversation>) request.getAttribute("conversations");
		

		if(conversations == null || conversations.isEmpty()){
    %>
      <p>Create a conversation to get started.</p>
    <%
    }
		
		else{
    %>
      <ul class="mdl-list">
    <%
      for(Conversation conversation : conversations){
		%>
		<li>Conversation <a href="/chat/<%= conversation.getTitle() %>">
			"<%= conversation.getTitle() %></a>" was made at time <%=conversation.getCreationTime()%> </li>
    <%
      }
    %>
      </ul>
    <%
    }
    %>
		<hr/>
  </div>
</body>
</html>