<%-- 
    Document   : cancalOrder
    Created on : 17-Mar-2021, 5:59:56 PM
    Author     : Dell
--%>

<%@page import="dao.ordersDAO"%>
<%@page import="entity.Orders"%>
<%@page import="dao.orderDetailDAO"%>
<%@page import="entity.OrderDetails"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String SOId = request.getParameter("OId");
    String email = (String) session.getAttribute("email");
    if(SOId != null && email != null) {
        int OId = Integer.parseInt(SOId);
        if(orderDetailDAO.deleteByOrders(OId)>0){
            if(ordersDAO.deleteByOrders(OId)>0){
                response.sendRedirect("orderHistory.jsp");
            } else{
                out.print("fail to delete orders table data ");
            }
        } else {
            out.print("fail to delete orders because of OrderDetail");
        }
    } else{
        out.print("fail");
    }
%>