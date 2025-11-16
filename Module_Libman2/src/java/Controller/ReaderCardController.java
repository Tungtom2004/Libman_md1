package Controller; 

import dao.ReaderCardDAO;
import model.ReaderCard;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ReaderCardServlet", urlPatterns = {"/ReaderCardServlet"})
public class ReaderCardController extends HttpServlet {

    private final ReaderCardDAO readerCardDAO = new ReaderCardDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        try {
            String idStr = request.getParameter("id");
            String destination = "ScanReaderCardView.jsp"; 

            if (idStr == null || idStr.trim().isEmpty()) {
                request.setAttribute("error", "Please enter a reader ID.");
                request.getRequestDispatcher(destination).forward(request, response);
                return;
            }

            try {
                int id = Integer.parseInt(idStr);
                
                if (id < 0) {
                    request.setAttribute("error", "Invalid ID: " + id);
                } else {
                    ReaderCard card = readerCardDAO.getReaderCardbyID(id);

                    if (card != null) {
                        request.setAttribute("readerCard", card);
                    } else {
                        request.setAttribute("error", "Reader card not found with ID: " + id);
                    }
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid ID: " + idStr);
            }
            
            request.getRequestDispatcher(destination).forward(request, response);

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "An error occurred: " + ex.getMessage());
            request.getRequestDispatcher("ScanReaderCardView.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession();
        try {
            String idStr = request.getParameter("readerId");
            int id = Integer.parseInt(idStr);

            if (id < 0) {
                session.setAttribute("errorReader", "Invalid reader ID: " + id);
            } else {
                ReaderCard card = readerCardDAO.getReaderCardbyID(id);

                if (card != null) {
                    session.setAttribute("selectedReader", card);
                    session.removeAttribute("errorReader");
                } else {
                    session.setAttribute("errorReader", "Cannot select reader with ID: " + id);
                }
            }

        } catch (NumberFormatException e) {
            session.setAttribute("errorReader", "Invalid reader ID upon confirmation.");
        }
        
        response.sendRedirect(request.getContextPath() + "/ScanDocumentCodeView.jsp");
    }
}