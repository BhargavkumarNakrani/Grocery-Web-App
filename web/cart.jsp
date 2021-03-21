<%@page import="dao.ShopkeeperDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.productDAO"%>
<%@page import="java.util.List"%>
<%@page import="dao.cartDAO"%>
<%@page import="entity.Cart"%>
<%
    
    int CId = 4;
    String email = (String) session.getAttribute("email");
    List<Cart> cart = new ArrayList<Cart>();
    if(session.getAttribute("email")!=null){
        cart = cartDAO.viewCart(email);
    }
    //out.print(cart.get(0).getPrice());
%>



<html lang="en">

<head>
<title>Cart - Vegefoods</title>
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
    .mouse{z-index: 1;}
</style>
</head>
<%
      if(session.getAttribute("email")==null){
          String uri = request.getRequestURI();
          String pageName = uri.substring(uri.lastIndexOf("/") + 1);
          response.sendRedirect("login.jsp?return_to=" + pageName);
      }
%>
<body class="goto-here">
    <jsp:include page="top_bar.html"/>
    <jsp:include page="menu_bar.jsp"/>

    <% if(cart.isEmpty()){ %>
    
    <div class="container-fluid mt-100 mt-5">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body cart">
                        <div class="col-sm-12 empty-cart-cls text-center"> <img src="images/empty-cart.png" width="300" height="300" class="img-fluid mb-5 mt-5 mr-3">
                            <h3><strong>Your Cart is Empty</strong></h3>
                            <a href="shop.jsp" class="btn btn-primary mb-5" style="padding: 10px 10px"data-abc="true">continue shopping</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%}else{%>
    <section class="ftco-section ftco-cart" id="cart-table">
        <div class="container">
            <div class="row">
                <div class="col-md-12 ftco-animate">
                    <div class="cart-list">
                        <table class="table">
                            <thead class="thead-primary">
                                <tr class="text-center">
                                    <th>&nbsp;</th>
                                    <th>&nbsp;</th>
                                    <th>Product name</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <%
                                for (Cart c : cart) {
                            %>
                            <tbody>
                                <tr class="text-center">
                                    <td class="product-remove"><a href="deleteCartItem.jsp?id=<%=c.getId()%>"><span class="ion-ios-close"></span></a></td>
                                    <td class="image-prod"><div class="img"><img class="card-img-top" src="data:image/jpg;base64,<%=productDAO.viewImage(c.getProducts().getPId())%>"  alt="Card image" style="width:100%"></div></td>
                                    <td class="product-name">
                                        <h3><%=productDAO.viewById(c.getProducts().getPId()).getName()%></h3>
                                        <h3>from - <%=ShopkeeperDAO.viewSinglebyID(productDAO.viewById(c.getProducts().getPId()).getShopkeeper().getSId()).getShopName()%></h3>
                                    </td>
                                    <td class="price"><%=c.getPrice()%></td>
                                    <td class="quantity">
                                        <div class="input-group d-flex">
                                            <span class="input-group-btn mr-2">

<!--                <button type="button" class="quantity-left-minus btn" data-type="minus" data-field="" <% //if(c.getQuantity() <= 1){ out.print("disabled");}%> >
        <i class="ion-ios-remove"></i>  
    </button>-->

                                            </span>
                                            <form action="updateCartQuantity.jsp?id=<%=c.getId()%>" method="POST">
                                                <table>
                                                    <tr>
                                                        <td style="border-bottom: 1px solid rgba(0,0,0,0)!important">
                                                            <input type="text" id="quantity" name="quantity" class="form-control input-number" value="<%=c.getQuantity()%>" min="1" required>
                                                        </td>
                                                        <td style="border-bottom: 1px solid rgba(0,0,0,0)!important">
                                                            <span class="input-group-btn ml-2">
                                                                <button type="submit" class="quantity-right-plus btn" data-type="plus" data-field="" <% //if(productDAO.viewById(c.getProducts().getPId()).getQuantity() <= c.getQuantity()){ out.print("disabled");}%> >
                                                                    <i class="ion-ios-refresh"></i>
                                                                </button>
                                                            </span>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </form>
                                        </div>
                                    </td>
                                    <td class="total"><%=c.getPrice() * c.getQuantity()%></td>
                                </tr>
                            </tbody>
                            <% }%>
                        </table>
                    </div>
                </div>
            </div>
            <div class="row justify-content-end">
                <div class="col-lg-4 mt-5 cart-wrap ftco-animate">
                    <div class="cart-total mb-3">
                        <h3>Coupon Code</h3>
                        <p>Enter your coupon code if you have one</p>
                        <form action="#" class="info">
                            <div class="form-group">
                                <label for="">Coupon code</label>
                                <input type="text" class="form-control text-left px-3" placeholder="">
                            </div>
                        </form>
                    </div>
                    <p><a href="checkout.jsp" class="btn btn-primary py-3 px-4">Apply Coupon</a></p>
                </div>
                <div class="col-lg-4 mt-5 cart-wrap ftco-animate">
                    <div class="cart-total mb-3">
                        <h3>Estimate shipping and tax</h3>
                        <p>Enter your destination to get a shipping estimate</p>
                        <form action="#" class="info">
                            <div class="form-group">
                                <label for="">Country</label>
                                <input type="text" class="form-control text-left px-3" placeholder="">
                            </div>
                            <div class="form-group">
                                <label for="country">State/Province</label>
                                <input type="text" class="form-control text-left px-3" placeholder="">
                            </div>
                            <div class="form-group">
                                <label for="country">Zip/Postal Code</label>
                                <input type="text" class="form-control text-left px-3" placeholder="">
                            </div>
                        </form>
                    </div>
                    <p><a href="checkout.jsp" class="btn btn-primary py-3 px-4">Estimate</a></p>
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
                <div class="col-lg-4 mt-5 cart-wrap ftco-animate">
                    <div class="cart-total mb-3">
                        <h3>Cart Totals</h3>
                        <p class="d-flex">
                            <span>Subtotal</span>
                            <span>Rs. <%=subTotal%></span>
                        </p>
                        <p class="d-flex">
                            <span>Delivery</span>
                            <span>RS. 10</span>
                        </p>
                        <p class="d-flex">
                            <span>Discount</span>
                            <span>Rs. -<%=Discount%></span>
                        </p>
                        <hr>
                        <p class="d-flex total-price">
                            <span>Total</span>
                            <span>Rs. <%=Total%></span>
                        </p>
                    </div>
                    <p><a href="checkout.jsp" class="btn btn-primary py-3 px-4">Proceed to Checkout</a></p>
                </div>
            </div>
        </div>
    </section>
    <%}%>
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
<!--<script>
		$(document).ready(function(){
                    
                    
		   $('.quantity-right-plus').click(function(e){
		        
		        // Stop acting like a button
		        e.preventDefault();
		        // Get the field name
		        var quantity = parseInt($('#quantity').val());
		        
		        // If is not undefined
		            if(quantity<5){
                                quantity = quantity + 1;
                                $('#quantity').val(quantity);
                                if(quantity==5){
                                    $('.quantity-right-plus').prop("disabled",true);
                                }else{
                                    $('.quantity-left-minus').prop("disabled",false);
                                }
                            }
		          
		        
		    });

		     $('.quantity-left-minus').click(function(e){
		        // Stop acting like a button
		        e.preventDefault();
		        // Get the field name
		        var quantity = parseInt($('#quantity').val());
		        
		        // If is not undefined
		      
		            // Increment
		            if(quantity>1){
                                quantity = quantity - 1;
                                $('#quantity').val(quantity);
                                if(quantity==1){
                                    $('.quantity-left-minus').prop("disabled",true);
                                }else{
                                    $('.quantity-right-plus').prop("disabled",false);
                                }
                            }
                            
//                        $('.').on('keydown keyup change', function(e){
//                            if ($(this).val() > 5 
//                                    && e.keyCode !== 46 // keycode for delete
//                                    && e.keyCode !== 8 // keycode for backspace
//                                ) {
//                                e.preventDefault();
//                                $(this).val(100);
//                            }
//                        });
		    });
		    
		});
	</script>-->

<script async src="https://www.googletagmanager.com/gtag/js?id=UA-23581568-13"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-23581568-13');
</script>
</body>

</html>
