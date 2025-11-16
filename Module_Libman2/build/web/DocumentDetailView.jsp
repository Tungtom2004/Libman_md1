<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session.getAttribute("currentUser") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Document Detail Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh;

            
            background-image: url('https://images.unsplash.com/photo-1521587760476-6c12a4b040da?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'); /*  */
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
           
             width: min(900px, 95vw);
            padding: 30px; 
            border: 2px solid rgba(0,0,0,0.2);
            border-radius: 15px;
            background: rgba(255,255,255,0.85); 
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            box-shadow: 0px 8px 20px rgba(0,0,0,0.25);
            display:flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
             overflow-y: auto;
             max-height: 90vh;
        }

        h2 {
            text-align: center;
             margin-top: 0; 
            margin-bottom: 25px;
            color: #2c3e50; 
            font-size: 30px; 
            font-weight: bold;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
            background: rgba(255, 255, 255, 0.9); 
            border: 1px solid rgba(0,0,0,0.2); 
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        th, td {
            text-align: left;
            padding: 12px 15px; 
            height: 45px; 
            border: 1px solid rgba(0,0,0,0.15); 
            vertical-align: middle; 
        }
        th {
            width: 200px;
            background-color: rgba(233, 236, 239, 0.9); 
            font-weight: bold;
            color: #333;
        }

        .return-btn {
            display: flex;
            justify-content: center;
            margin-top: 10px; 
        }

      
        .return-btn a {
            width: 200px;
            background-color: #7f8c8d; 
            color: white; 
            font-weight: bold;
            border: none;
            padding: 12px 25px; 
            border-radius: 8px; 
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            transition: background-color 0.3s, transform 0.2s;
             box-shadow: 0 2px 5px rgba(0,0,0,0.2);
             font-size: 16px;
        }
        .return-btn a:hover {
             background-color: #6c7a7b;
             transform: translateY(-2px);
             box-shadow: 0 4px 8px rgba(0,0,0,0.25);
        }

        .error {
            color:#c0392b;
            text-align:center;
            margin-bottom:15px;
            font-weight:bold;
            background-color: #f8d7da; 
            border: 1px solid #f5c6cb;
            padding: 10px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Detail Document</h2>

    <c:if test="${empty document}">
        <div class="error">Không tìm thấy tài liệu.</div>
    </c:if>

    <c:if test="${not empty document}">
        <table>
            <tr>
                <th>ID</th>
                <td>TL<c:if test="${document.id < 10}">0</c:if>${document.id}</td>
            </tr>
            <tr>
                <th>Name</th>
                <td>${document.name}</td>
            </tr>
            <tr>
                <th>Year of publication</th>
                <td>${document.yearOfPublication}</td>
            </tr>
            <tr>
                <th>Author</th>
                <td>${document.author}</td>
            </tr>
            <tr>
                <th>Publicator</th>
                <td>${document.publicator}</td>
            </tr>
            <tr>
                <th>Category</th>
                <td>${document.category}</td>
            </tr>
            <tr>
                <th>Language</th>
                <td>${document.language}</td>
            </tr>
            <tr>
                <th>Number of pages</th>
                <td>${document.numberOfPages}</td>
            </tr>
        </table>
    </c:if>

    <div class="return-btn">
        <a href="<%= request.getContextPath() %>/SearchDocumentView.jsp">Return</a>
    </div>
</div>
</body>
</html>

