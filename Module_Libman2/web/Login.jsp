<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;

            background-image: url('https://images.unsplash.com/photo-1521587760476-6c12a4b040da?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'); /*  */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            padding: 20px; /* Thêm padding */
            box-sizing: border-box;
        }

        .login-container {
            background: rgba(255, 255, 255, 0.85); 
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            border: 2px solid rgba(0, 0, 0, 0.2);
            padding: 40px;
            width: min(400px, 90vw); 
            border-radius: 15px;
            box-shadow: 0px 8px 20px rgba(0,0,0,0.25);
            text-align: center;
        }

        h2 {
            margin-top: 0; 
            margin-bottom: 30px;
            color: #2c3e50; 
            font-size: 28px; 
        }

        input[type="text"], input[type="password"] {
            width: calc(100% - 30px); 
            padding: 12px 15px; 
            margin: 10px 0;
            border-radius: 8px; 
            border: 1px solid #ccc;
            font-size: 16px;
            box-shadow: inset 0 1px 3px rgba(0,0,0,0.1);
            box-sizing: border-box; 
        }

       
        button {
            padding: 12px 30px; 
            background-color: #5b87d1; 
            border: none; 
            border-radius: 8px; 
            cursor: pointer;
            font-weight: bold;
            color: white; 
            margin-top: 20px; 
            font-size: 16px; 
            transition: background-color 0.3s, transform 0.2s;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }

        button:hover {
            background-color: #4a6fa5; 
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.25);
        }

        .error {
            color: #c0392b; 
            margin-top: 20px;
            font-weight: bold;
            min-height: 1.2em;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Welcome to Libman</h2>
        <form action="<%= request.getContextPath() %>/LoginServlet" method="post">
            <input type="text" name="username" placeholder="Username" required><br>
            <input type="password" name="password" placeholder="Password" required><br>
            <button type="submit">Login</button>
        </form>
        <div class="error">${not empty error ? error : ""}</div>
    </div>
</body>
</html>
