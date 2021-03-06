<%-- 
    Document   : SingupController
    Created on : 03-Mar-2021, 5:54:47 PM
    Author     : Dell
--%>

<%@page import="dao.DeliveryBoyDAO"%>
<%@page import="dao.ShopkeeperDAO"%>
<%@page import="org.apache.commons.io.IOUtils"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="entity.DeliveryBoy"%>
<%@page import="entity.Shopkeeper"%>
<%@page import="dao.CustomerDAO"%>
<%@page import="entity.Customer"%>
<%@page import="dao.AccountDAO"%>
<%@page import="entity.Accounts"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        
        String role = "CUSTOMER";
        String String_Sid = request.getParameter("id");
        int id=0;
        if(String_Sid != null)
            id = Integer.valueOf(String_Sid);
        String name =request.getParameter("fname") +" "+ request.getParameter("lname");
        String pass = request.getParameter("pswd");
        String email = request.getParameter("email").toLowerCase();
        String Sphone = request.getParameter("contact");
        String sname = request.getParameter("sname");
        String address = request.getParameter("address");
        String aId = request.getParameter("accountId");
        long phone = Long.parseLong(Sphone);
        if(request.getParameter("role") != null){
            role = request.getParameter("role");
        }
        byte[] img;
        int accountId = 0;
        if(aId != null){
            accountId = Integer.valueOf(aId);          
        }
        
        Part image = null;
        if(role.equalsIgnoreCase("SHOPKEEPER"))
            image = request.getPart("shopimg");
        
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
         
        //byte[] img = inputStream.readAllBytes();
        
        
        Customer bean_customer = new Customer();
        Shopkeeper bean_shopkeeper = new Shopkeeper();
        DeliveryBoy bean_deliveryboy = new DeliveryBoy();
        Accounts bean = new Accounts(email, pass,false, role);
        if(role.equalsIgnoreCase("CUSTOMER"))
            bean_customer = new Customer(bean,name, "No Address", phone, email);
        else if(role.equalsIgnoreCase("DELIVERYBOY")){
            if(address==null) {address="No Address";}
            Date date = new java.util.Date();
            bean_deliveryboy = new DeliveryBoy(bean, name, phone, email,address,date);
        }
        else if(role.equalsIgnoreCase("SHOPKEEPER"))
            bean_shopkeeper = new Shopkeeper(bean, name, sname, address, phone, email,img);
                
//        AccountDAO.save(bean);
//        if(role == "CUSTOMER"){
//            //Customer bean_fk = new Customer(bean,name, "", phone, email);
//            CustomerDAO.save(bean_fk);
//        }
            //out.print("Added Successfully");
        if(id==0){
            if(AccountDAO.save(bean) > 0){
                if(role.equalsIgnoreCase("CUSTOMER")){
                    //Customer bean_fk = new Customer(bean,name, "", phone, email);
                    CustomerDAO.save(bean_customer);
                    session.setAttribute("successMessage", "Welcome "+name+ ".<br>You are now member of VegeFoods.");
                    response.sendRedirect("login.jsp");
                }
                else if(role.equalsIgnoreCase("SHOPKEEPER")){
                    ShopkeeperDAO.insert(bean_shopkeeper);
                    response.sendRedirect("index.jsp");
                }
                else if(role.equalsIgnoreCase("DELIVERYBOY")){
                    out.println(bean.getAcccountId());// bean_DeliveryBoy.getAccounts().getAcccountId();
                    DeliveryBoyDAO.insert(bean_deliveryboy);
                    response.sendRedirect("index.jsp");
                    out.print("Inserted Deliveryboy");
                }
            }
        }
        else {
            out.print("Hello");
            if(role.equalsIgnoreCase("SHOPKEEPER") && accountId != 0){
                bean.setAcccountId(accountId);
                AccountDAO.update(bean);
                bean_shopkeeper.setSId(id);
                if(image.getSize() > 0){
                    ShopkeeperDAO.update(bean_shopkeeper);
                } else {
                    ShopkeeperDAO.update(id,name, sname, address, phone, email);
                }
                response.sendRedirect("index.jsp");
            }
            else if(role.equalsIgnoreCase("DELIVERYBOY")){
//                bean.setAcccountId(accountId);
//                AccountDAO.update(bean);
//                bean_shopkeeper.setSId(id);
//                DeliveryBoyDAO.update(bean_DeliveryBoy);
//                
//                response.sendRedirect("index.jsp");
            }
        }
            
            
        
    %>
</html>
