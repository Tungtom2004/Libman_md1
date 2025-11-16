<%@ page contentType="text/html; charset=UTF-8" %>
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
    <title>Search Document Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            min-height: 100vh; 
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
            
            width: min(1200px, 95vw);
            border: 2px solid rgba(0,0,0,0.2);
            padding: 30px; 
            border-radius: 15px;
            background: rgba(255,255,255,0.85); 
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            box-shadow: 0px 8px 20px rgba(0,0,0,0.25);
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

        .search-bar {
            display: flex;
            gap: 15px; 
            margin-bottom: 25px; 
        }

        input[type="text"] {
            flex: 1;
            padding: 12px 15px; 
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 8px; 
            box-shadow: inset 0 1px 3px rgba(0,0,0,0.1); 
        }

        
        button {
            background-color: #5b87d1; 
            color: white; 
            font-weight: bold;
            border: none; 
            padding: 12px 25px; 
            border-radius: 8px; 
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
             box-shadow: 0 2px 5px rgba(0,0,0,0.2);
             font-size: 16px; 
        }

        button:hover {
            background-color: #4a6fa5; 
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.25);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px; 
            background: rgba(255, 255, 255, 0.9); 
            border: 1px solid rgba(0,0,0,0.2); 
            border-radius: 8px; 
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1); 
        }

        table, th, td {
             border: 1px solid rgba(0,0,0,0.15); 
        }

        th, td {
            height: 45px; 
            text-align: center;
            padding: 10px 12px; 
            vertical-align: middle; 
        }

        th {
            background-color: rgba(233, 236, 239, 0.9); 
            font-weight: bold;
             color: #333;
        }
        
         td a {
             color: #3498db;
             text-decoration: none;
             font-weight: bold;
        }
         td a:hover {
             color: #2980b9;
             text-decoration: underline;
         }

        .return-btn {
            text-align: center;
            margin-top: 25px;
        }

        .return-btn button {
            width: 200px;
            background-color: #7f8c8d;
        }
        .return-btn button:hover {
             background-color: #6c7a7b;
        }

        .error {
            color: #c0392b;
            text-align: center;
            margin-bottom: 15px;
            font-weight: bold;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            padding: 10px;
            border-radius: 5px;
        }
         td[colspan="6"] {
             height: 120px;
             font-style: italic;
             color: #777;
         }
    </style>
</head>
<body>
<div class="container">
    <h2>Search Document</h2>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <form class="search-bar" action="<%= request.getContextPath() %>/DocumentServlet" method="get">
        <input type="hidden" name="action" value="search">
        <input type="text" name="keyword" value="${keyword}" placeholder="Enter document's name...">
        <button type="submit">Search</button>
    </form>

    <table>
        <thead> 
            <tr>
                <th style="width: 50px;">Stt</th> 
                <th style="width: 80px;">ID</th> 
                <th>Name</th>
                <th style="width: 150px;">Year of publication</th> 
                <th style="width: 150px;">Category</th> 
                <th style="width: 120px;">View document detail</th> 
            </tr>
        </thead>
        <tbody> 
            <c:if test="${empty documents}">
                <tr>
                    <td colspan="6">No document found</td> 
                </tr>
            </c:if>

            <c:forEach var="d" items="${documents}" varStatus="st">
                <tr>
                    <td>${st.index + 1}</td>
                    
                    <td>TL<c:if test="${d.id < 10}">0</c:if>${d.id}</td>
                    <td style="text-align: left;">${d.name}</td> 
                    <td>${d.yearOfPublication}</td>
                    <td>${d.category}</td>
                    
                    <td><a href="<%= request.getContextPath() %>/DocumentServlet?action=detail&id=${d.id}">View</a></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div class="return-btn">
        
        <form action="<%= request.getContextPath() %>/ReaderHomeView.jsp">
            <button type="submit">Return</button>
        </form>
    </div>
</div>
</body>
</html>