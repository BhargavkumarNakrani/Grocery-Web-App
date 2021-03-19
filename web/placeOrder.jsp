<%-- 
    Document   : placeOrder
    Created on : 14-Mar-2021, 10:16:04 AM
    Author     : Dell
--%>

<%@page import="dao.DeliveryBoyDAO"%>
<%@page import="email.EmailUtility"%>
<%@page import="dao.ShopkeeperDAO"%>
<%@page import="entity.Shopkeeper"%>
<%@page import="dao.productDAO"%>
<%@page import="entity.Products"%>
<%@page import="entity.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="dao.ordersDAO"%>
<%@page import="dao.orderDetailDAO"%>
<%@page import="entity.DeliveryBoy"%>
<%@page import="java.util.Date"%>
<%@page import="dao.cartDAO"%>
<%@page import="dao.CustomerDAO"%>
<%@page import="entity.Customer"%>
<%@page import="entity.OrderDetails"%>
<%@page import="entity.Orders"%>
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
    String email = (String) session.getAttribute("email");
    
    //Cart cart = new Cart();
    Orders order_bean = new Orders();
    //List<OrderDetails> orderDetail_bean = new ArrayList<OrderDetails>();
    OrderDetails orderDetail_bean = new OrderDetails();
    List<Cart> cart = new ArrayList<Cart>();
    Customer customer_bean = new Customer();
    DeliveryBoy deliveryBoy_bean = new DeliveryBoy();
    
    String email1 = request.getParameter("email");
    String address = request.getParameter("address");
    String contact = request.getParameter("contact");
    long phone = Long.parseLong(contact);
    String name = request.getParameter("fname") + " " + request.getParameter("lname");
    
    if(email != null){
        cart = cartDAO.viewCart(email);
        long subTotal = cartDAO.cartTotal(email);
        int Delivery = subTotal > 99 ? 0 : 10;
        int Total = (int) subTotal + Delivery;
        
        Date orderDate = new java.util.Date();
        
        CustomerDAO.updateAddress(address, email);
        customer_bean = CustomerDAO.viewByEmail(email);
        order_bean = new Orders(customer_bean, Total, orderDate, 0, address);
        int o_id = ordersDAO.save(order_bean);
        out.print(o_id);
        if(o_id > 1){
            for(Cart c : cart){
                out.print(c.getProducts().getPId()+" ");
                Products product_bean = productDAO.viewById(c.getProducts().getPId());
                Shopkeeper shopkeeper_bean = ShopkeeperDAO.viewSinglebyID(product_bean.getShopkeeper().getSId());
                orderDetail_bean = new OrderDetails(order_bean, product_bean, shopkeeper_bean, c.getPrice(), c.getAmount(), c.getQuantity());
                out.print(orderDetailDAO.save(orderDetail_bean)+" ");
                cartDAO.delete(c.getId());
            }
            String recipient = email;
            String subject = "Order Place";
            String content = " Hello, <b>"+name+"</b> your order is place successfully and your order id is <b>"+o_id+"</b>";
            try {
                    EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);

            } catch (Exception ex) {
                ex.printStackTrace();

            } finally{
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
                subject = "Customer Order Place";
                content = " Hello, <b>"+name+"</b> is order place successfully and He/Her order id is <b>"+o_id+"</b>";
                try {
                        EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);

                } catch (Exception ex) {
                    ex.printStackTrace();

                } finally{
                    response.sendRedirect("cart.jsp"); 
                }
            }
       }
    }
%>