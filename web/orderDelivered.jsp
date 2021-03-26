<%-- 
    Document   : orderDelivered
    Created on : 25-Mar-2021, 10:21:02 AM
    Author     : Dell
--%>

<%@page import="dao.orderDetailDAO"%>
<%@page import="entity.OrderDetails"%>
<%@page import="dao.DeliveryBoyDAO"%>
<%@page import="entity.DeliveryBoy"%>
<%@page import="dao.ShopkeeperDAO"%>
<%@page import="java.util.List"%>
<%@page import="entity.Shopkeeper"%>
<%@page import="email.EmailUtility"%>
<%@page import="dao.CustomerDAO"%>
<%@page import="dao.ordersDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%!
    private String host;
    private String port;
    private String user;
    private String pass;
%>
<%
    ServletContext context = pageContext.getServletContext();
    host = context.getInitParameter("host");
    port = context.getInitParameter("port");
    user = context.getInitParameter("user");
    pass = context.getInitParameter("pass");
    String recipientDB ="";
    
    String SOId = request.getParameter("id");
    String email = (String) session.getAttribute("email");
    int OId = 0;
    int i = 0;
    if(SOId != null && email != null){
        OId = Integer.parseInt(SOId);
        if(OId != 0){
            i = ordersDAO.updateStatus(OId);
        }else {
            response.sendRedirect("orders.jsp");
        }
        
        if(i == 0){
            session.setAttribute("Error", "Something went wrong");
            response.sendRedirect("orderDetails.jsp?o_id="+OId);
        }else {
                recipientDB = email;
                String recipientCustomer = CustomerDAO.viewById(ordersDAO.viewByOrderId(OId).getCustomer().getCId()).getEmail();

                String subject = "Order Delivered";
                String contentDB = "You are delivered the order of <b>" + recipientCustomer + "</b> and it's order id is <b>" + OId;
                String contentCustomer = "This order delivered by <b>" + recipientDB + "<>/b and it's order id is <b>" + OId;
                try {
                    EmailUtility.sendEmail(host, port, user, pass, recipientDB, subject, contentDB);
                    EmailUtility.sendEmail(host, port, user, pass, recipientCustomer, subject, contentCustomer);

                } catch (Exception ex) {
                    ex.printStackTrace();

                } finally {
                    List<Shopkeeper> shopkeepers = ShopkeeperDAO.viewAll();
                    List<OrderDetails> details = orderDetailDAO.viewByOrderId(OId);
                    String sendEmail = "";
                    for (OrderDetails detail : details) {
                        sendEmail = sendEmail + "," + ShopkeeperDAO.viewSinglebyID(detail.getShopkeeper().getSId()).getEmail();
                    }
                    String recipient = sendEmail;
                    subject = "Delivery boy Delivered the order";
                    String content = "This order is delivered by </b>" + recipientDB;
                    try {
                        EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);

                    } catch (Exception ex) {
                        ex.printStackTrace();

                    }
                    session.setAttribute("orderDelivered", "Order is delivered");
                    response.sendRedirect("orders.jsp");
                }
        }
    } else {
            out.print("Somthing went wrong " + email + " " + SOId);
        }
        
%>