<%-- 
    Document   : deleteCartItem
    Created on : 07-Mar-2021, 11:40:08 PM
    Author     : Dell
--%>

<%@page import="javax.security.sasl.AuthenticationException"%>
<%@page import="dao.cartDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
            int id = 0;
            int CId = 0;
            String sid = request.getParameter("id");
            //String SCid = request.getParameter("CId");
            String email = (String)session.getAttribute("email");
            String role = (String)session.getAttribute("role");
            if(role == null){
                role = "";
            } else if (!role.equals("CUSTOMER")) {
                    throw new AuthenticationException();
                }
            if(sid!=null && email != null){
                id = Integer.parseInt(sid);
                if(cartDAO.checkEmail(id,email)>0){
                    cartDAO.delete(id);
                    out.print("Success check");
                    response.sendRedirect("cart.jsp");
                }
                out.print("fail");
            }
            else {out.print("fail");}
%>
