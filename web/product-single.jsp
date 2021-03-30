<%@page import="java.net.URL"%>
<%@page import="dao.cartDAO"%>
<%@page import="dao.uomDAO"%>
<%@page import="dao.ShopkeeperDAO"%>
<%@page import="entity.Products"%>
<%@page import="dao.productDAO"%>
<html lang="en">
    <%
        String productID = request.getParameter("productId");
        String email = (String) session.getAttribute("email");
        String role = (String) session.getAttribute("role");
        if(role==null){role="";}
        int PId = 0;
        Products product = new Products();
        if (productID == null) {
            session.setAttribute("product-single", "Please select product first");
            response.sendRedirect("shop.jsp");
        } else {
            PId = Integer.parseInt(productID);
            product = productDAO.viewById(PId);
        }
        if(productID != null){
    %>
    <head>
        <title>Vegefoods - Free Bootstrap 4 Template by Colorlib</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
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
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
    </head>
    <body class="goto-here">

        <jsp:include page="top_bar.html"/>
        <jsp:include page="menu_bar.jsp"/>

        <%
            String cartMessage = (String) session.getAttribute("cartMessage");
            if (cartMessage != null) {
                out.print("<div class=\"alert alert-success alert-dismissible fade show\">");
                out.print("<strong>" + cartMessage + "</strong><a href=\"cart.jsp\">this</a>");
                out.print("<button type=\"button\" class=\"close\" onclick=\"alert_dismiss()\" data-dismiss=\"alert\">&times;</button>");
                out.print("</div>");
            }
        %>
        <section class="ftco-section">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 mb-5 ftco-animate">
                        <% if(productID != null) {%>
                        <a href="data:image/jpg;base64,<%=productDAO.viewImage(product.getPId())%>" class="image-popup"><img src="data:image/jpg;base64,<%=productDAO.viewImage(product.getPId())%>" class="img-fluid" alt="Colorlib Template"></a>
                        <% }%>
                    </div>
                    <div class="col-lg-6 product-details pl-md-5 ftco-animate">
                        <h3><strong><%=product.getName()%></strong></h3>
                        <h5>by <%=ShopkeeperDAO.viewSinglebyID(product.getShopkeeper().getSId()).getShopName()%></h5>
                        <!--<div class="rating d-flex">
                        <p class="text-left mr-4">
                        <a href="#" class="mr-2">5.0</a>
                        <a href="#"><span class="ion-ios-star-outline"></span></a>
                        <a href="#"><span class="ion-ios-star-outline"></span></a>
                        <a href="#"><span class="ion-ios-star-outline"></span></a>
                        <a href="#"><span class="ion-ios-star-outline"></span></a>
                        <a href="#"><span class="ion-ios-star-outline"></span></a>
                        </p>
                        <p class="text-left mr-4">
                        <a href="#" class="mr-2" style="color: #000;">100 <span style="color: #bbb;">Rating</span></a>
                        </p>
                        <p class="text-left">
                        <a href="#" class="mr-2" style="color: #000;">500 <span style="color: #bbb;">Sold</span></a>
                        </p>
                        </div>-->

                        <p class="price"><span>&#8360; <%=product.getPrice()%></span></p>
                        <!--<p>A small river named Duden flows by their place and supplies it with the necessary regelialia. It is a paradisematic country, in which roasted parts of sentences fly into your mouth. Text should turn around and return to its own, safe country. But nothing the copy said could convince her and so it didn’t take long until.
                        </p>-->
                        <form>
                            <div class="row mt-4">
                                <!--<div class="col-md-6">
                                <div class="form-group d-flex">
                                <div class="select-wrap">
                                <div class="icon"><span class="ion-ios-arrow-down"></span></div>
                                <select name="" id="" class="form-control">
                                <option value="">Small</option>
                                <option value="">Medium</option>
                                <option value="">Large</option>
                                <option value="">Extra Large</option>
                                </select>
                                </div>
                                </div>
                                </div>-->
                                <div class="w-100"></div>
                                <% if(role.equals("CUSTOMER")){
                                    if(cartDAO.checkCartByProductId(PId, email) <= 0 ){ %>
                                    <div class="input-group col-md-6 d-flex mb-3">
                                    <span class="input-group-btn mr-2">
                                        <button type="button" class="quantity-left-minus btn" data-type="minus" data-field="" >
                                            <i class="ion-ios-remove"></i>
                                        </button>
                                    </span>
                                    <input type="text" id="quantity" name="quantity" class="form-control input-number" value="1" min="1" max="100">
                                    <span class="input-group-btn ml-2">
                                        <button type="button" class="quantity-right-plus btn" data-type="plus" data-field="" >
                                            <i class="ion-ios-add"></i>
                                        </button>
                                    </span>
                                </div>                               
                            <% } else{ %>
                            <div class="col-md-6 d-flex mb-3">
                                <p><i>Product already into the cart</i></p>
                            </div>
                            <% }}%>
                                
                                <div class="w-100"></div>
                                <div class="col-md-12">
                                    <p style="color: #000;"><%=product.getQuantity()%> <%=uomDAO.getName(product.getUom().getUomId())%> available</p>
                                </div>
                            </div>
                            <% if(role.equals("CUSTOMER") || role.equals("")){%>
                            <% if(cartDAO.checkCartByProductId(PId, email) > 0 ){ %>
                                    <p><a type="submit" href="cart.jsp" class="btn btn-black py-3 px-5">Go to Cart</a></p>                               
                            <% } else {%>
                            <p><a type="submit" href="addToCart.jsp?productId=<%=product.getPId()%>" class="btn btn-primary py-3 px-5">Add to Cart</a></p>
                            <% }}else if(role.equals("SHOPKEEPER")){%>
                            <p><a type="submit" href="addProduct.jsp?productId=<%=product.getPId()%>" class="btn btn-primary py-3 px-5">Edit Product</a></p>
                            <%}%>
                        </form>

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
<% }%>
</html>    
<script>
    function alert_dismiss() {

    <%
        session.removeAttribute("cartMessage");
        //session.removeAttribute("product-single");
    %>

    }
</script>
<script src="js/jquery-3.2.1.min.js"></script>