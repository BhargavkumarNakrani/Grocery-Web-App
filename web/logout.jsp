<%@page import="dao.AccountDAO"%>
<%@page import="entity.Accounts"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logout - Vegefoods</title>
    </head>
    <body>
        <%
            String email = (String) session.getAttribute("email");
            Accounts a= AccountDAO.viewByEmail(email);
            a.setActive(false);
            AccountDAO.update(a);
            session.invalidate();
            response.sendRedirect("login.jsp");
%>
    </body>
</html>
