<%-- 
    Document   : paySalary
    Created on : 26-Mar-2021, 9:48:00 AM
    Author     : Dell
--%>

<%@page import="dao.DeliveryBoyDetailDAO"%>
<%@page import="java.util.Date"%>
<%@page import="dao.DeliveryBoyDAO"%>
<%@page import="entity.DeliveryBoyDetail"%>
<%@page import="dao.AccountDAO"%>
<%@page import="entity.Accounts"%>
<%@page import="entity.DeliveryBoy"%>
<%@page import="javax.security.sasl.AuthenticationException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String sdbId = request.getParameter("dbId");
    String role = (String) session.getAttribute("role");
    int dbId = 0;
    if(sdbId != null && role.equals("ADMIN")){
        dbId = Integer.parseInt(sdbId);
        DeliveryBoy db_bean= DeliveryBoyDAO.viewSinglebyID(dbId);
        Date salaryDate = new java.util.Date();
        long LtotalOrders = DeliveryBoyDetailDAO.viewOrderTaken(dbId);
        int totalOrders = (int)LtotalOrders;
        DeliveryBoyDetail dbDetail_bean = new DeliveryBoyDetail(db_bean, salaryDate, db_bean.getOrderTaken()*50, db_bean.getOrderTaken()-totalOrders);
        DeliveryBoyDetailDAO.insert(dbDetail_bean);
        response.sendRedirect("");
    } else {
        throw new AuthenticationException();
    }
%>
