<%-- 
    Document   : cancalOrder
    Created on : 17-Mar-2021, 5:59:56 PM
    Author     : Dell
--%>

<%@page import="dao.DeliveryBoyDAO"%>
<%@page import="dao.ShopkeeperDAO"%>
<%@page import="entity.DeliveryBoy"%>
<%@page import="java.util.List"%>
<%@page import="entity.Shopkeeper"%>
<%@page import="email.EmailUtility"%>
<%@page import="dao.ordersDAO"%>
<%@page import="entity.Orders"%>
<%@page import="dao.orderDetailDAO"%>
<%@page import="entity.OrderDetails"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        
    String SOId = request.getParameter("OId");
    String email = (String) session.getAttribute("email");
    if(SOId != null && email != null) {
        int OId = Integer.parseInt(SOId);
        if(orderDetailDAO.deleteByOrders(OId)>0){
            if(ordersDAO.deleteByOrders(OId)>0){
                    String recipient = email;
                    String subject = "Cancal order for vegeFoods";
                    String content = " Hello, your orderID ="+ OId+" is cancal successfully";
                    try {
                            EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
                            
                    } catch (Exception ex) {
                        ex.printStackTrace();

                    } finally {
                        List<Shopkeeper> shopkeepers= ShopkeeperDAO.viewAll();
                        List<DeliveryBoy> deliveryBoys = DeliveryBoyDAO.viewAll();
                        String sendEmail = "";
                        for(Shopkeeper shopkeeper : shopkeepers){
                            sendEmail = sendEmail+","+shopkeeper.getEmail();
                        }
                        for(DeliveryBoy deliveryBoy : deliveryBoys){
                            sendEmail = sendEmail+","+deliveryBoy.getEmail();
                        }
                        recipient = sendEmail;
                        subject = "Cancal order for vegeFoods";
                        content = " Hello, "+email+" is cancal the order and his/her orderID is"+ OId;
                        try {
                                EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);

                        } catch (Exception ex) {
                            ex.printStackTrace();

                        } 
                        response.sendRedirect("orderHistory.jsp");
                    }
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