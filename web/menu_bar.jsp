<%@page import="dao.cartDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String email = (String) session.getAttribute("email");%>
<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">Vegefoods</a>
            <p><center>Welcome, <%=(email!=null)?email:"User" %></center></p>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="oi oi-menu"></span> Menu
            </button>
            <div class="collapse navbar-collapse" id="ftco-nav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item active"><a href="index.jsp" class="nav-link">Home</a></li>
                    <li class="nav-item"><a href="shop.jsp" class="nav-link">Shop</a></li>
                    <li class="nav-item"><a href="about.jsp" class="nav-link">About</a></li>
                    <li class="nav-item"><a href="contact.jsp" class="nav-link">Contact</a></li>
                    <%
                        if(email != null){ %>
                            <% if(session.getAttribute("role").equals("CUSTOMER")) {  %>
                                <li class="nav-item cta cta-colored">
                                    <a href="cart.jsp" class="nav-link">
                                        <i class="fa fa-shopping-cart" style="color:black; font-size:20px"></i>
                                        <div class="cart-item"><%=cartDAO.CartItem(email)%></div>
                                    </a>
                                </li>
<!--                                <li class="nav-item dropdown">
                                    <a class="nav-link btn btn-primary" id="dropdown04" data-toggle="dropdown" style='padding:15px 0px;' aria-haspopup="true" aria-expanded="true">Register</a>
                                    <div class="dropdown-menu" aria-labelledby="dropdown04">
                                        <a class="dropdown-item" href="shop_registration.jsp">For Shopkeeper</a>
                                        <a class="dropdown-item" href="emp_registration.jsp">For Employee</a>
                                    </div>
                                </li>-->
                            <% }%>
                            <li class="nav-item"><button onclick="window.location.href='logout.jsp'" class="btn btn-primary">Logout</button></li>
                        <%} else{%>
                            <li class="nav-item"><button class="btn btn-primary" onclick="window.location.href='login.jsp'">Login</button></li>
                            <li class="nav-item"><button class="btn btn-primary" onclick="window.location.href='signup.jsp'">Signup</button></li>
                        <%}
                    %>
                </ul>
            </div>
        </div>
    </nav>
