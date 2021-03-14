<%-- 
    Document   : updateOrders
    Created on : 14-Mar-2021, 6:16:00 PM
    Author     : Dell
--%>

<%@page import="dao.DeliveryBoyDAO"%>
<%@page import="dao.ordersDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String email = (String) session.getAttribute("email");
    String SOId = request.getParameter("Oid");
    if(SOId != null && email != null){
        int OId = Integer.parseInt(SOId);
        
        ordersDAO.updateDB(OId, DeliveryBoyDAO.ViewSingle(email).getDbId());
        if(DeliveryBoyDAO.updateDBorderTaken(email)>0)
            
            session.setAttribute("OrderAssign", "This order is taken by you");
        response.sendRedirect("orders.jsp");
        
    }
%>