<%-- 
    Document   : placeOrder
    Created on : 14-Mar-2021, 10:16:04 AM
    Author     : Dell
--%>

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
<%
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
            response.sendRedirect("cart.jsp");   
       }
    }
%>