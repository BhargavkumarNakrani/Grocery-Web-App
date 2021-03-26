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
<title>Admin - Vegefoods</title>
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
    #address{width: 30%}
    .ftco-section{padding: 2em 0em 0em 0px;}
    .mb{margin-bottom: 6em;}
    .ftco-footer{margin-top: 8em;}
    @media(max-width:576px){.mng-btn{width:50%;margin-bottom: 10px;}}
</style>
</head>
<body class="goto-here">
    <jsp:include page="top_bar.html" />
    <jsp:include page="menu_bar.jsp" />
    
    <section class="ftco-section">
        <div class="container">
            <div class="row justify-content-center mb-3 pb-3">
                <div class="col-md-12 heading-section text-center ftco-animate">
                    <h2 class="mb-4">Manage All Members</h2>
                </div>
            </div>
        </div>
    </section>
    
    <div class="container pb-5 pl-4">
        <div class="ftco-animate mb-5">
            <div class="d-flex">
                <div class="searchbar" style="display: block;">
                    <input class="search_input" type="text" name="" placeholder="Search...">
                    <i class="fas fa-search search_icon" style="padding-top: 0px!important;"></i>
                </div>
            </div>
        </div>
    </div>
        
    <div id="accordion">
        <div class="container">
        <div class="row">
            <div class="col-lg-3 col-sm-3 mng-btn">
            <button class="btn btn-primary m-auto d-flex collapsed" data-toggle="collapse" data-target="#customer" aria-expanded="false" aria-controls="collapse">Customers</button>
            </div>
            <div class="col-lg-3 col-sm-3 mng-btn">
            <button class="btn btn-primary m-auto d-flex collapsed" data-toggle="collapse" data-target="#shopkeeper" aria-expanded="false" aria-controls="collapse">shopkeepers</button>
            </div>
            <div class="col-lg-3 col-sm-3 mng-btn">
            <button class="btn btn-primary m-auto d-flex collapsed" data-toggle="collapse" data-target="#employee" aria-expanded="false" aria-controls="collapse">Employees</button>
            </div>
            <div class="col-lg-3 col-sm-3 mng-btn">
            <button class="btn btn-primary m-auto d-flex collapsed" data-toggle="collapse" data-target="#empdetails" aria-expanded="false" aria-controls="collapse">Employee Details</button>
            </div>
        </div>
        </div>
        <div class="accordion-group">
    <section class="ftco-section pt-5 collapse" id="customer" aria-labelledby="heading3" data-parent="#accordion">
        <div class="container">
            <div class="row">
                <div class="col-md-12 ftco-animate">
                    <div class="cart-list">
                        <table class="table table-hover">
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
                            <tbody class="tbody">
                                <% 
                                 for(Customer customer : customers){ 
                                    account = AccountDAO.viewByEmail(customer.getEmail());
                                %>
                                <tr class="text-center">
                                    <td><%=customer.getName() %></td>
                                    <td><%=customer.getEmail() %></td>
                                    <td><%=customer.getPhone() %></td>
                                    <td id="address"><%=customer.getAddress() %></td>
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
<!--    <section class="ftco-section">
        <div class="container">
            <div class="row justify-content-center mb-3 pb-3">
                <div class="col-md-12 heading-section text-center ftco-animate">
                    <h2 class="mb-4">Manage Shops</h2>
                </div>
            </div>
        </div>
    </section>-->
    
    <section class="ftco-section pt-5 collapse" id="shopkeeper" aria-labelleby="heading3" data-parent="#accordion">
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
                            <tbody class="tbody">
                                <% 
                                 for(Shopkeeper shopkeeper : shopkeepers){ 
                                    account = AccountDAO.viewByEmail(shopkeeper.getEmail());
                                %>
                                <tr class="text-center">
                                    <td><%=shopkeeper.getName() %></td>
                                    <td><%=shopkeeper.getShopName() %></td>
                                    <td><%=shopkeeper.getEmail() %></td>
                                    <td><%=shopkeeper.getPhone() %></td>
                                    <td id="address"><%=shopkeeper.getAddress() %></td>
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
    
<!--    <section class="ftco-section">
        <div class="container">
            <div class="row justify-content-center mb-3 pb-3">
                <div class="col-md-12 heading-section text-center ftco-animate">
                    <h2 class="mb-4">Manage Employees</h2>
                </div>
            </div>
        </div>
    </section>-->
    
    <section class="ftco-section pt-5 collapse" id="employee" aria-labelleby="heading3" data-parent="#accordion">
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
                            <tbody class="tbody">
                                <% 
                                 for(DeliveryBoy db : deliveryBoys){ 
                                    account = AccountDAO.viewByEmail(db.getEmail());
                                %>
                                <tr class="text-center">
                                    <td><%=db.getName() %></td>
                                    <td><%=db.getEmail() %></td>
                                    <td><%=db.getPhone() %></td>
                                    <td id="address"><%=db.getAddress() %></td>
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
                            
    <section class="ftco-section pt-5 collapse" id="empdetails" aria-labelledby="heading3" data-parent="#accordion">
        <div class="container">
            <div class="card-body">
                <div class="col-md-12 ftco-animate">
                    <div class="cart-list">
                        <table class="table table-hover">
                            <thead class="thead-primary">
                                <tr class="text-center">
                                    <th>Employee ID</th>
                                    <th>Employee Name</th>
                                    <th>Salary</th>
                                    <th>Salary Date</th>
                                </tr>
                            </thead>
                            <tbody class="tbody">
                                <tr class="text-center">
                                    <td>1</td>
                                    <td>Mahesh</td>
                                    <td>5000</td>
                                    <td>2/3/2021</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </section>
    </div>
    </div>
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
<script>
$(document).ready(function () {
    $('.search_input').on('keyup',function(){
        var filter;
        filter = $(this).val().toUpperCase();
        
        $(".tbody tr").filter(function() {
            $(this).toggle($(this).text().toUpperCase().indexOf(filter) > -1)
        });
    });
});
</script>
</body>
</html>