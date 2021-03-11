<%-- 
    Document   : saveProduct
    Created on : 11-Mar-2021, 7:49:51 PM
    Author     : Dell
--%>

<%@page import="dao.productDAO"%>
<%@page import="dao.uomDAO"%>
<%@page import="dao.categoryDAO"%>
<%@page import="dao.ShopkeeperDAO"%>
<%@page import="entity.Products"%>
<%@page import="entity.Category"%>
<%@page import="entity.Shopkeeper"%>
<%@page import="entity.Uom"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="java.io.InputStream"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String email = (String) session.getAttribute("email");
    if(email == null){
        response.sendRedirect("login.jsp");
    }
    String SPId = request.getParameter("id");
    int PId = 0;
    if(SPId != null) {
        PId = Integer.parseInt(SPId);
    }
    String pname = request.getParameter("pname");
    String category = request.getParameter("category");
    int categoryId = Integer.parseInt(category);
    String Squantity = request.getParameter("stock");
    int quantity= Integer.parseInt(Squantity);
    String uom = request.getParameter("uom");
    int uomId= Integer.parseInt(uom);
    String Sprice = request.getParameter("price");
    int price= Integer.parseInt(Sprice);
    byte[] img;
    Part image = null;
    image = request.getPart("productimg");
        
    InputStream inputStream = null; // input stream of the upload fil
     if (image != null) {
        // prints out some information for debugging
        System.out.println(image.getName());
        System.out.println(image.getSize());
        System.out.println(image.getContentType());

        // obtains input stream of the upload file
        inputStream = image.getInputStream();
    }
    img = IOUtils.toByteArray(inputStream);
    Category category_bean = new Category();
    Shopkeeper shopkeeper_bean = new Shopkeeper();
    Uom uom_bean = new Uom();
    
    category_bean = categoryDAO.viewSinglebyId(categoryId);
    shopkeeper_bean = ShopkeeperDAO.viewSinglebyEmail(email);
    uom_bean = uomDAO.viewSinglebyId(uomId);
    //shopkeeper_bean.setSId(shopkeeper_bean.getSId());
    
    Products product_bean = new Products(category_bean,shopkeeper_bean,uom_bean,pname,quantity, price, img );
    
    if(SPId == null){
        productDAO.save(product_bean);
        response.sendRedirect("shop.jsp");
    } else {
        if(image.getSize() > 0){
            productDAO.update(product_bean);
        } else {
            productDAO.update(PId,category_bean.getCategoryId(),shopkeeper_bean.getSId(),uom_bean.getUomId(),pname,quantity ,price);
        }
    }
    
%>