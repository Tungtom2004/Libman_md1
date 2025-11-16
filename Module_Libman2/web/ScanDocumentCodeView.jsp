<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    if (session.getAttribute("currentUser") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Scan Document Code</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <style>
        body{ font-family: Arial, sans-serif; margin: 0; padding: 0; min-height: 100vh; background-image: url('https://images.unsplash.com/photo-1521587760476-6c12a4b040da?q=80&w=2070&auto=format=fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'); background-size: cover; background-position: center; background-repeat: no-repeat; display: flex; justify-content: center; align-items: center; padding: 20px; box-sizing: border-box; }
        .container{ width: min(900px, 92vw); border: 2px solid rgba(0,0,0,0.2); border-radius: 15px; background: rgba(255, 255, 255, 0.85); backdrop-filter: blur(8px); -webkit-backdrop-filter: blur(8px); box-shadow: 0px 8px 20px rgba(0,0,0,0.25); padding: 30px 40px; box-sizing: border-box; }
        h1{ text-align: center; margin-top: 0; margin-bottom: 30px; color: #2c3e50; font-size: 30px; }
        .search-row{ width: 100%; display: grid; grid-template-columns: 1fr 160px; gap: 0; border: 1px solid rgba(0,0,0,.25); border-radius: 8px; overflow: hidden; margin: 0 auto 30px; background: #fff; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .search-row input{ border: none; outline: none; padding: 14px 16px; font-size: 16px; background: transparent; }
        .search-row button{ border: none; cursor: pointer; font-size: 16px; font-weight: bold; background: #5b87d1; color: white; transition: background-color 0.3s; }
        .search-row button:hover{ background: #4a6fa5; }
        .btn{ display: inline-flex; align-items: center; justify-content: center; width: 100%; height: 55px; border-radius: 8px; border: none; background: #5b87d1; text-decoration: none; color: white; font-weight: bold; font-size: 17px; cursor: pointer; transition: background-color 0.3s, transform 0.2s; box-shadow: 0 2px 5px rgba(0,0,0,0.2); }
        .btn:hover{ background: #4a6fa5; transform: translateY(-2px); box-shadow: 0 4px 8px rgba(0,0,0,0.25); }
        .btn[disabled]{ opacity:.6; cursor:not-allowed; background: #ccc; box-shadow: none; transform: none; }
        .btn.secondary{ background: #aaa; color: #fff; }
        .btn.secondary:hover{ background: #888; }
        .btn.success{ background: #28a745; color: #fff; }
        .btn.success:hover{ background: #218838; }
        
        .error{ color: #D8000C; background-color: #FFD2D2; border: 1px solid #D8000C; padding: 12px 15px; border-radius: 5px; font-weight: bold; width: 80%; box-sizing: border-box; text-align: center; margin: 10px auto; }
        .flow-error-box { text-align: center; padding: 20px; }
        .flow-error-box p { font-size: 18px; margin-bottom: 25px; }
        h2 { margin-top: 30px; margin-bottom: 15px; border-bottom: 2px solid #ddd; padding-bottom: 10px; color: #333; }
        
        .styled-table { width: 100%; border-collapse: collapse; font-size: 16px; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .styled-table thead tr { background-color: #5b87d1; color: #ffffff; text-align: left; }
        .styled-table th, .styled-table td { padding: 12px 15px; }
        .styled-table tbody tr { border-bottom: 1px solid #dddddd; }
        .styled-table tbody tr:nth-of-type(even) { background-color: #f3f3f3; }
        .styled-table tbody tr:last-of-type { border-bottom: 2px solid #5b87d1; }
        .styled-table tbody tr.empty-row { background-color: #fafafa; text-align: center; font-style: italic; color: #777; }
        
        .add-btn { display: inline-flex; align-items: center; justify-content: center; width: 40px; height: 40px; background: #28a745; color: white; border-radius: 50%; border: none; font-size: 24px; font-weight: bold; cursor: pointer; text-decoration: none; }
        .add-btn:hover { background: #218838; }
        .add-btn[disabled] { background: #ccc; cursor: not-allowed; }
        
        .nav-buttons { display: grid; grid-template-columns: 1fr 1fr; gap: 30px; margin-top: 30px; }
    </style>
</head>
<body>
<div class="container">
    <h1>Scan Document Code</h1>

    <c:choose>
        <c:when test="${empty sessionScope.selectedReader}">
            <div class="flow-error-box">
                <p>You have to scan reader card before scan document</p>
                <a class="btn" style="background-color: #aaa; color: #fff; width: 250px; margin: 0 auto;"
                   href="<%= request.getContextPath() %>/ScanReaderCardView.jsp">Return to Loan Page</a>
            </div>
        </c:when>

        <c:otherwise>

            <form class="search-row" method="get" action="<%= request.getContextPath() %>/DocumentServlet">
                <input type="hidden" name="action" value="scan">
                <input type="text" name="id" value="${param.id}" placeholder="Enter document ID...">
                <button type="submit">Search</button>
            </form>

            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>
            
            <c:if test="${not empty sessionScope.errorDocument}">
                <div class="error">${sessionScope.errorDocument}</div>
                <% session.removeAttribute("errorDocument"); %>
            </c:if>

            <h2>Scan Document</h2>
            <form method="post" action="<%= request.getContextPath() %>/DocumentServlet">
                <input type="hidden" name="action" value="select">
                <input type="hidden" name="documentId" value="${document.id}">
                
                <table class="styled-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Year</th>
                            <th>Category</th>
                            <th>Pages</th>
                            <th>Add</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty document}">
                                <tr>
                                    <td>TL<c:if test="${document.id < 10}">0</c:if>${document.id}</td>
                                    <td>${document.name}</td>
                                    <td>${document.yearOfPublication}</td>
                                    <td>${document.category}</td>
                                    <td>${document.numberOfPages}</td>
                                    <td>
                                        <button type="submit" class="add-btn">+</button>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <tr class="empty-row">
                                    <td colspan="6">Search for a document to add...</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </form>

            <h2>Borrowed Documents</h2>
            <table class="styled-table">
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>ID</th>
                        <th>Name</th>
                        <th>BorrowDate</th>
                        <th>ExpectedReturnDate</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty sessionScope.selectedLoanItems}">
                            <c:forEach var="item" items="${sessionScope.selectedLoanItems}" varStatus="loop">
                                <tr>
                                    <td>${loop.count}</td>
                                    <td>TL<c:if test="${item.document.id < 10}">0</c:if>${item.document.id}</td>
                                    <td>${item.document.name}</td>
                                    <td>${item.borrowDate}</td>
                                    <td>${item.expectedReturnDate}</td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                             <tr class="empty-row">
                                <td colspan="5">No documents selected yet.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>

             <div class="nav-buttons">
                 <a class="btn secondary" href="<%= request.getContextPath() %>/ScanReaderCardView.jsp">Return</a>
                 <a class="btn success" href="<%= request.getContextPath() %>/PrintLoanSlipView.jsp">Confirm</a>
            </div>

        </c:otherwise>
    </c:choose>

</div>
</body>
</html>