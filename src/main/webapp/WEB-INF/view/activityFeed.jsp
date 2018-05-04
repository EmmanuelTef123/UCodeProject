<%--
This is the Activity Page's front-end jsp file. It displays all conversations.
--%>

<%@ page import="java.util.List" %>
<%@ page import="codeu.model.data.Conversation" %>
<%@ page import="codeu.model.data.Message" %>
<%@ page import="codeu.model.data.User" %>
<%@ page import="codeu.model.store.basic.DefaultDataStore" %>

<!DOCTYPE html>

<%--
The following chunk displays the purple navigation menu that goes on top of every page.
--%>
<html>
		<nav>
        <a id="navTitle" href="/">Chat It Up!</a>
        <% if(request.getSession().getAttribute("user") == null){ %>
          <a href="/about.jsp">About</a>
          <a href="/login">Login</a>
          <a href="/register">Register</a>
        <% } else { %>
          <a href="/about.jsp">About</a>
          <a href="/conversations">Conversations</a>
          <a> | </a>
          <a>Hello <%= request.getSession().getAttribute("user") %>!</a>
          <a href="/login">Logout</a>
        <% } %>
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


		
		
    <%
		List<Conversation> conversations =	
				(List<Conversation>) request.getAttribute("conversations");
		List<Message> messages =	
				(List<Message>) request.getAttribute("messages");
		List<User> users =	
				(List<User>) request.getAttribute("users");
		%>
					<h1>Our Community of Users:</h1> 
					<%
					if(users == null || users.isEmpty()){
					%>
						<p>Tell your friends about Chat It Up. Join Our Community</p>
						<%
						} else{
						%>
						<ul class="mdl-list">
						<%
						for(User user : users){
						%>
						<li>
						<%= user.getName() %> joined the Chat It Up community on <%=user.getCreationTime()%> </li>
						<%
						}
						%>
						</ul>
						<%
						}
						%>
						<hr/>

			<h1>Community Chatter</h1> 
			      <%
						if(messages == null || messages.isEmpty()){
						%>
						<p> Send message to your friends! </p>
						<%
						} else{
						%>
						<ul class="mdl-list">
						<%
						for(Message message : messages){
						%>
						<li>Someone on Chat It Up talked about  
						"<%= message.getContent() %>" at time <%=message.getCreationTime()%> </li>
						<%
						}
						%>
						</ul>
						<%
						}
						%>
						<hr/>

			<h1>Recent Conversations</h1>
			  <%
				if(conversations == null || conversations.isEmpty()){
				%>
				<p>Create a conversation to get started.</p>
				<%
				} else{
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



		<% if(request.getAttribute("error") != null){ %>
			<h2 style="color:red"><%= request.getAttribute("error") %></h2>
	<% } %>
	<% if(request.getSession().getAttribute("user") != null){ %>
		<h1>Have Something Else to Say?</h1>
		<form action="/conversations" method="POST">
				<div class="form-group">
					<label class="form-control-label">New Conversation Title:</label>
				<input type="text" name="conversationTitle">
			</div>
			<button type="submit">Create</button>
		</form>
		<hr/>
	<% } %>

  </div>
</body>
</html>