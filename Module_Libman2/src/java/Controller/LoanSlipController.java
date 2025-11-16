package Controller;

import dao.LoanSlipDAO;
import model.Document;
import model.ReaderCard;
import model.User;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoanSlipServlet", urlPatterns = {"/loan/save"})
public class LoanSlipController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        
        String redirectPage = request.getContextPath() + "/PrintLoanSlipView.jsp";

        
        ReaderCard selectedReader = (ReaderCard) session.getAttribute("selectedReader");
        List<Map<String, Object>> selectedLoanItems = (List<Map<String, Object>>) session.getAttribute("selectedLoanItems");
        User currentUser = (User) session.getAttribute("currentUser"); 

        
        if (selectedReader == null || selectedLoanItems == null || selectedLoanItems.isEmpty() || currentUser == null) {
            session.setAttribute("saveError", "Error: Missing reader, document, or staff information to save.");
            response.sendRedirect(redirectPage);
            return;
        }

        int readerId = selectedReader.getId();
        int staffId = currentUser.getId();
        Date borrowDate = new Date(); 

        
        String expectedReturnDateStr = null;
        if (!selectedLoanItems.isEmpty()) {
             Map<String, Object> firstItem = selectedLoanItems.get(0);
             expectedReturnDateStr = (String) firstItem.get("expectedReturnDate");
        }

        
        Date expectedReturnDate = null;
        
        SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy"); 
        
        try {
            if (expectedReturnDateStr == null || expectedReturnDateStr.isEmpty()) {
                 throw new ParseException("Expected return date cannot be empty", 0);
            }
            expectedReturnDate = formatter.parse(expectedReturnDateStr);
        } catch (ParseException e) {
            session.setAttribute("saveError", "Error: Invalid expected return date format (" + expectedReturnDateStr + "). Please go back and try again.");
            response.sendRedirect(redirectPage);
            return;
        }

        
        LoanSlipDAO loanSlipDAO = new LoanSlipDAO();
        int loanSlipId = -1; 
        try {
             loanSlipId = loanSlipDAO.saveLoanSlip(borrowDate, expectedReturnDate, readerId, staffId);
        } catch (Exception e) {
            System.err.println("Critical error calling LoanSlipDAO.saveLoanSlip:");
            e.printStackTrace();
            session.setAttribute("saveError", "System Error: Could not save the loan slip. Details: " + e.getMessage());
            response.sendRedirect(redirectPage);
            return;
        }

        
        if (loanSlipId > 0) { 
            boolean allDetailsSaved = true;

            // TODO: You need code here to save the 'selectedLoanItems'
            // You will need to loop through selectedLoanItems and call 
            // loanSlipDAO.saveLoanSlipDetails(loanSlipId, docId) for each document.

            if (allDetailsSaved) {
                
                session.removeAttribute("selectedReader");
                session.removeAttribute("selectedLoanItems");
                session.removeAttribute("errorReader");
                session.removeAttribute("errorDocument");
                session.removeAttribute("saveError");

                
                session.setAttribute("saveSuccess", "Loan Slip #" + loanSlipId + " saved successfully!");
                response.sendRedirect(redirectPage);
            } else {
                
                 session.setAttribute("saveError", "Error: Could not save the details of the borrowed documents.");
                response.sendRedirect(redirectPage);
            }

        } else {
             
            System.err.println("LoanSlipDAO.saveLoanSlip returned ID <= 0. Check DAO for SQL errors.");
            session.setAttribute("saveError", "Error: Could not save loan slip to database (DAO error). Please check server logs.");
            response.sendRedirect(redirectPage);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.sendRedirect(request.getContextPath() + "/ScanReaderCardView.jsp");
    }
}