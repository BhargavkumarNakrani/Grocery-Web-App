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
    String SOId = request.getParameter("o_id");
    int OId = 0;
    List<OrderDetails> orderList = new ArrayList<OrderDetails>();
    //List<Shopkeeper> shop = new ArrayList<Shopkeeper>();
    List<OrderDetails> shopId = new ArrayList<OrderDetails>();
    Orders order = new Orders();
    if(SOId != null){
        OId = Integer.parseInt(SOId);
        orderList = orderDetailDAO.viewByOrderId(OId);
        order =  ordersDAO.viewByOrderId(OId);
        shopId = orderDetailDAO.viewShopName(OId);
        //shop = ShopkeeperDAO.viewSinglebyID();
    } else {
        session.setAttribute("OrderSelect", "Please select order first");
        //response.sendRedirect("Order.jsp");
    }
%>
<html lang="en">

<head>
<title>Order Details - Vegefoods</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
    .table
</style>
</head>
<body>
    <jsp:include page="top_bar.html" />
    <jsp:include page="menu_bar.jsp" />
    
    <section class="ftco-section ftco-cart">
        <div class="container">
            <div class="row mb-4 justify-content-start">
                <div class="col-lg-6 cart-wrap ftco-animate fadeInUp ftco-animated">
                    <div class="cart-total mb-3">
                        <h3>Order Details</h3>
                        <p class="d-flex">
                            <span>Order ID</span>
                            <span><%=order.getOId() %></span>
                        </p>
                        <p class="d-flex">
                            <span>Customer Name</span>
                            <span><%=CustomerDAO.viewById(order.getCustomer().getCId()).getName() %></span>
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
            </div>
            <div class="row">
                <div class="col-md-12 ftco-animate">
                    <div class="cart-list">
                        <table class="table">
                            <thead class="thead-primary">
                                <tr class="text-center">
                                    <th>Sr No.</th>
                                    <th>Product Name</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Amount</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="text-center accordion-toggle" colspan="6" data-toggle="collapse" data-target="#demo1">
                                    <td class="sr"><h5>1</h5></td>
                                    <td class="product-name">
                                        <h3>Bell Pepper</h3>
                                        <p>from: Shop Name</p>
                                    </td>
                                    <td class="price">$4.90</td>
                                    <td class="price">
                                        <h5>2</h5>
                                    </td>
                                    <td class="total">$4.90</td>
                                </tr>
                                <tr class="p">
                                    <td colspan="6" class="hiddenRow">
                                        <div class="accordian-body collapse p-3" id="demo1">
                                            <p>No : <span>1</span></p>
                                            <p>Date : <span>12 Jan 2018</span> </p>
                                            <p>Description : <span>Good</span> </p>
                                            <p>Credit : <span>$150.00</span> </p>
                                            <p>Debit : <span></span></p>
                                            <p>Balance : <span>$150.00</span></p>
                                        </div> 
                                    </td> 
                                </tr>
                                <tr class="text-center accordion-toggle" colspan="6" data-toggle="collapse" data-target="#demo2">
                                    <td class="sr"><h5>2</h5></td>
                                    <td class="product-name">
                                        <h3>Bell Pepper</h3>
                                        <p>from: shop Name-2</p>
                                    </td>
                                    <td class="price">$15.70</td>
                                    <td class="price">
                                        <h5>2</h5>
                                    </td>
                                    <td class="total">$15.70</td>
                                </tr>
                                <tr class="p">
                                    <td colspan="6" class="hiddenRow">
                                        <div class="accordian-body collapse p-3" id="demo2">
                                            <p>No : <span>1</span></p>
                                            <p>Date : <span>12 Jan 2018</span> </p>
                                            <p>Description : <span>Good</span> </p>
                                            <p>Credit : <span>$150.00</span> </p>
                                            <p>Debit : <span></span></p>
                                            <p>Balance : <span>$150.00</span></p>
                                        </div> 
                                    </td> 
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="row justify-content-end">
                <div class="col-lg-4 mt-5 cart-wrap ftco-animate fadeInUp ftco-animated">
                    <div class="cart-total mb-3">
                        <h3>Totals</h3>
                        <p class="d-flex">
                            <span>Subtotal</span>
                            <span>Rs. 190</span>
                        </p>
                        <p class="d-flex">
                            <span>Delivery</span>
                            <span>RS. 10</span>
                        </p>
                        <p class="d-flex">
                            <span>Discount</span>
                            <span>Rs. -10</span>
                        </p>
                        <hr>
                        <p class="d-flex total-price">
                            <span>Total</span>
                            <span>Rs. 190</span>
                        </p>
                    </div>
                </div>
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
<script src="js/google-map.js"></script>
<script src="js/main.js"></script>
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-23581568-13"></script>
<script>
    $('.accordion-toggle').click(function(){
	$('.hiddenRow').hide();
	$(this).next('tr').find('.hiddenRow').show();
    });
</script>
</body>
</html>