<%-- 
    Document   : SingupController
    Created on : 03-Mar-2021, 5:54:47 PM
    Author     : Dell
--%>

<%@page import="dao.CustomerDAO"%>
<%@page import="entity.Customer"%>
<%@page import="dao.AccountDAO"%>
<%@page import="entity.Accounts"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        String role = "CUSTOMER";
        String name =request.getParameter("fname") +" "+ request.getParameter("lname");
        String pass = request.getParameter("pswd");
        String email = request.getParameter("email").toLowerCase();
        String Sphone = request.getParameter("contact");
        long phone = Long.parseLong(Sphone);
        //int phone = Integer.getInteger(Lphone);
        if(request.getParameter("role") != null){
            role = request.getParameter("role");
        }
        Accounts bean = new Accounts(email, pass,false, role); 
        Customer bean_fk = new Customer(bean,name, "No Address", phone, email);
//        AccountDAO.save(bean);
//        if(role == "CUSTOMER"){
//            //Customer bean_fk = new Customer(bean,name, "", phone, email);
//            CustomerDAO.save(bean_fk);
//        }
            //out.print("Added Successfully");
        
        if(AccountDAO.save(bean) > 0){
            if(role == "CUSTOMER"){
                //Customer bean_fk = new Customer(bean,name, "", phone, email);
                CustomerDAO.save(bean_fk);
                session.setAttribute("successMessage", name+" your data added successfully");
                response.sendRedirect("login.jsp");
            }
        }
        
    %>
</html>
