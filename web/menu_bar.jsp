<%@page import="dao.DeliveryBoyDAO"%>
<%@page import="dao.ShopkeeperDAO"%>
<%@page import="dao.CustomerDAO"%>
<%@page import="dao.cartDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String email = (String) session.getAttribute("email");
   String role = (String) session.getAttribute("role");
   String search = request.getParameter("s");
   if(search==null) search="";
   String Name = "";
   if(role == null){role = "";}
        if(role.equals("CUSTOMER")){
            Name = CustomerDAO.viewByEmail(email).getName();    
        }else if(role.equals("SHOPKEEPER")){
                Name = ShopkeeperDAO.viewSingle(email).getName();
            }else if(role.equals("DELIVERYBOY")){
                    Name = DeliveryBoyDAO.ViewSingle(email).getName();
            }
%>
<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">Vegefoods</a>
            <span style="color:black"><center>Welcome,<%if(email==null){out.print("User");}%></center></span>
            <% if(email != null){
                    if(!role.equals("ADMIN")){
                %>                
            <ul class="navbar-nav">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="dropdown04" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><%=Name%></a>
                    <div class="dropdown-menu" aria-labelledby="dropdown04">
                        <% if(role.equals("CUSTOMER")){%>
                            <a class="dropdown-item" href="signup.jsp">My Profile</a>
                            <a class="dropdown-item" href="orderHistory.jsp">Order History</a>
                            <%}else if(role.equals("SHOPKEEPER")){%>
                                <a class="dropdown-item" href="shop_registration.jsp">My Profile</a>
                                <a class="dropdown-item" href="#category-modal" data-toggle="modal" data-backdrop="static" data-keyboard="false">Add Category</a>
                                <a class="dropdown-item" href="addProduct.jsp">Add Product</a>
                                <a class="dropdown-item" href="orders.jsp">Orders</a>
                                <a class="dropdown-item" href="orderHistory.jsp">Order History</a>
                            <%}else if(role.equals("DELIVERYBOY")){%>
                                <a class="dropdown-item" href="emp_registration.jsp">My Profile</a>
                                <a class="dropdown-item" href="orders.jsp">Orders</a>
                                <a class="dropdown-item" href="orderHistory.jsp">Order History</a>
                        <%}%>
                    </div>
                </li>
            </ul>
                <%}else{ %>
                    <span style="color: black">Admin</span>
                <%} }%>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="oi oi-menu"></span> Menu
            </button>
            <div class="collapse navbar-collapse" id="ftco-nav">
                <ul class="navbar-nav ml-auto">
                    <% if(!role.equals("ADMIN") && !role.equals("DELIVERYBOY")){%>
                    <li class="nav-item desktop-search">
                        <!-- search for for desktop view -->
                        <i class="fa fa-search nav-link" aria-hidden="true"></i>
<!--                        <div class="container">
                                <div class="d-flex">-->
                                <div class="searchbar">
                                    <form action="shop.jsp" method="GET" >
                                        <input class="search_input" value="<%=search%>" type="text" name="s" placeholder="Search Product..">
                                        <i class="fas fa-search search_icon" type="submit" style="padding-top:0px!important;"></i>
                                    </form>
                                </div>
<!--                            </div>
                        </div>-->
                    </li>
                    <!-- search for mobile view -->
                    <li class="nav-item mobile-search">
                        <div class="container">
                            <div class="d-flex">
                                <div class="searchbar">
                                    <form action="shop.jsp" method="get">
                                    <input class="search_input" value="<%=search%>" type="text" name="s" placeholder="Search Product..">
                                    <i class="fas fa-search search_icon" type="submit"></i>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </li>
                    <%}%>
                    <li class="nav-item"><a href="index.jsp" class="nav-link">Home</a></li>
                    <% if(!role.equals("ADMIN") && !role.equals("DELIVERYBOY")){%>
                    <li class="nav-item"><a href="shop.jsp" class="nav-link">Shop</a></li>
                    <%}%>
                    <li class="nav-item"><a href="contact.jsp" class="nav-link">Contact</a></li>
                    <%
                        if(email != null){ 
                        if(role.equals("CUSTOMER")) {  %>
                                <li class="nav-item cta cta-colored">
                                    <a href="cart.jsp" class="nav-link">
                                        <i class="fa fa-shopping-cart" style="color:black; font-size:20px"></i>
                                        <div class="cart-item"><%=cartDAO.CartItem(email)%></div>
                                    </a>
                                </li>
                        <% }else if(role.equals("ADMIN")){%>
                            <li class="nav-item dropdown">
                                <a class="nav-link btn btn-primary" id="dropdown04" data-toggle="dropdown" style='padding:15px 0px;' aria-haspopup="true" aria-expanded="true">Register</a>
                                <div class="dropdown-menu" aria-labelledby="dropdown04">
                                    <a class="dropdown-item" href="shop_registration.jsp">For Shop</a>
                                    <a class="dropdown-item" href="emp_registration.jsp">For Employee</a>
                                </div>
                            </li>
                        <%}%>
                            <li class="nav-item"><button onclick="window.location.href='logout.jsp'" class="btn btn-primary">Logout</button></li>
                        <%} else{%>
                            <li class="nav-item"><button class="btn btn-primary" onclick="window.location.href='login.jsp'">Login</button></li>
                            <li class="nav-item"><button class="btn btn-primary" onclick="window.location.href='signup.jsp'">Signup</button></li>
                        <%}%>
                </ul>
            </div>
        </div>
    </nav>
    <%if(role.equals("SHOPKEEPER")){%>
    <div id="category-modal" class="modal fade" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Add Category</h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <form action="" method="">
                <div class="modal-body">
                    <div class="row mb-3">
                        <div class="col">
                            <div class="form-group">
                                <label for="category">Category Name</label>
                                <input type="text" name="category" class="form-control" id="category">
                            </div>
                            <span id="category_error_message" class="text-danger"></span>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary" data-dismiss="modal">Close</button>
                    <button type="submit" class="confirm-ok btn btn-primary">Submit</button>
                </div>
                </form>
            </div>
        </div>
    </div>
    <%}%>