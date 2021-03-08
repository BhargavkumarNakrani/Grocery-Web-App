<html>
<body>	

	
	<%@page  import="dao.AccountDAO"%>
     <%
        String Return_to;
        String query = request.getParameter("return_to");
        if(request.getParameter("return_to")!=null){
            Return_to = request.getParameter("return_to");
        }else{
            Return_to = "index.jsp";
        }
	String EMAIL=request.getParameter("email").toLowerCase();
	String PASSWORD=request.getParameter("pswd");
	Boolean isValid = AccountDAO.ValidUser(EMAIL, PASSWORD);
        //Accounts bean = new Accounts(EMAIL, PASSWORD);
        //Boolean isValid = true;
	if(isValid == true){
            String role = AccountDAO.getRole(EMAIL);
            session.setAttribute("email",EMAIL);
            session.setAttribute("role",role);
            response.sendRedirect(Return_to);
            
	}
	else 
	{
            session.setAttribute("errorMessage", "Incorrect Email or Password");
            response.sendRedirect("login.jsp?"+query);
        }
	%>
	
	</body>
	</html>