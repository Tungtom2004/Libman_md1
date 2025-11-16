package Controller;

import dao.DocumentDAO;
import model.Document;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.*;

@WebServlet(name = "DocumentServlet", urlPatterns = {"/DocumentServlet"})
public class DocumentController extends HttpServlet {

    private final DocumentDAO documentDAO = new DocumentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = param(request, "action", "search"); 

        try {
            switch (action) {
                case "detail": {
                    String idStr = request.getParameter("id");
                    Integer id = parseIdFromEither(idStr,null); 
                    
                    if (id == null) {
                        request.setAttribute("error", "Invalid document ID: " + idStr);
                        request.getRequestDispatcher("SearchDocumentView.jsp").forward(request, response);
                        return; 
                    }

                    Document doc = documentDAO.getDocumentById(id); 
                    if (doc == null) {
                        request.setAttribute("error", "Document not found with ID=" + id);
                        request.getRequestDispatcher("SearchDocumentView.jsp").forward(request, response);
                        return;
                    }

                    request.setAttribute("document", doc);
                    request.getRequestDispatcher("DocumentDetailView.jsp").forward(request, response);
                    return;
                }
                
                case "scan": {
                    String idStr = request.getParameter("id");
                    String destination = "ScanDocumentCodeView.jsp"; 
                    
                    Integer id = parseIdFromEither(idStr, null); 

                    if (id != null) {
                        Document doc = documentDAO.getDocumentById(id);
                        
                        if (doc != null) {
                            request.setAttribute("document", doc);
                        } else {
                            request.setAttribute("error", "Document not found with ID: " + id);
                        }
                    } else { 
                        if (idStr != null && !idStr.isEmpty()) {
                            request.setAttribute("error", "Invalid ID: " + idStr);
                        }
                    }
                    
                    request.getRequestDispatcher(destination).forward(request, response);
                    return; 
                }

                case "search":
                default: {
                    String keyword = param(request, "keyword", "").trim();
                    
                    if(keyword.isEmpty()){
                        request.setAttribute("keyword","");
                        request.setAttribute("documents",Collections.emptyList());
                        request.setAttribute("error","Please enter a search keyword.");
                        request.getRequestDispatcher("SearchDocumentView.jsp").forward(request, response);
                        return; 
                    }
                    
                    List<Document> docs = documentDAO.getDocumentByName(keyword);

                    if (docs.isEmpty()) {
                        request.setAttribute("error", "No documents found matching: '" + keyword + "'");
                        request.setAttribute("keyword", keyword); 
                        request.setAttribute("documents", Collections.emptyList()); 
                        request.getRequestDispatcher("SearchDocumentView.jsp").forward(request, response);
                        return;
                    }
                    
                    request.setAttribute("keyword", keyword);
                    request.setAttribute("documents", docs);
                    request.getRequestDispatcher("SearchDocumentView.jsp").forward(request, response);
                    return; 
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "An error occurred: " + ex.getMessage());
            request.getRequestDispatcher("SearchDocumentView.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = param(request, "action", ""); 

        try {
            switch (action) {
                case "select": {
                    HttpSession session = request.getSession();
                    List<Map<String, Object>> loanItems = (List<Map<String, Object>>) session.getAttribute("selectedLoanItems");
                    if (loanItems == null) {
                        loanItems = new ArrayList<>();
                    }

                    String idStr = request.getParameter("documentId");
                    Integer id = parseIdFromEither(idStr, null);
                    
                    if (id == null) {
                        session.setAttribute("errorDocument", "Invalid document ID.");
                        response.sendRedirect(request.getContextPath() + "/ScanDocumentCodeView.jsp");
                        return;
                    }

                    LocalDate borrowDate = LocalDate.now();
                    LocalDate expectedReturnDate = borrowDate.plusDays(14);
                    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy");

                    Document doc = documentDAO.getDocumentById(id); 

                    if (doc != null) {
                        Map<String, Object> item = new HashMap<>();
                        item.put("document", doc);
                        item.put("borrowDate", borrowDate.format(dtf)); 
                        item.put("expectedReturnDate", expectedReturnDate.format(dtf));
                        
                        loanItems.add(item);
                        
                        session.setAttribute("selectedLoanItems", loanItems);
                        session.removeAttribute("errorDocument");
                    } else {
                        session.setAttribute("errorDocument", "Cannot select document with ID: " + id);
                    }

                    response.sendRedirect(request.getContextPath() + "/ScanDocumentCodeView.jsp");
                    return;
                }
                
                default:
                    
                    response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "Action " + action + " not supported.");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("errorDocument", "An error occurred: " + ex.getMessage());
            response.sendRedirect(request.getContextPath() + "/ScanDocumentCodeView.jsp");
        }
    }

    public String param(HttpServletRequest req, String name, String def) {
        String v = req.getParameter(name);
        return v == null ? def : v;
    }

    public Integer parseIdFromEither(String idStr, String code) {
        try {
            if (idStr != null && !idStr.isBlank()) {
                int id = Integer.parseInt(idStr.trim());
                if (id < 0) return null; 
                return id;
            }
            if (code != null && !code.isBlank()) {
                String digits = code.replaceAll("\\D+", ""); 
                if (!digits.isEmpty()) {
                     int id = Integer.parseInt(digits);
                     if (id < 0) return null; 
                     return id;
                }
            }
        } catch (NumberFormatException ignored) { 
        }
        return null; 
    }
}