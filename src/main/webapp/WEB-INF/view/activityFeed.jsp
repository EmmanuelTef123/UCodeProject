<%@ page import="java.util.List" %>
<%@ page import="codeu.model.data.Conversation" %>
<%@ page import="codeu.model.data.Message" %>
<%@ page import="codeu.model.store.basic.UserStore" %>

<h1>Conversations</h1>
<% 
List<Conversation> conversations = (List<Conversation>) request.getAttribute("conversations");
if(conversations == null || conversations.isEmpty()){
%>
  <p>Start a new conversation</p>
<%
}
else{
%>
 <ul>
<%
 for(Conversation conversation : conversations){ 
%>
  <li><a href="/ChatApp/chat/<%= conversation.getTitle() %>"><%= conversation.getTitle() %></a></li>
<%
 }
%>
 </ul>
<%
}
%>
<hr/>