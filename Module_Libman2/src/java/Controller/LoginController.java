/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;
import dao.LoginDAO;
import model.User;
import dao.DAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import javax.servlet.http.*; 

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginController extends HttpServlet{
    private LoginDAO loginDAO = new LoginDAO();
   
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        request.setCharacterEncoding("UTF-8");
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        User user = loginDAO.validate(username, password);
        if(user != null){
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);
            
            String role = user.getRole();
            if("reader".equalsIgnoreCase(role)){
                response.sendRedirect(request.getContextPath() + "/ReaderHomeView.jsp");
            }
            else if("staff".equalsIgnoreCase(role)){
                response.sendRedirect(request.getContextPath() + "/StaffHomeView.jsp");
            }
            else{
                request.setAttribute("error","Tài khoản không xác định");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            }
            
        }
        else{
            request.setAttribute("error","Sai username hoặc password");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendRedirect(req.getContextPath() + "/Login.jsp");
    }
    
}
