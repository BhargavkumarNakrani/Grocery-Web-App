<%@page import="dao.DeliveryBoyDAO"%>
<%@page import="entity.DeliveryBoy"%>
<%@page import="entity.Shopkeeper"%>
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
    Shopkeeper shopkeeper = new Shopkeeper();
    List<Orders> orders = new ArrayList<Orders>();
    List<Orders> orders1 = new ArrayList<Orders>();
    if(email == null) {
        role = "";
        email = "";
        String uri = request.getRequestURI();
        String pageName = uri.substring(uri.lastIndexOf("/") + 1);
        response.sendRedirect("login.jsp?return_to=" + pageName);
    } else if(role.equals("CUSTOMER")){
        customer = CustomerDAO.viewByEmail(email);
        orders=ordersDAO.viewByCustomerId(customer.getCId());
    } else if(role.equals("SHOPKEEPER")){
        shopkeeper = ShopkeeperDAO.viewSinglebyEmail(email);
        orders1=ordersDAO.viewAll();
        for(Orders o : orders1){
            List<OrderDetails> ods =orderDetailDAO.viewByOrderId(o.getOId());
            int count = 0;
            for(OrderDetails od : ods){
                if(od.getShopkeeper().getSId() == ShopkeeperDAO.viewSingle(email).getSId() && count ==0){
                    orders.add(o);
                    count++;
                }
                    
            }
                  
        }
    } else if(role.equals("DELIVERYBOY")){
        DeliveryBoy db = DeliveryBoyDAO.ViewSingle(email);
        orders = ordersDAO.viewByDeliveryBoyId(db.getDbId());
    }

%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <title>Order History - Vegefoods</title>
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
            .order-id,.order-date{margin-right: 20px;width: 50%;}
            .modal-body p{margin-top: 1rem;}
            .modal-footer a{color:black;}
            .modal-header .close{font-size: 1.5rem!important;border: 0!important;}
            .cancel-order{color:#fff;}
            .cancel-order > a.btn:hover ,.modal-footer a:hover{border: 1px solid #82ae46;background: 0 0;color: #82ae46;}
            @media(max-width:991.98px){.order-id,.order-date{margin-right: 10px!important;width: 50%!important;font-size: smaller;}}
            @media(max-width:700px){.card-header{padding: 0px;}}
        </style>
    </head>
    <body class="goto-here">
        <jsp:include page="top_bar.html"/>
        <jsp:include page="menu_bar.jsp"/>

        <div id="confirm-modal" class="modal fade" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Confirmation</h5>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <p>Do you want to cancel this order?</p>
                    </div>
                    <div class="modal-footer">
                        <a href="" type="button" class="btn btn-primary" data-dismiss="modal">Close</a>
                        <a href="" type="button" class="confirm-ok btn btn-primary">Cancel Order</a>
                    </div>
                </div>
            </div>
        </div>
        <div id="cover-spin"></div>
        <section class="ftco-section ftco-cart mb-5">
            <div class="container">
                <div id="accordion">
                    <%
                    SimpleDateFormat formatter = new SimpleDateFormat("E,dd MMMM yyyy (hh:mm a)");  
                    for(Orders order : orders){
                    %>
                    <div class="card mb-2 order-row">
                        <div class="card-header" id="heading3">
                            <h5 class="mb-0">
                                <a class="btn d-flex btn-link collapsed" data-toggle="collapse" data-target="#collapse<%=order.getOId() %>" aria-expanded="false" aria-controls="collapse3">
                                    <div class="order-id">Order ID : <%=order.getOId() %></div> 
                                    <div class="order-date">Order Date : <%=formatter.format(order.getOrderDate()) %></div>
                                    <i class="fa fa-plus float-right m-1"></i>
                                </a>
                            </h5>
                        </div>
                                    
                        <div id="collapse<%=order.getOId() %>" class="collapse" aria-labelledby="heading3" data-parent="#accordion">
                            <div class="card-body">
                                <div class="col-md-12 ftco-animate fadeInUp ftco-animated">
                                    <% if(order.getStatus()==0 && role.equals("CUSTOMER")) {%>
                                    <div class="cancel-order mb-3"><a href="#confirm-modal" class="btn cancel-btn px-4 btn-primary" data-toggle="modal" data-backdrop="static" data-keyboard="false">Cancel Order</a></div>
                                    <% }%>
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
                                            
                                            List<OrderDetails> OrdersDetail1 = orderDetailDAO.viewByOrderId(order.getOId());
                                            List<OrderDetails> orderDetail = new ArrayList<OrderDetails>();
                                            int total = 0;
                                            if(role.equals("SHOPKEEPER")){
                                                for(OrderDetails od : OrdersDetail1){
                                                    if(od.getShopkeeper().getSId() == ShopkeeperDAO.viewSingle(email).getSId())
                                                        orderDetail.add(od);

                                                }
                                            } else if(role.equals("CUSTOMER") || role.equals("DELIVERYBOY")){
                                                orderDetail=OrdersDetail1;
                                            }
                                            for(OrderDetails obj : orderDetail) {
                                                total = obj.getAmount()+total;
                                                
                                              
                                            %>
                                                <tr class="text-center">
                                                    <td><%=obj.getId() %></td>
                                                    <td class="product-name"><h3><%=productDAO.viewById(obj.getProducts().getPId()).getName() %></h3><h3>by <%=ShopkeeperDAO.viewSinglebyID(obj.getShopkeeper().getSId()).getShopName() %></h3></td>
                                                    <td><%=obj.getPrice() %></td>
                                                    <td><%=obj.getQuantity() %></td>
                                                    <td><%=obj.getAmount() %></td>
                                                    <% if(obj.equals(orderDetail.get(orderDetail.size()-1))) { %>
                                                    <td rowspan="<%=orderDetail.size() %>"><%=total %></td>
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
        <% if (role.equals("SHOPKEEPER"))%><script src="js/categoryValidation.js"></script>
        <script>
            $(document).on({
                ajaxStart: function(){
                    $("#cover-spin").show(); 
                },
                ajaxStop: function(){ 
                    $("#cover-spin").hide(); 
                }    
            });
            
            $('a.btn-link').click(function () {
                $(this).find('i').toggleClass('fa-plus fa-minus');
                $(this).closest('div.card').siblings().each(function(){
                    if($(this).find('i.fa').hasClass('fa-minus')){
                        $(this).find('i.fa').toggleClass('fa-minus fa-plus');
                    }
                });
            });
            
            $('.cancel-btn').click(function(){
                var tableDiv = $(this).parent().parent().parent().parent();
                var id = tableDiv.attr('id');
                var oId = id.substring(id.lastIndexOf('e') + 1);
                $('.confirm-ok').attr('href',"cancalOrder.jsp?OId=" + oId);
                
                $('.confirm-ok').click(function(e){
                    e.preventDefault();
                    var href = $(this).attr('href');
                    
                    $.ajax({
                        url:href,
                        success:function(){
                            $('#confirm-modal').modal('toggle');
                            tableDiv.parents('.order-row').delay(800).animate({opacity:'0'},1000,function(){
                                tableDiv.parents('.order-row').animate({height:'0px'},1000,function(){
                                    tableDiv.parents('.order-row').remove();
                                });
                            });
                        },
                        error: function (jxhr, text, error) {
                            alert(error);
                        }
                    });
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