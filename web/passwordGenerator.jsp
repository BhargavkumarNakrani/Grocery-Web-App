<%-- 
    Document   : passwordGenerater
    Created on : 18-Mar-2021, 5:51:42 PM
    Author     : Dell
--%>

<%@page import="email.EmailUtility"%>
<%@page import="entity.Accounts"%>
<%@page import="dao.AccountDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%!
    private String host;
    private String port;
    private String user;
    private String pass;
%><%
    String email = request.getParameter("email");
    if(email != null){
        Accounts  users = AccountDAO.viewByEmail(email);
        String password = users.getPassword();
        if(password != null){
            ServletContext context = pageContext.getServletContext();
            host = context.getInitParameter("host");
            port = context.getInitParameter("port");
            user = context.getInitParameter("user");
            pass = context.getInitParameter("pass");
            
            String recipient = email;
            String subject = "Your Password";
            String content = "Hello "+users.getEmail()+" Your vegeFood password is </br><b>"+password+"</b>";
            
            String resultMessage = "";
            try {
                EmailUtility.sendEmail(host, port, user, pass, recipient, subject,content);
                resultMessage = "The passsword was sent successfully to your email please check it";
            } catch (Exception ex) {
                ex.printStackTrace();
                resultMessage = "There were an error: " + ex.getMessage();
            } finally {
                session.setAttribute("successMessage", resultMessage);
//                getServletContext().getRequestDispatcher("/login.jsp").forward(
//                        request, response);
                response.sendRedirect("login.jsp");
            }
        }
    }else {
        response.sendRedirect("forgotPassword.jsp");
    }
%>