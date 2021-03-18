/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package email;

import dao.AccountDAO;
import entity.Accounts;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 

/**
 *
 * @author Dell
 */
public class EmailSendingServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private String host;
    private String port;
    private String user;
    private String pass;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            ServletContext context = getServletContext();
            String email = request.getParameter("email");
            if (email != null) {
                Accounts users = AccountDAO.viewByEmail(email);
                String password = users.getPassword();
                if (password != null) {
                    host = context.getInitParameter("host");
                    port = context.getInitParameter("port");
                    user = context.getInitParameter("user");
                    pass = context.getInitParameter("pass");

                    String recipient = email;
                    String subject = "Your Password";
                    String content = "Your vegeFood password is </br><b>" + password + "</b>";

                    String resultMessage = "";

                    try {
                        EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
                        resultMessage = "The passsword was sent successfully to your email please check your mail box";
                    } catch (Exception ex) {
                        ex.printStackTrace();
                        resultMessage = "There were an error: " + ex.getMessage();
                    } finally {
                        HttpSession session = request.getSession();
                        session.setAttribute("successMessage", resultMessage);
//                getServletContext().getRequestDispatcher("/login.jsp").forward(
//                        request, response);
                        response.sendRedirect("login.jsp");
                    }
                }
            } else {
                response.sendRedirect("forgotPassword.jsp");
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
