<%@page import="dao.ShopkeeperDAO"%>
<%@page import="dao.productDAO"%>
<%@page import="dao.orderDetailDAO"%>
<%@page import="entity.OrderDetails"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.Orders"%>
<%@page import="dao.ordersDAO"%>
<%@page import="dao.CustomerDAO"%>
<%@page import="entity.Customer"%>
<%@page import="javax.security.sasl.AuthenticationException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String role = (String) session.getAttribute("role");
    String email = (String) session.getAttribute("email");
    Customer customer = new Customer();
    List<Orders> orders = new ArrayList<Orders>();
    if(email == null) {
        role = "";
        email = "";
        String uri = request.getRequestURI();
        String pageName = uri.substring(uri.lastIndexOf("/") + 1);
        response.sendRedirect("login.jsp?return_to=" + pageName);
    } else if(role.equals("SHOPKEEPER") && role.equals("DELIVERYBOY")){
        throw new AuthenticationException(); 
    } else if(role.equals("CUSTOMER")){
        customer = CustomerDAO.viewByEmail(email);
        orders=ordersDAO.viewByCustomerId(customer.getCId());
    }

%>
<!DOCTYPE html>
<html lang="en">

    <!-- Mirrored from preview.colorlib.com/theme/vegefoods/cart.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 18 Feb 2021 10:05:08 GMT -->
    <head>
        <title>Orders - Vegefoods</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800&amp;display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
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
            .table tbody tr td,.table tbody tr td h3{color:black;font-size: 15px!important;}
        </style>
    </head>
    <body class="goto-here">
        <jsp:include page="top_bar.html"/>
        <jsp:include page="menu_bar.jsp"/>
        
        <section class="ftco-section ftco-cart mb-5">
            <div class="container">
                <div id="accordion">
                    <%
                    SimpleDateFormat formatter = new SimpleDateFormat("E,dd MMMM yyyy (hh:mm a)");  
                    for(Orders order : orders){
                    %>
                    <div class="card mb-2">
                        <div class="card-header" id="heading3">
                            <h5 class="mb-0">
                                <a class="btn d-flex btn-link collapsed" data-toggle="collapse" data-target="#collapse<%=order.getOId() %>" aria-expanded="false" aria-controls="collapse3">
                                    <div style="width:50%;margin-right: 20px">Order ID : <%=order.getOId() %></div> 
                                    <div style="width:50%;margin-right: 25px">Order Date : <%=formatter.format(order.getOrderDate()) %></div>
                                    <i class="fa fa-plus float-right m-1"></i>
                                </a>
                            </h5>
                        </div>

                        <div id="collapse<%=order.getOId() %>" class="collapse" aria-labelledby="heading3" data-parent="#accordion">
                            <div class="card-body">
                                <div class="col-md-12 ftco-animate fadeInUp ftco-animated">
                                    <div class="cart-list">
                                        <table class="table table-hover">
                                            <thead class="thead-primary">
                                                <tr class="text-center">
                                                    <th>Sr No.</th>
                                                    <th>Product Name</th>
                                                    <th>Price</th>
                                                    <th>Quantity</th>
                                                    <th>Amount</th>
                                                    <th>Total</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <%
                                            List<OrderDetails> OrdersDetail = orderDetailDAO.viewByOrderId(order.getOId());
                                            int total = 0;
                                            for(OrderDetails obj : OrdersDetail) {
                                                total = obj.getAmount()+total;
                                            %>
                                                <tr class="text-center">
                                                    <td><%=obj.getId() %></td>
                                                    <td class="product-name"><h3><%=productDAO.viewById(obj.getProducts().getPId()).getName() %></h3><h3>by <%=ShopkeeperDAO.viewSinglebyID(obj.getShopkeeper().getSId()).getShopName() %></h3></td>
                                                    <td><%=obj.getPrice() %></td>
                                                    <td><%=obj.getQuantity() %></td>
                                                    <td><%=obj.getAmount() %></td>
                                                    <% if(obj.equals(OrdersDetail.get(OrdersDetail.size()-1))) { %>
                                                    <td rowspan="<%=OrdersDetail.size() %>"><%=total %></td>
                                                <% }%>
                                                   
                                                </tr>
                                            <% }%>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% }%>
                </div>
            </div>
        </section>
        <jsp:include page="footer.html"/>

        <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee" /><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00" /></svg></div>
        <script src="js/jquery.min.js"></script>
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
        <script>
            $('a.btn-link').click(function () {
                $(this).find('i').toggleClass('fa-plus fa-minus');
                $(this).closest('div.card').siblings().each(function(){
                    if($(this).find('i.fa').hasClass('fa-minus')){
                        $(this).find('i.fa').toggleClass('fa-minus fa-plus');
                    }
                });
            });
        </script>
        <script async src="https://www.googletagmanager.com/gtag/js?id=UA-23581568-13"></script>
        <script>
            window.dataLayer = window.dataLayer || [];
            function gtag() {
                dataLayer.push(arguments);
            }
            gtag('js', new Date());
            gtag('config', 'UA-23581568-13');
        </script>
    </body>
</html>