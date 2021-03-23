<%@page import="dao.ordersDAO"%>
<%@page import="dao.AccountDAO"%>
<%@page import="entity.Accounts"%>
<%@page import="javax.security.sasl.AuthenticationException"%>
<%@page import="dao.DeliveryBoyDAO"%>
<%@page import="dao.ShopkeeperDAO"%>
<%@page import="dao.CustomerDAO"%>
<%@page import="entity.DeliveryBoy"%>
<%@page import="entity.Shopkeeper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.Customer"%>
<%@page import="java.util.List"%>
<%
    String email = (String) session.getAttribute("email");
    String role = (String) session.getAttribute("role");
    List<Customer> customers = new ArrayList<Customer>();
    List<Shopkeeper> shopkeepers = new ArrayList<Shopkeeper>();
    List<DeliveryBoy> deliveryBoys = new ArrayList<DeliveryBoy>();
    Accounts account = new Accounts();
    if(role == null){
        String uri = request.getRequestURI();
        String pageName = uri.substring(uri.lastIndexOf("/") + 1);
        response.sendRedirect("login.jsp?return_to=" + pageName);
    } else if(!role.equals("ADMIN")){
            throw new AuthenticationException();
    } else {
        customers = CustomerDAO.viewAll();
        shopkeepers = ShopkeeperDAO.viewAll();
        deliveryBoys = DeliveryBoyDAO.viewAll();
        //accounts = AccountDAO.viewAll();
    }
%>

<html lang="en">

<head>
<title>index - Vegefoods</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
<link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800&amp;display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Lora:400,400i,700,700i&amp;display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css?family=Amatic+SC:400,700&amp;display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/open-iconic-bootstrap.min.css">
<link rel="stylesheet" href="css/animate.css">
<link rel="stylesheet" href="css/owl.carousel.min.css">
<link rel="stylesheet" href="css/owl.theme.default.min.css">
<link rel="stylesheet" href="css/magnific-popup.css">
<link rel="stylesheet" href="css/aos.css">
<link rel="stylesheet" href="css/ionicons.min.css">
<link rel="stylesheet" href="css/bootstrap-datepicker.css">
<link rel="stylesheet" href="css/jquery.timepicker.css">
<link rel="stylesheet" href="css/flaticon.css">
<link rel="stylesheet" href="css/icomoon.css">
<link rel="stylesheet" href="css/style.css">
<style>
    td{color:black;}
    .ftco-section{padding: 6em 0em 0em 0px;}
    .top-section{padding-top: 0px;}
    .mb{margin-bottom: 6em;}
</style>
</head>
<body class="goto-here">
    <jsp:include page="top_bar.html" />
    <jsp:include page="menu_bar.jsp" />
    
    <section class="ftco-section">
        <div class="container">
            <div class="row justify-content-center mb-3 pb-3">
                <div class="col-md-12 heading-section text-center ftco-animate">
                    <h2 class="mb-4">Manage Customers</h2>
                </div>
            </div>
        </div>
    </section>
    
    <section class="ftco-section top-section">
        <div class="container">
            <div class="row">
                <div class="col-md-12 ftco-animate">
                    <div class="cart-list">
                        <table class="table">
                            <thead class="thead-primary">
                                <tr class="text-center">
                                    <th>Customer Name</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Address</th>
                                    <th>Status</th>
                                    <th>Total Orders</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                 for(Customer customer : customers){ 
                                    account = AccountDAO.viewByEmail(customer.getEmail());
                                %>
                                <tr class="text-center">
                                    <td><%=customer.getName() %></td>
                                    <td><%=customer.getEmail() %></td>
                                    <td><%=customer.getPhone() %></td>
                                    <td><%=customer.getAddress() %></td>
                                    <td><% if(account.getActive() == true){ out.print("Online"); } else { out.print("Offline"); } %></td>
                                    <td><%=ordersDAO.getCountCustomer(customer.getCId()) %></td>
                                </tr>
                                <% }%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <section class="ftco-section">
        <div class="container">
            <div class="row justify-content-center mb-3 pb-3">
                <div class="col-md-12 heading-section text-center ftco-animate">
                    <h2 class="mb-4">Manage Shops</h2>
                </div>
            </div>
        </div>
    </section>
    
    <section class="ftco-section top-section">
        <div class="container">
            <div class="row">
                <div class="col-md-12 ftco-animate">
                    <div class="cart-list">
                        <table class="table">
                            <thead class="thead-primary">
                                <tr class="text-center">
                                    <th>Shopkeeper Name</th>
                                    <th>Shop Name</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Address</th>
                                    <th>Status</th>
                                    <th>Total product sell</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                 for(Shopkeeper shopkeeper : shopkeepers){ 
                                    account = AccountDAO.viewByEmail(shopkeeper.getEmail());
                                %>
                                <tr class="text-center">
                                    <td><%=shopkeeper.getName() %></td>
                                    <td><%=shopkeeper.getShopName() %></td>
                                    <td><%=shopkeeper.getEmail() %></td>
                                    <td><%=shopkeeper.getPhone() %></td>
                                    <td><%=shopkeeper.getAddress() %></td>
                                    <td><% if(account.getActive() == true){ out.print("Online"); } else { out.print("Offline"); } %></td>
                                    <td><%=ordersDAO.getCountShopkeeper(shopkeeper.getSId()) %></td>
                                </tr>
                                <% }%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <section class="ftco-section">
        <div class="container">
            <div class="row justify-content-center mb-3 pb-3">
                <div class="col-md-12 heading-section text-center ftco-animate">
                    <h2 class="mb-4">Manage Employees</h2>
                </div>
            </div>
        </div>
    </section>
    
    <section class="ftco-section top-section mb">
        <div class="container">
            <div class="row">
                <div class="col-md-12 ftco-animate">
                    <div class="cart-list">
                        <table class="table">
                            <thead class="thead-primary">
                                <tr class="text-center">
                                    <th>Employee Name</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Address</th>
                                    <th>Status</th>
                                    <th>Total Order Taken</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                 for(DeliveryBoy db : deliveryBoys){ 
                                    account = AccountDAO.viewByEmail(db.getEmail());
                                %>
                                <tr class="text-center">
                                    <td><%=db.getName() %></td>
                                    <td><%=db.getEmail() %></td>
                                    <td><%=db.getPhone() %></td>
                                    <td><%=db.getAddress() %></td>
                                    <td><% if(account.getActive() == true){ out.print("Online"); } else { out.print("Offline"); } %></td>
                                    <td><%=DeliveryBoyDAO.viewOrderTaken(db.getDbId()) %></td>
                                    <td><button>Pay Salary</button></td>
                                </tr>
                                <% }%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <jsp:include page="footer.html"/>
<div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee" /><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00" /></svg></div>
<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/jquery-migrate-3.0.1.min.js"></script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.easing.1.3.js"></script>
<script src="js/jquery.waypoints.min.js"></script>
<script src="js/jquery.stellar.min.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/jquery.magnific-popup.min.js"></script>
<script src="js/aos.js"></script>
<script src="js/jquery.animateNumber.min.js"></script>
<script src="js/bootstrap-datepicker.js"></script>
<script src="js/scrollax.min.js"></script>
<script src="js/main.js"></script>
<script src="js/searchJS.js"></script>
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-23581568-13"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  
  gtag('config', 'UA-23581568-13');
</script>
</body>
</html>