<%@page import="javax.security.sasl.AuthenticationException"%>
<%@page import="dao.productDAO"%>
<%@page import="dao.ShopkeeperDAO"%>
<%@page import="entity.Shopkeeper"%>
<%@page import="dao.CustomerDAO"%>
<%@page import="dao.ordersDAO"%>
<%@page import="entity.Orders"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="entity.OrderDetails"%>
<%@page import="dao.orderDetailDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String role = (String)session.getAttribute("role");
    String email = (String)session.getAttribute("email");
//    if(role != "SHOPKEEPER" || role != "DELIVERYBOY"){
//        response.sendRedirect("contact.jsp");
//    }
    String SOId = request.getParameter("o_id");
    int OId = 0;
    List<OrderDetails> orderList = new ArrayList<OrderDetails>();
    //List<Shopkeeper> shop = new ArrayList<Shopkeeper>();
    List<OrderDetails> shopId = new ArrayList<OrderDetails>();
    Orders order = new Orders();
    
    if(email == null){
        role ="";
    }
    
    if((SOId != null && role != "CUSTOMER") && (role.equals("SHOPKEEPER") || role.equals("DELIVERYBOY")) && (email != null)){
        OId = Integer.parseInt(SOId);
        orderList = orderDetailDAO.viewByOrderId(OId);
        order =  ordersDAO.viewByOrderId(OId);
        shopId = orderDetailDAO.viewShopName(OId);
        //shop = ShopkeeperDAO.viewSinglebyID();
    } else {
        if(SOId == null) {
            session.setAttribute("OrderSelect", "Please select order first");
            response.sendRedirect("orders.jsp");
        } else if(email == null){
            response.sendRedirect("login.jsp");
        }
        else if(role != "SHOPKEEPER" || role != "DELIVERYBOY"){
            throw new AuthenticationException(); 
        }
    }
%>
<html lang="en">

<head>
<title>Order Details - Vegefoods</title>
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
    .ftco-section{padding:4em 0;}
    .table tbody tr td{padding:25px 10px;}
</style>
</head>
<body>
    <jsp:include page="top_bar.html" />
    <jsp:include page="menu_bar.jsp" />
    
    <section class="ftco-section ftco-cart">
        <div class="container">
            <div class="row mb-5 justify-content-start">
                <div class="col-lg-6 cart-wrap ftco-animate">
                    <div class="cart-total mb-3">
                        <h3>Order Details</h3>
                        <p class="d-flex">
                            <span>Order ID</span>
                            <span><%=order.getOId() %></span>
                        </p>
                        <p class="d-flex">
                            <span>Customer Name</span>
                            <span><% if(OId != 0 ) out.print(CustomerDAO.viewById(order.getCustomer().getCId()).getName()); %></span>
                        </p>
                        <p class="d-flex">
                            <span>Customer Address</span>
                            <span><% if(OId != 0 ) out.print(CustomerDAO.viewById(order.getCustomer().getCId()).getAddress()); %></span>
                        </p>
                        <p class="d-flex">
                            <span>Customer Phone</span>
                            <span><% if(OId != 0 ) out.print(CustomerDAO.viewById(order.getCustomer().getCId()).getPhone()); %></span>
                        </p>
                        <p class="d-flex">
                            <span>Shipping Address</span>
                            <span><%=order.getAddress() %></span>
                        </p>
                        <h3>Shop Details</h3>
                        <% 
                        for(Object obj : shopId)
                        { 
                            int o = Integer.parseInt(obj.toString());
                            Shopkeeper shop= ShopkeeperDAO.viewSinglebyID(o);
                            %>
                        <p class="d-flex">
                            <span><%=shop.getShopName()%></span>
                            <span><%=shop.getAddress() %></span>
                        </p>
                        <% }
                        %>
                        
                    </div>
                </div>
                <%if(role.equals("DELIVERYBOY")){%>
                <div class="col-lg-6 ftco-animate">
                    <div class="float-right">
                        <a href="orderDelivered.jsp?id=<%=OId %>" class="btn py-3 px-4 btn-primary">Order Delivered</a>
                    </div>
                </div>
                <%}%>
            </div>
            <div id="accordion">
                <%
                 int Subtotal = 0;
                 for(Object obj : shopId)
                { 
                    int shop_id = Integer.parseInt(obj.toString());
                    Shopkeeper shop= ShopkeeperDAO.viewSinglebyID(shop_id);
                    if(!shop.getEmail().equalsIgnoreCase(email) && role.equals("SHOPKEEPER")){
                        continue;
                    }
                %>
                <div class="card mb-2">
                    <div class="card-header" id="heading<%=shop_id %>">
                        <h5 class="mb-0">
                            <a class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapse<%=shop_id %>" aria-expanded="false" aria-controls="collapse<%=shop_id %>">
                                <%=shop.getShopName() %>
                            <i class="fa fa-plus float-right m-1"></i>
                            </a>
                        </h5>
                    </div>

                    <div id="collapse<%=shop_id %>" class="collapse" aria-labelledby="heading<%=shop_id %>" data-parent="#accordion">
                        <div class="card-body">
                            <div class="col-md-12 ftco-animate">
                                <div class="cart-list">
                                    <table class="table table-hover">
                                        <thead class="thead-primary">
                                            <tr class="text-center">
                                                <th>Sr No.</th>
                                                <th>Product Name</th>
                                                <th>price</th>
                                                <th>quantity</th>
                                                <th>Amount</th>
                                                <th>Total</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                               orderList = orderDetailDAO.viewByShopAndOId(OId,shop_id);
                                               int i=0;
                                               int total = 0;
                                               for(OrderDetails ol : orderList) {
                                                   total = ol.getAmount()+total;
                                               
                                            %>
                                            <tr>
                                                <td><%=++i %></td>
                                                <td><%=productDAO.viewById(ol.getProducts().getPId()).getName() %></td>
                                                <td><%=ol.getPrice() %></td>
                                                <td><%=ol.getQuantity() %></td>
                                                <td><%=ol.getAmount() %></td>
                                                <% if(ol.equals(orderList.get(orderList.size()-1))) {
                                                   Subtotal = Subtotal+total; %>
                                                <td rowspan="<%=orderList.size() %>"><%=total %></td>
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
                <%
                    }
                    int Delivery = 0;
                    int Total = 0;
                    int Discount = 0;
                    Delivery = Subtotal > 99 ? 0 : 10;
                    Discount = Delivery == 10 ? 0 : 10;
                    Total = (int) Subtotal + Delivery;
                   
                %>
            </div>
            <div class="row justify-content-end">
                <div class="col-lg-4 mt-5 cart-wrap ftco-animate fadeInUp ftco-animated">
                    <div class="cart-total mb-3">
                        <h3>Totals</h3>
                        <p class="d-flex">
                            <span>Subtotal</span>
                            <span>Rs. <%=Subtotal %></span>
                        </p>
                        <p class="d-flex">
                            <span>Delivery</span>
                            <span>RS. 10</span>
                        </p>
                        <p class="d-flex">
                            <span>Discount</span>
                            <span>Rs. -<%=Discount %></span>
                        </p>
                        <hr>
                        <p class="d-flex total-price">
                            <span>Total</span>
                            <span>Rs. <%=Total %></span>
                        </p>
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
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-23581568-13"></script>
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
</body>
</html>
