<%-- 
    Document   : addToCart
    Created on : 08-Mar-2021, 6:36:33 PM
    Author     : Dell
--%>

<%@page import="javax.security.sasl.AuthenticationException"%>
<%@page import="dao.cartDAO"%>
<%@page import="dao.productDAO"%>
<%@page import="entity.Products"%>
<%@page import="entity.Cart"%>
<%@page import="entity.Customer"%>
<%@page import="dao.CustomerDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 
    String role = (String)session.getAttribute("role");
    if(role == null){
        role = "";
    } else if (!role.equals("CUSTOMER")) {
            throw new AuthenticationException();
    }
    String SproductId = request.getParameter("productId");
    String email = (String)session.getAttribute("email");
    String Squantity = request.getParameter("quantity");
    int quantity = Squantity!=null ? Integer.parseInt(Squantity):1;
    if(SproductId!=null && email!=null && quantity > 0){
        //int CId = CustomerDAO.getId(email);
        int PId = Integer.parseInt(SproductId);
        Cart cart = new Cart();
        Customer customer = new Customer();
        Products products = new Products();
        customer = CustomerDAO.viewByEmail(email);
        products = productDAO.viewById(PId);
        cart = new Cart(customer,products,quantity,products.getPrice(),quantity*products.getPrice());
        if(cartDAO.checkCartByProductId(PId, email) < 1 ){
            cartDAO.save(cart);
            if(Squantity==null) {
                session.setAttribute("cartMessage", products.getName()+" added to cart please check into cart ");
                response.sendRedirect("shop.jsp");
            } else {
                response.sendRedirect("cart.jsp");
            }
        } else {
            session.setAttribute("cartMessage", products.getName()+" product is already into cart please check ");
            if(Squantity!=null){
                response.sendRedirect("shop.jsp");    
            } else{
                response.sendRedirect("cart.jsp"); 
            }
        }
    }  
%>