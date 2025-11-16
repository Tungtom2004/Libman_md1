<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    if (session.getAttribute("currentUser") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>ScanReaderCard Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <style>
        body{
            font-family: Arial, sans-serif;
            margin: 0; padding: 0; min-height: 100vh;
            background-image: url('https://images.unsplash.com/photo-1521587760476-6c12a4b040da?q=80&w=2070&auto=format=fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'); /* */
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px; 
            box-sizing: border-box;
        }

        .container{
            width: min(900px, 92vw);
            border: 2px solid rgba(0,0,0,0.2);
            border-radius: 15px;
            background: rgba(255, 255, 255, 0.85); 
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            box-shadow: 0px 8px 20px rgba(0,0,0,0.25);
            padding: 30px 40px; /* Tăng padding */
            box-sizing: border-box;
        }

        h1{
            text-align: center;
            margin-top: 0; 
            margin-bottom: 30px; 
            color: #2c3e50; 
            font-size: 30px; 
        }

        .search-row{
            width: 100%;
            display: grid;
            grid-template-columns: 1fr 160px;
            gap: 0;
            border: 1px solid rgba(0,0,0,.25); 
            border-radius: 8px;
            overflow: hidden;
            margin: 0 auto 30px; 
            background: #fff;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .search-row input{
            border: none; outline: none;
            padding: 14px 16px;
            font-size: 16px;
            background: transparent;
        }
        
        .search-row button{
            border: none; cursor: pointer;
            font-size: 16px; 
            font-weight: bold;
            background: #5b87d1;
            color: white;
            transition: background-color 0.3s;
        }
        .search-row button:hover{
            background: #4a6fa5;
        }

        .result{
            min-height: 160px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 6px 0 30px;
            text-align: center;
        }
        .reader-card{
            width: 100%;
            max-width: 650px; 
            display: grid;
            grid-template-columns: 120px 1fr; 
            gap: 25px; 
            align-items: center;
            padding: 15px 20px; 
            border: 1px solid rgba(0,0,0,.15);
            border-radius: 10px;
            background: rgba(255,255,255,.75);
            box-shadow: 0 3px 7px rgba(0,0,0,0.1);
        }
        .avatar{
            width: 110px; height: 110px; 
            border-radius: 8px; object-fit: cover;
            border: 1px solid rgba(0,0,0,.15);
            background: #eef3ff;
        }
        .reader-info{
            text-align: left;
            font-size: 17px; 
            line-height: 1.7; 
        }
         .reader-info b {
             display: inline-block;
             width: 120px; 
             color: #333;
         }

        .bottom-actions{
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-top: 30px; 
        }
        .btn{
            display: inline-flex; align-items: center; justify-content: center;
            width: 100%;
            height: 55px; 
            border-radius: 8px; 
            border: none; 
            background: #5b87d1; 
            text-decoration: none;
            color: white; 
            font-weight: bold;
            font-size: 17px; 
            cursor: pointer;
            transition: background-color 0.3s, transform 0.2s;
             box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }
        .btn:hover{
            background: #4a6fa5; 
             transform: translateY(-2px);
             box-shadow: 0 4px 8px rgba(0,0,0,0.25);
        }
        .btn[disabled]{
            opacity:.6;
            cursor:not-allowed;
            background: #ccc; 
            box-shadow: none;
            transform: none;
        }
        .btn.secondary{
            background: #aaa; 
            color: #fff;
        }
        .btn.secondary:hover{
            background: #888; 
        }

        .error, .empty{
            color:#555; 
            opacity: 1; 
            font-style: italic;
        }
        .error{
            color: #D8000C; 
            background-color: #FFD2D2;
            border: 1px solid #D8000C;
            padding: 12px 15px; 
            border-radius: 5px;
            font-weight: bold;
            font-style: normal; 
            width: 80%; 
            box-sizing: border-box;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Scan Reader Card</h1>

    <form class="search-row" method="get" action="<%= request.getContextPath() %>/ReaderCardServlet">
        <input type="hidden" name="action" value="scan">
        
        <input type="text" name="id" value="${param.id}" placeholder="Enter reader ID...">
        <button type="submit">Search</button>
    </form>

    <div class="result">
        <c:choose>
            <c:when test="${not empty readerCard}">
                <div class="reader-card">

                    <img class="avatar"
                         src="${readerCard.avatar}"
                         alt="Reader Avatar">

                    <div class="reader-info">
                        <div><b>ReaderID:</b> R<c:if test="${readerCard.id < 10}">0</c:if>${readerCard.id}</div>

                        <div><b>Name:</b> ${readerCard.fullname}</div>

                        <div><b>Register day:</b> <fmt:formatDate value="${readerCard.registerDay}" pattern="dd/MM/yyyy" /></div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <c:choose>
                    <c:when test="${not empty error}">
                        <div class="error">${error}</div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty">Reader information is empty</div>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="bottom-actions">
        <form method="post" action="<%= request.getContextPath() %>/ReaderCardServlet">
            <input type="hidden" name="action" value="select">
            
            <input type="hidden" name="readerId" value="${readerCard.id}">

            <button class="btn" type="submit" <c:if test="${empty readerCard}">disabled</c:if>>
                 Confirm
            </button>
        </form>

        <a class="btn secondary" href="<%= request.getContextPath() %>/StaffHomeView.jsp">Return</a>
    </div>
</div>
</body>
</html>