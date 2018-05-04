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
  <title>Chat It Up: Communication Made Simple</title>
  <link rel="stylesheet" href="/css/main.css">
</head>
<body>

  <div id="container">
    <div
      style="width:75%; margin-left:auto; margin-right:auto; margin-top: 50px;">

      <h1>Welcome To Chat It Up!</h1>
      <h2>Chat It Up: Connecting Made Simple</h2>
      <ul>
          <li>View the <a href="/about.jsp">About</a> page to learn more about the
            project.</li>
        <li><a href="/login">Login</a> to access your account.</li>
        <li>Go to the <a href="/register">Register</a> page to
            create a new account.</li>
      </ul>
    </div>
  </div>
</body>
</html>
