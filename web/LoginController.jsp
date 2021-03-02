<html>
<body>	

	
	<%@page  import="java.sql.*"%>
     <%
	Class.forName("com.mysql.jdbc.Driver");
        String mysqlURL = "jdbc:mysql://localhost:3306/grocerywebapp?user=root";
        Connection conn = DriverManager.getConnection(mysqlURL); 
	String sql = "SELECT lower(email) email,password FROM accounts where lower(email)=?";
	String EMAIL=request.getParameter("email").toLowerCase();
	String PASSWORD=request.getParameter("pswd");
	PreparedStatement st = conn.prepareStatement(sql);
	st.setString(1,EMAIL);
        ResultSet rs = st.executeQuery();
        String email="";
        String pswd ="";
	 while(rs.next()){
		  email=rs.getString("email");
		  pswd = rs.getString("password");
	 }
	 if(EMAIL.equals(email) && PASSWORD.equals(pswd)){
             
            session.setAttribute("email",email);
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