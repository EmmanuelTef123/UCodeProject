<% String[] recentActivity = {
	"Emmanuel Registered for ChatItUp", "Emmanuel Messaged Fran", "Fran Messaged Emmanuel", "Kevin Registered", "Ashley Registered",
	"Fran Messaged Ashley", "How's it going there Fran?", "Hi", "Hello", "What's up"
	}; %>
<!DOCTYPE html>
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
	<head>
		<title>Activity Feed</title>
	</head>
	<body>
		<h1>Activity Feed</h1>
		<p>Here's how people have been chatting it up!</p>
		<ul>
        Hi I'm Emmanuel
        <% for(int i = 0; i < recentActivity.length; i++){ %>
			<li><%= recentActivity[i] %></li>
		<% } %>
		</ul>
	</body>
</html>