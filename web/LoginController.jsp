<%@page import="entity.Accounts"%>
<html>
<body>	

	
	<%@page  import="dao.AccountDAO"%>
     <%
        String Return_to;
        String query = request.getParameter("return_to");
        if(query!=null){
            Return_to = query;
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
            Accounts a= AccountDAO.viewByEmail(EMAIL);
            a.setActive(true);
            AccountDAO.update(a);
            response.sendRedirect(Return_to);
            
	}
	else 
	{
            session.setAttribute("errorMessage", "Incorrect Email or Password");
            if(query!=null){
                response.sendRedirect("login.jsp?return_to="+query);
            }else{
                response.sendRedirect("login.jsp");
            }
        }
	%>
	
	</body>
	</html>