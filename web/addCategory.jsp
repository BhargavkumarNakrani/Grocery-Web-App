<%-- 
    Document   : addCategory
    Created on : 01-Apr-2021, 8:59:32 AM
    Author     : Dell
--%>

<%@page import="entity.Category"%>
<%@page import="dao.categoryDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 
    String category = request.getParameter("category");
    String pageName = request.getParameter("pageName");
    String role = (String) session.getAttribute("role");
    if(category != null && role.equals("SHOPKEEPER")) {
        Category bean = new Category(category);
        categoryDAO.save(bean);
        response.sendRedirect(pageName);
    }
%>