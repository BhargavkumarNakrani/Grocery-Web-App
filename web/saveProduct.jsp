<%-- 
    Document   : saveProduct
    Created on : 11-Mar-2021, 7:49:51 PM
    Author     : Dell
--%>

<%@page import="dao.CustomerDAO"%>
<%@page import="entity.Customer"%>
<%@page import="java.util.List"%>
<%@page import="email.EmailUtility"%>
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
        
    InputStream inputStream = null; // input stream of the upload file
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
    
    if(SPId == null && email != null){
        productDAO.save(product_bean);
        String email1 = email;
        List<Customer> customers = CustomerDAO.viewAll();
        for(Customer customer : customers){
            email1 = email1+","+customer.getEmail();
        }
        String recipient = email1;
        String subject = "Product updates for vegeFoods";
        String content = "New product is added by "+ ShopkeeperDAO.viewSingle(email).getShopName()+" <br> ***<u>Product Detail</u>***<br> Product name : "+product_bean.getName()+" <br> Product price : "+product_bean.getPrice()+" <br> "
                + " product quantity :"+product_bean.getQuantity();
         String resultMessage = "";
        try {
                EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
                resultMessage="Success";

        } catch (Exception ex) {
            ex.printStackTrace();
            resultMessage="fail "+ex.getMessage();
        }
        out.print(resultMessage);
        response.sendRedirect("shop.jsp");
    } else if(PId != 0 && email != null){
        if(image.getSize() > 0){
            product_bean.setPId(PId);
            productDAO.update(product_bean);
        } else {
            productDAO.update(PId,category_bean.getCategoryId(),shopkeeper_bean.getSId(),uom_bean.getUomId(),pname,quantity ,price);
        }
        
        response.sendRedirect("shop.jsp");
    } else{
        response.sendRedirect("login.jsp");
    }
    
%>