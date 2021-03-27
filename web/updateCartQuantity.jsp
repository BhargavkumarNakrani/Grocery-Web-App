<%-- 
    Document   : updateCartQuantity
    Created on : 08-Mar-2021, 11:00:23 PM
    Author     : Dell
--%>

<%@page import="javax.security.sasl.AuthenticationException"%>
<%@page import="dao.cartDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String email = (String) session.getAttribute("email");
    String role = (String) session.getAttribute("role");
    if(role == null){
        role = "";
    } else if (!role.equals("CUSTOMER")) {
            throw new AuthenticationException();
    }
    String s_id = request.getParameter("id");
    String s_quantity = request.getParameter("quantity");
    if(email != null && s_id != null && s_quantity != null){
        int id = Integer.parseInt(s_id);
        int quantity = Integer.parseInt(s_quantity);
        cartDAO.updateQuntity(id, quantity);
        response.sendRedirect("cart.jsp#cart-table");
    }
%>