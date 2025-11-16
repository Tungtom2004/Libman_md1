<%@ page contentType="text/html; charset=UTF-8" %>
<%
    if (session.getAttribute("currentUser") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    model.User currentUser = (model.User) session.getAttribute("currentUser");
    String username = currentUser.getUsername();
    String role = currentUser.getRole();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Reader Home Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            height: 100vh;
            background-image: url('https://images.unsplash.com/photo-1521587760476-6c12a4b040da?q=80&w=2070&auto=format=fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'); 
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            box-sizing: border-box;
        }

        .container {
            width: min(800px, 90vw); 
            min-height: 400px; 
            border: 2px solid rgba(0,0,0,0.2);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 40px; 
            border-radius: 15px;
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            box-shadow: 0px 8px 20px rgba(0,0,0,0.25);
            position: relative;
            padding: 40px; 
            box-sizing: border-box;
        }

        h1 {
            font-size: 32px;
            font-weight: bold;
            text-align: center;
            margin-bottom: 10px; 
            color: #2c3e50;
        }

        .user-info {
            position: absolute;
            top: 15px;
            right: 20px;
            font-size: 14px;
            background: rgba(255,255,255,0.7);
            padding: 8px 14px;
            border-radius: 8px;
            border: 1px solid rgba(0,0,0,0.15);
            color: #333;
        }

        .action-button { 
            background-color: #5b87d1; 
            color: white;
            border: none;
            padding: 20px 45px; 
            font-size: 20px; 
            font-weight: bold;
            cursor: pointer;
            border-radius: 10px; 
            transition: background-color 0.3s, transform 0.2s;
            box-shadow: 0 3px 7px rgba(0,0,0,0.2); 
            width: 300px; 
            text-align: center; 
            display: inline-block; 
            text-decoration: none; 
        }

        .action-button:hover {
            background-color: #4a6fa5;
            transform: translateY(-3px); 
            box-shadow: 0 6px 10px rgba(0,0,0,0.3); 
        }

        .logout-btn {
            background-color: #e74c3c; 
        }

        .logout-btn:hover {
            background-color: #c0392b; 
        }
        .button-form {
             width: 100%; 
             display: flex;
             justify-content: center; 
        }
    </style>

    <script>
        function confirmLogout() {
            if (confirm("Are you sure you want to log out?")) {
                window.location.href = "<%= request.getContextPath() %>/LogoutServlet";
            }
        }
    </script>
</head>
<body>
    <div class="container">

        <div class="user-info">
           Name: <b><%= username %></b> &nbsp;|&nbsp; Role: <b><%= role %></b>
        </div>

        <h1>Reader Dashboard</h1>

        <form class="button-form" action="<%= request.getContextPath() %>/SearchDocumentView.jsp" method="get">
            <button type="submit" class="action-button">Search document</button>
        </form>

        <div class="button-form"> 
            <button type="button" class="action-button logout-btn" onclick="confirmLogout()">Log out</button>
        </div>

    </div>
</body>
</html>