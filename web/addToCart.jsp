<%-- 
    Document   : addToCart
    Created on : 08-Mar-2021, 6:36:33 PM
    Author     : Dell
--%>

<%@page import="dao.cartDAO"%>
<%@page import="dao.productDAO"%>
<%@page import="entity.Products"%>
<%@page import="entity.Cart"%>
<%@page import="entity.Customer"%>
<%@page import="dao.CustomerDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<% 
    String SproductId = request.getParameter("productId");
    String email = (String)session.getAttribute("email");
    int quantity = 1;
    if(SproductId!=null && email!=null){
        //int CId = CustomerDAO.getId(email);
        int PId = Integer.parseInt(SproductId);
        Cart cart = new Cart();
        Customer customer = new Customer();
        Products products = new Products();
        customer = CustomerDAO.viewByEmail(email);
        products = productDAO.viewById(PId);
        cart = new Cart(customer,products,quantity,products.getPrice(),quantity*products.getPrice());
        if(cartDAO.save(cart)>0){
            session.setAttribute("cartAdded", products.getName()+" added to cart please check into cart ");
            response.sendRedirect("shop.jsp");
        }
    }
%>