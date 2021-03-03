<html>
<body>	

	
	<%@page  import="dao.AccountDAO"%>
     <%
	
	String EMAIL=request.getParameter("email").toLowerCase();
	String PASSWORD=request.getParameter("pswd");
	Boolean isValid = AccountDAO.ValidUser(EMAIL, PASSWORD);
        //Accounts bean = new Accounts(EMAIL, PASSWORD);
        //Boolean isValid = true;
	if(isValid == true){
            String role = AccountDAO.getRole(EMAIL);
            session.setAttribute("email",EMAIL);
            session.setAttribute("role",role);
            response.sendRedirect("index.jsp");
            
	}
	else 
	{
            session.setAttribute("errorMessage", "Incorrect Email or Password");
            response.sendRedirect("login.jsp");
        }
	%>
	
	</body>
	</html>