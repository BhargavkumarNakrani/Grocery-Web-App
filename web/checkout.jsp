<%@page import="dao.CustomerDAO"%>
<%@page import="entity.Customer"%>
<%@page import="dao.cartDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String email = (String) session.getAttribute("email");
    Customer obj = new Customer();
    int id = 0;
    //String StringID = request.getParameter("id");
    String fname =""; 
    String lname = "";
    long contact = 0;
    String address = "";
    
    if(email != null){
        obj = CustomerDAO.viewByEmail(email);
        String name =  obj.getName();
        String[] n = name.split(" ", 2);
        fname = n[0];
        lname = n[1];
        email = obj.getEmail();
        contact = obj.getPhone();
        address = obj.getAddress();
    }
%>
<html lang="en">
    
    <head>
        <title>Checkout - Vegefoods</title>
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
    </head>
    <%
        if (session.getAttribute("email") == null) {
            String uri = request.getRequestURI();
            String pageName = uri.substring(uri.lastIndexOf("/") + 1);
            response.sendRedirect("login.jsp?return_to=" + pageName);
        }
    %>
    <body class="goto-here">

        <jsp:include page="top_bar.html"/>
        <jsp:include page="menu_bar.jsp"/>

        <div class="hero-wrap hero-bread" style="background-image: url('images/bg.jpg');">
            <div class="container">
                <div class="row no-gutters slider-text align-items-center justify-content-center">
                    <div class="col-md-9 ftco-animate text-center">
                        <p class="breadcrumbs"><span class="mr-2"><a href="index.jsp">Home</a></span> <span>Checkout</span></p>
                        <h1 class="mb-0 bread">Checkout</h1>
                    </div>
                </div>
            </div>
        </div>
        <section class="ftco-section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-xl-7 ftco-animate">
                        <form action="placeOrder.jsp" class="billing-form" method="POST">
                            <h3 class="mb-4 billing-heading">Billing Details</h3>
                            <div class="row align-items-end">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="firstname">First Name</label>
                                        <input type="text" value="<%=fname %>" name="fname" class="form-control" placeholder="">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="lastname">Last Name</label>
                                        <input type="text" value="<%=lname %>" name="lname" class="form-control" placeholder="">
                                    </div>
                                </div>
                                <div class="w-100"></div>
                               
                                <div class="col-md-12">
                                    <div class="form-group">
                                        <label for="address">Address</label>
                                        <textarea name="address" class="form-control" rows="4" placeholder="Enter your full Address"><% if(!address.equals("No Address")){ out.print(address); } %></textarea>
                                    </div>
                                </div>
                                <div class="w-100"></div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="phone">Phone</label>
                                        <input type="number" value="<%if(contact!=0){out.print(contact);}%>" name="contact" class="form-control" placeholder="">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="emailaddress">Email Address</label>
                                        <input type="text" value="<%=email %>" name="email" class="form-control" placeholder="">
                                    </div>
                                </div>
                                <div class="w-100"></div>
<!--                                <div class="col-md-12">
                                    <div class="form-group mt-4">
                                        <div class="radio">
                                            <label class="mr-3"><input type="radio" name="optradio"> Create an Account? </label>
                                            <label><input type="radio" name="optradio"> Ship to different address</label>
                                        </div>
                                    </div>
                                </div>-->
                                <div class="col-md-12">
                                    <div class="cart-detail p-3 p-md-4">
                                        <h3 class="billing-heading mb-4">Payment Method</h3>
                                        <div class="form-group">
                                            <div class="col-md-12">
                                                <div class="radio">
                                                    <label><input type="radio" name="paymentMethod" class="mr-2" disabled> Direct Bank Tranfer(Currently unavailable)</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-md-12">
                                                <div class="radio">
                                                    <label><input type="radio" name="paymentMethod" class="mr-2" disabled> Check Payment(Currently unavailable)</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-md-12">
                                                <div class="radio">
                                                    <label><input type="radio" name="paymentMethod" class="mr-2" disabled> Paypal(Currently unavailable)</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-md-12">
                                                <div class="radio">
                                                    <label><input type="radio" name="paymentMethod" class="mr-2"> Cash on Delivery</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-md-12">
                                                <div class="checkbox">
                                                    <label><input type="checkbox" value="" class="mr-2"> I have read and accept the terms and conditions</label>
                                                </div>
                                            </div>
                                        </div>
                                        <p>
                                            <button type="submit" class="btn btn-primary py-3 px-4">Place an order</button>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <%
                    long subTotal = 0;
                    int Delivery = 0;
                    int Total = 0;
                    int Discount = 0;
                    if (email != null) {
                        subTotal = cartDAO.cartTotal(email);
                        Delivery = subTotal > 99 ? 0 : 10;
                        Discount = Delivery == 10 ? 0 : 10;
                        Total = (int) subTotal + Delivery;
                    }

                %>
                    <div class="col-xl-5">
                        <div class="row mt-5 pt-3">
                            <div class="col-md-12 d-flex mb-5">
                                <div class="cart-detail cart-total p-3 p-md-4">
                                    <h3 class="billing-heading mb-4">Cart Total</h3>
                                    <p class="d-flex">
                                        <span>Subtotal</span>
                                        <span>Rs. <%=subTotal %></span>
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
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&amp;sensor=false"></script>
        <script src="js/google-map.js"></script>
        <script src="js/main.js"></script>
        <script>
            $(document).ready(function () {

                var quantitiy = 0;
                $('.quantity-right-plus').click(function (e) {

                    // Stop acting like a button
                    e.preventDefault();
                    // Get the field name
                    var quantity = parseInt($('#quantity').val());

                    // If is not undefined

                    $('#quantity').val(quantity + 1);


                    // Increment

                });

                $('.quantity-left-minus').click(function (e) {
                    // Stop acting like a button
                    e.preventDefault();
                    // Get the field name
                    var quantity = parseInt($('#quantity').val());

                    // If is not undefined

                    // Increment
                    if (quantity > 0) {
                        $('#quantity').val(quantity - 1);
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