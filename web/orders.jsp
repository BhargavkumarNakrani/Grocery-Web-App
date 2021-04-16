<%@page import="dao.ShopkeeperDAO"%>
<%@page import="entity.Shopkeeper"%>
<%@page import="entity.OrderDetails"%>
<%@page import="dao.orderDetailDAO"%>
<%@page import="dao.DeliveryBoyDAO"%>
<%@page import="entity.DeliveryBoy"%>
<%@page import="dao.CustomerDAO"%>
<%@page import="entity.Customer"%>
<%@page import="dao.ordersDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.Orders"%>
<%@page import="javax.security.sasl.AuthenticationException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String email = (String) session.getAttribute("email");
    String role = (String) session.getAttribute("role");
    
    if(role == null) {
        //throw new AuthenticationException("");
        response.sendRedirect("login.jsp");
        role = "";
    } else if(role.equals("CUSTOMER")){
        throw new AuthenticationException(); 
    }
    
    List<Orders> orders = new ArrayList<Orders>();
    
    if(email != null) {
        orders = ordersDAO.viewAll();
    }
%>
<!DOCTYPE html>
<html lang="en">
<%
    String OrderAssign = (String) session.getAttribute("OrderAssign");
    String orderDelivered = (String) session.getAttribute("orderDelivered");
    if(OrderAssign != null){
                    out.print("<div class=\"alert alert-success alert-dismissible fade show\">");
                    out.print("<strong>"+ OrderAssign +"</strong>");
                    out.print("<button type=\"button\" class=\"close\" onclick=\"alert_dismiss()\" data-dismiss=\"alert\">&times;</button>");
                    out.print("</div>");
    } else if(orderDelivered != null){
        out.print("<div class=\"alert alert-success alert-dismissible fade show\">");
                    out.print("<strong>"+ orderDelivered +"</strong>");
                    out.print("<button type=\"button\" class=\"close\" onclick=\"alert_dismiss()\" data-dismiss=\"alert\">&times;</button>");
                    out.print("</div>");
    }
%>
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
            td{color:black;}
        </style>
    </head>
    <body class="goto-here">
        <jsp:include page="top_bar.html"/>
        <jsp:include page="menu_bar.jsp"/>
        
        <section class="ftco-section ftco-cart mb-5">
            <div class="container">
                <div class="row">
                    <div class="col-md-12 ftco-animate">
                        <div class="cart-list">
                            <table class="table">
                                <thead class="thead-primary">
                                    <tr class="text-center">
                                        <th>Order Id</th>
                                        <th>Customer Name</th>
                                        <th>Phone</th>
                                        <th>Address</th>
                                        <th>Amount</th>
                                        <th>Date</th>
                                        <th>Status</th>
                                        <% if(role.equals("SHOPKEEPER") || role.equals("ADMIN")){%>
                                        <th>Delivery Boy Name</th> <% } else { %>
                                        <th>Action</th>
                                        <% }%>
                                        
                                    </tr>
                                </thead>
                                <%
                                for(Orders obj : orders)
                                {
                                    if(role.equals("SHOPKEEPER")) {
                                        List<OrderDetails> OrderDetails= orderDetailDAO.viewByOrderId(obj.getOId());
                                        int count = 0;
                                        for (OrderDetails od : OrderDetails) {
                                            if (ShopkeeperDAO.viewSinglebyID(od.getShopkeeper().getSId()).getEmail().equalsIgnoreCase(email)) {
                                                count++;
                                                break;
                                            }
                                        }
                                        if (count == 0) {
                                            continue;
                                        }
                                    }
                                    
                                    Customer customer = CustomerDAO.viewById(obj.getCustomer().getCId());
                                    DeliveryBoy db = new DeliveryBoy();
                                    if(!ordersDAO.checkDB(obj.getOId())) {
                                        db = DeliveryBoyDAO.viewSinglebyID(obj.getDeliveryBoy().getDbId());
                                    }
                                %>
                                <tbody>
                                    <tr class="text-center">
                                        <td><%=obj.getOId() %></td>
                                        <td><%=customer.getName() %></td>
                                        <td><%=customer.getPhone() %></td>
                                        <td style="width:20%;"><%=obj.getAddress() %></td>
                                        <td><%=obj.getAmount() %></td>
                                        <td><%=obj.getOrderDate() %></td>
                                        <td><%
                                            if(obj.getStatus()==0){
                                                out.print("Pending");
                                            } else if(obj.getStatus()==1){
                                                out.print("Assign");
                                            }
                                            %>
                                        </td>
                                        <% if(role.equals("DELIVERYBOY")) {%>
                                        <td><%
                                                if(ordersDAO.checkDB(obj.getOId()) && role.equals("DELIVERYBOY")){
                                                    %>
                                                    <a class="btn btn-primary" href="updateOrders.jsp?Oid=<%=obj.getOId() %>">Take order</a>
                                            <%
                                                } else if(ordersDAO.checkDB(obj.getOId(),email)){ %>
                                                <a href="orderDetails.jsp?o_id=<%=obj.getOId() %>">view</a>
                                                <% } else{
                                                    out.print("This order taken by</br> "+db.getName());
                                                }
                                            %>
                                        </td>
                                        <% } else { %>
                                        <td><%
                                                if(!ordersDAO.checkDB(obj.getOId()) && role.equals("SHOPKEEPER")){
                                                    out.print("This order taken by "+db.getName()+"</br><a href=\"orderDetails.jsp?o_id="+obj.getOId()+"\">View</a>");
                                                }
                                            %>
                                            
                                        </td>
                                        <% }%>
                                        
                                    </tr>
                                </tbody>
                                <% }%>
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
        <script src="js/google-map.js"></script>
        <script src="js/main.js"></script>
        <script src="js/searchJS.js"></script>
        <% if (role.equals("SHOPKEEPER"))%><script src="js/categoryValidation.js"></script>

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

<script>
    function alert_dismiss() {
        
        <%  session.removeAttribute("OrderAssign"); 
            session.removeAttribute("orderDelivered"); 
         %>
                 
    }
</script>
