<%-- 
    Document   : forgotPassword
    Created on : 18-Mar-2021, 5:44:38 PM
    Author     : Dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="passwordGenerator.jsp" method="POST">
            <label for="email">Email</label>
            <input type="email" name="email" class="form-control" id="email">
            <button>Get password</button>
        </form>
    </body>
</html>
