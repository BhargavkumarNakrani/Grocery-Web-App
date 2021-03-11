<%-- 
    Document   : productDelete
    Created on : 07-Mar-2021, 11:17:09 PM
    Author     : Dell
--%>

<%@page import="dao.cartDAO"%>
<%@page import="dao.productDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String role = (String) session.getAttribute("role");
       if(role.equalsIgnoreCase("SHOPKEEPER"))
       {
           String s_id = request.getParameter("productId");
           if(s_id!=null){
               int id = Integer.parseInt(s_id);
               int i =cartDAO.deleteByProduct(id);
                productDAO.deleteById(id);
                session.setAttribute("deleteProduct", "Product delete successfully");
                response.sendRedirect("shop.jsp");
           }
       }
%>