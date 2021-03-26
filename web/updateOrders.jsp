<%-- 
    Document   : updateOrders
    Created on : 14-Mar-2021, 6:16:00 PM
    Author     : Dell
--%>

<%@page import="dao.ShopkeeperDAO"%>
<%@page import="java.util.List"%>
<%@page import="entity.DeliveryBoy"%>
<%@page import="entity.Shopkeeper"%>
<%@page import="dao.CustomerDAO"%>
<%@page import="email.EmailUtility"%>
<%@page import="dao.DeliveryBoyDAO"%>
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
     
    String recipientDB = "";
    
    String email = (String) session.getAttribute("email");
    String SOId = request.getParameter("Oid");
    if(SOId != null && email != null){
        int OId = Integer.parseInt(SOId);
        
        ordersDAO.updateDB(OId, DeliveryBoyDAO.ViewSingle(email).getDbId());
        if(DeliveryBoyDAO.updateDBorderTaken(email)>0) {
            recipientDB = email;
            String recipientCustomer = CustomerDAO.viewById(ordersDAO.viewByOrderId(OId).getCustomer().getCId()).getEmail() ;
            
            String subject = "Order Taken";
            String contentDB = "You are taken the order of <b>"+recipientCustomer+"</b> and it's order id is <b>"+OId;
            String contentCustomer = "This order taken by <b>"+recipientDB+"<>/b and it's order id is <b>"+OId;
            try {
                    EmailUtility.sendEmail(host, port, user, pass, recipientDB, subject, contentDB);
                    EmailUtility.sendEmail(host, port, user, pass, recipientCustomer, subject, contentCustomer);

            } catch (Exception ex) {
                ex.printStackTrace();

            } finally{
                List<Shopkeeper> shopkeepers= ShopkeeperDAO.viewAll();
                List<DeliveryBoy> deliveryBoys = DeliveryBoyDAO.viewAll();
                String sendEmail = "";
                for(Shopkeeper shopkeeper : shopkeepers){
                    sendEmail = sendEmail+","+shopkeeper.getEmail();
                }
                String recipient = sendEmail;
                subject = "Delivery boy Assign";
                String content = "This order is taken by </b>"+recipientDB;
                try {
                        EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);

                } catch (Exception ex) {
                    ex.printStackTrace();

                }
                session.setAttribute("OrderAssign", "This order is taken by you");
                response.sendRedirect("orders.jsp");
            }
        }
    }
%>