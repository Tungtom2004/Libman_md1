<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    if (session.getAttribute("currentUser") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
    model.User currentUser = (model.User) session.getAttribute("currentUser");

    Object saveError = session.getAttribute("saveError");
    if(saveError != null) {
        pageContext.setAttribute("saveErrorMsg", saveError); 
        session.removeAttribute("saveError"); 
    }

    Object saveSuccess = session.getAttribute("saveSuccess");
    String successMessage = null; 
    if(saveSuccess != null) {
        successMessage = saveSuccess.toString();
        session.removeAttribute("saveSuccess"); 
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>PrintLoanSlip Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <style>
        body{
            font-family: Arial, sans-serif;
            margin: 0; padding: 0; min-height: 100vh;
            
            background-image: url('https://images.unsplash.com/photo-1521587760476-6c12a4b040da?q=80&w=2070&auto=format=fit=crop&ixlib=rb-4.0.3&id=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D');
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
            width: min(950px, 94vw); 
            border: 2px solid rgba(0,0,0,0.2);
            border-radius: 15px;
            background: rgba(255, 255, 255, 0.85); 
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            box-shadow: 0px 8px 20px rgba(0,0,0,0.25);
            padding: 30px 40px;
            position: relative; 
            box-sizing: border-box;
        }

        h1{
            text-align:center;
            margin-top: 0; 
            margin-bottom: 10px;
            color:#2c3e50; 
            font-size: 30px; 
        }
        .librarian-info {
            text-align: center;
            margin-bottom: 25px;
            font-size: 16px;
            color: #333;
        }
         
         .save-error-message {
             width: 95%; 
             margin: 0 auto 15px auto; 
             padding: 10px 15px;
             border-radius: 5px;
             text-align: center;
             font-weight: bold;
             background-color: #f8d7da;
             color: #721c24;
             border: 1px solid #f5c6cb;
        }

        .section-title{
            margin: 20px 0 10px; 
            font-weight: bold;
            text-align: center;
            font-size: 18px; 
            color: #333;
        }
        table{
            width: 100%;
            border-collapse: collapse;
            background: rgba(255,255,255,.8);
            border: 1px solid rgba(0,0,0,.2);
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        th, td{
            padding: 12px 14px;
            border: 1px solid rgba(0,0,0,.15);
            text-align: left;
            word-break: break-word;
            font-size: 15px;
        }
        th{
            background: rgba(0,0,0,.05);
            font-weight: bold;
            color: #333;
         }
        th.col-center, td.col-center { text-align: center; }
        .spacer{ height: 30px; }

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
        @media (max-width: 720px){
            .bottom-actions{ grid-template-columns: 1fr; }
        }

        .modal-overlay { display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); justify-content: center; align-items: center; z-index: 1000; }
        .modal-content { background-color: white; padding: 25px 30px; border-radius: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.3); text-align: center; width: 90%; max-width: 400px; }
        .modal-content p { font-size: 18px; margin-bottom: 20px; }
        .modal-buttons { display: flex; justify-content: space-around; gap: 15px; }
        .modal-buttons button { padding: 10px 25px; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; font-weight: bold; }
        .modal-buttons .btn-yes { background-color: #4CAF50; color: white; }
        .modal-buttons .btn-no { background-color: #f44336; color: white; }
        .modal-buttons .btn-yes:hover { background-color: #45a049; }
        .modal-buttons .btn-no:hover { background-color: #da190b; }
    </style>
</head>
<body>
<div class="container">
    <h1>Print Loan Slip</h1>

     <c:if test="${not empty saveErrorMsg}">
         <div class="save-error-message">${saveErrorMsg}</div>
     </c:if>

    <div class="librarian-info">
        Library Staff: <strong>${sessionScope.currentUser.fullname}</strong>
    </div>

    <div class="section-title">Reader information</div>
    <table>
        <c:choose>
            <c:when test="${not empty sessionScope.selectedReader}">
                <tr>
                    <th style="width: 180px;">Reader ID</th>
                    <td>R<c:if test="${sessionScope.selectedReader.id < 10}">0</c:if>${sessionScope.selectedReader.id}</td>
                </tr>
                <tr>
                    <th>Name</th>
                    <td>${sessionScope.selectedReader.fullname}</td>
                </tr>
                <tr>
                    <th>Register day</th>
                    <td><fmt:formatDate value="${sessionScope.selectedReader.registerDay}" pattern="dd/MM/yyyy" /></td>
                </tr>
            </c:when>
            <c:otherwise>
                 <tr><td colspan="2" style="text-align: center; font-style: italic;">No reader selected.</td></tr>
            </c:otherwise>
        </c:choose>
    </table>

    <div class="spacer"></div>

    <div class="section-title">List of borrowed documents today</div>

    <c:choose>
        <c:when test="${not empty sessionScope.selectedLoanItems}">
            <table>
                <thead>
                <tr>
                    <th class="col-center" style="width:50px;">Stt</th>
                    <th class="col-center" style="width:120px;">DocumentID</th>
                    <th>Name</th>
                    <th style="width:110px;">Category</th>
                    <th style="width:130px;">BorrowDate</th>
                    <th style="width:160px;">ExpectedReturnDate</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${sessionScope.selectedLoanItems}" varStatus="st">
                    <tr>
                        <td class="col-center">${st.index + 1}</td>
                        <td class="col-center">TL<c:if test="${item.document.id < 10}">0</c:if>${item.document.id}</td>
                        <td>${item.document.name}</td>
                        <td>${item.document.category}</td>
                        
                        <td>${item.borrowDate}</td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty item.expectedReturnDate}">${item.expectedReturnDate}</c:when>
                                <c:otherwise><span style="color: red; font-style: italic;">Not entered</span></c:otherwise> 
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <table><tr><td style="text-align: center; font-style: italic;">No borrowed documents selected.</td></tr></table> 
        </c:otherwise>
    </c:choose>

    <div class="bottom-actions">
        <form id="saveLoanForm" method="post" action="<%= request.getContextPath() %>/loan/save">
            <input type="hidden" name="readerId" value="${sessionScope.selectedReader.id}">
            <button class="btn" type="button"
                    onclick="showConfirmModal()"
                    <c:if test="${empty sessionScope.selectedReader || empty sessionScope.selectedLoanItems}">disabled</c:if>>
                Save
            </button>
        </form>

        <a class="btn secondary" href="<%= request.getContextPath() %>/ScanDocumentCodeView.jsp">Return</a>
    </div>
</div>

<div id="confirmModal" class="modal-overlay">
    <div class="modal-content">
        <p>Do you want to save this loan slip?</p>
        <div class="modal-buttons">
            <button class="btn-yes" onclick="submitSaveForm()">Yes</button>
            <button class="btn-no" onclick="closeConfirmModal()">No</button>
        </div>
    </div>
</div>

<script>
    const modal = document.getElementById('confirmModal');
    const saveForm = document.getElementById('saveLoanForm');

    function showConfirmModal() {
        const saveButton = saveForm.querySelector('button');
        if (!saveButton.disabled) { modal.style.display = 'flex'; }
    }
    function closeConfirmModal() { modal.style.display = 'none'; }
    function submitSaveForm() { if (saveForm) { saveForm.submit(); } closeConfirmModal(); }
    window.onclick = function(event) { if (event.target == modal) { closeConfirmModal(); } }

    const successMessage = "<%= successMessage == null ? "" : successMessage.replace("\"", "\\\"") %>";

    if (successMessage && successMessage.length > 0) {
        alert(successMessage);
        
        window.location.href = "<%= request.getContextPath() %>/StaffHomeView.jsp";
    }
</script>

</body>
</html>