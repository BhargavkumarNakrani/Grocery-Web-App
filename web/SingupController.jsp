<%-- 
    Document   : SingupController
    Created on : 03-Mar-2021, 5:54:47 PM
    Author     : Dell
--%>

<%@page import="email.EmailUtility"%>
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
        if(role.equalsIgnoreCase("CUSTOMER")) {
            if(address==null) {address="No Address";}
            bean_customer = new Customer(bean,name, address, phone, email);
        }else if(role.equalsIgnoreCase("DELIVERYBOY")){
            if(address==null) {address="No Address";}
            Date date = new java.util.Date();
            bean_deliveryboy = new DeliveryBoy(bean, name, phone, email,address);
        }
        else if(role.equalsIgnoreCase("SHOPKEEPER")) {
            bean_shopkeeper = new Shopkeeper(bean, name, sname, address, phone, email,img);
    }
                
//        AccountDAO.save(bean);
//        if(role == "CUSTOMER"){
//            //Customer bean_fk = new Customer(bean,name, "", phone, email);
//            CustomerDAO.save(bean_fk);
//        }
            //out.print("Added Successfully");
        if(id==0){
            if(AccountDAO.save(bean) > 0){
                if(role.equalsIgnoreCase("CUSTOMER")){
                    String recipient = email;
                    String subject = "Registration for vegeFoods";
                    String content = " Hello, <b>"+name+"</b> as the role of <b>"+role+"</b> now you are the member of the vegeFoods<br> please continue shopping";
                    try {
                            EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
                            
                    } catch (Exception ex) {
                        ex.printStackTrace();

                    } finally {
                        CustomerDAO.save(bean_customer);
                        session.setAttribute("successMessage", "Welcome "+name+ ".<br>You are now member of VegeFoods.");
                        response.sendRedirect("login.jsp");
                    }
                    
                }
                else if(role.equalsIgnoreCase("SHOPKEEPER")){
                    String recipient = email;
                    String subject = "Registration for vegeFoods";
                    String content = " Hello, <b>"+name+"</b> as the role of <b>"+role+"</b> now you are the member of the vegeFoods";
                    try {
                            EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
                            
                    } catch (Exception ex) {
                        ex.printStackTrace();

                    } finally {
                        ShopkeeperDAO.insert(bean_shopkeeper);
                        response.sendRedirect("index.jsp");
                    }
                }
                else if(role.equalsIgnoreCase("DELIVERYBOY")){
                    String recipient = email;
                    String subject = "Registration for vegeFoods";
                    String content = " Hello, <b>"+name+"</b> as the role of <b>"+role+"</b> now you are the member of the vegeFoods";
                    try {
                            EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);
                            
                    } catch (Exception ex) {
                        ex.printStackTrace();

                    } finally {
                        bean_deliveryboy.setOrderTaken(0);
                        Date date = new java.util.Date();
                        bean_deliveryboy.setHireDate(date);
                        DeliveryBoyDAO.insert(bean_deliveryboy);
                        response.sendRedirect("index.jsp");
                        out.print("Inserted Deliveryboy");
                    }
                }
            }
        }
        else {
            if(role.equalsIgnoreCase("SHOPKEEPER") && accountId != 0){
                String recipient = email;
                String subject = "Update detail for vegeFoods";
                String content = " Hello, <b>" + name + "</b> as the role of <b>" + role + "</b> now you are the updated the user details of the vegeFoods";
                try {
                    EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);

                } catch (Exception ex) {
                    ex.printStackTrace();

                } finally {
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
            }
            else if(role.equalsIgnoreCase("DELIVERYBOY") && accountId != 0){
                String recipient = email;
                String subject = "Update detail for vegeFoods";
                String content = " Hello, <b>" + name + "</b> as the role of <b>" + role + "</b> now you are the updated the user details of the vegeFoods";
                try {
                    EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);

                } catch (Exception ex) {
                    ex.printStackTrace();

                } finally {
                    bean.setAcccountId(accountId);
                    AccountDAO.update(bean);
                    bean_deliveryboy.setDbId(id);
                    bean_deliveryboy.setOrderTaken(DeliveryBoyDAO.viewOrderTaken(id));
                    DeliveryBoyDAO.update(bean_deliveryboy);

                    response.sendRedirect("index.jsp");
                }
            }
            else if (role.equalsIgnoreCase("CUSTOMER") && accountId != 0) {
                    String recipient = email;
                    String subject = "Update detail for vegeFoods";
                    String content = " Hello, <b>" + name + "</b> as the role of <b>" + role + "</b> now you are the updated the user details of the vegeFoods";
                    try {
                        EmailUtility.sendEmail(host, port, user, pass, recipient, subject, content);

                    } catch (Exception ex) {
                        ex.printStackTrace();

                    } finally {
                        bean.setAcccountId(accountId);
                        AccountDAO.update(bean);
                        bean_customer.setCId(id);
                        CustomerDAO.update(bean_customer);

                        response.sendRedirect("index.jsp");
                    }
                }
        }
            
            
        
    %>
</html>
