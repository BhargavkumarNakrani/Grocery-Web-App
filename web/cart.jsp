<%@page import="javax.security.sasl.AuthenticationException"%>
<%@page import="dao.ShopkeeperDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.productDAO"%>
<%@page import="java.util.List"%>
<%@page import="dao.cartDAO"%>
<%@page import="entity.Cart"%>
<%
    
    int CId = 4;
    String email = (String) session.getAttribute("email");
    String role = (String) session.getAttribute("role");
    List<Cart> cart = new ArrayList<Cart>();
    if(role == null){
        role = "";
    } else if (!role.equals("CUSTOMER")) {
            throw new AuthenticationException();
    } else if(session.getAttribute("email")!=null){
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
<link rel="stylesheet" href="css/animate.css">
<link rel="stylesheet" href="css/owl.carousel.min.css">
<link rel="stylesheet" href="css/owl.theme.default.min.css">
<link rel="stylesheet" href="css/magnific-popup.css">
<link rel="stylesheet" href="css/aos.css">
<link rel="stylesheet" href="css/bootstrap-datepicker.css">
<link rel="stylesheet" href="css/jquery.timepicker.css">
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
                                    <td class="product-remove"><a href="deleteCartItem.jsp?id=<%=c.getId()%>"><span><i class="fa fa-times"></i></span></a></td>
                                    <td class="image-prod"><div class="img"><img class="card-img-top" src="data:image/jpg;base64,<%=productDAO.viewImage(c.getProducts().getPId())%>"  alt="Card image" style="width:auto;height:100%"></div></td>
                                    <td class="product-name">
                                        <h3><%=productDAO.viewById(c.getProducts().getPId()).getName()%></h3>
                                        <h3>from - <%=ShopkeeperDAO.viewSinglebyID(productDAO.viewById(c.getProducts().getPId()).getShopkeeper().getSId()).getShopName()%></h3>
                                    </td>
                                    <td class="price"><%=c.getPrice()%></td>
                                    <td class="quantity">
                                        <div class="input-group d-flex">
                                            
                                            <span class="input-group-btn mr-2">
                                                <button type="button" class="quantity-left-minus btn" data-type="minus" data-field="">
                                                    <i class="fa fa-minus"></i>  
                                                </button>
                                            </span>
                                            
                                            <span class="product-id" id="<%=c.getId()%>" qty="<%=productDAO.viewById(c.getProducts().getPId()).getQuantity()%>"></span>
                                            <input type="text" id="quantity" name="quantity" class="form-control input-number" value="<%=c.getQuantity()%>" min="1" required>
                                            
                                            <span class="input-group-btn ml-2">
                                                <button type="button" class="quantity-right-plus btn" data-type="plus" data-field="">
                                                    <i class="fa fa-plus"></i>
                                                </button>
                                            </span>
                                            
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
<script src="js/main.js"></script>
<script src="js/searchJS.js"></script>
<% if (role.equals("SHOPKEEPER"))%><script src="js/categoryValidation.js"></script>
<script>
    $(document).ready(function(){
        $('.input-number').attr('disabled',true);
        function cartQuantityUpdate(productId,quantity){
            $.ajax({
                url: "updateCartQuantity.jsp?id=" + productId + "&quantity=" + quantity,
                success: function (response) {
                    var total = $(response).find('#'+productId).parents('.quantity').siblings('.total').text();
                    $('#' +productId).parents('.quantity').siblings('.total').text(total);
                    totalCart(response);
                },
                error:function(error){
                    alert(error);
                }
            });
        }
        function totalCart(response){
            var cartTotal = $(response).find('.cart-total').html();
            $('.cart-total').html(cartTotal);
        }
        $('.product-remove').find('a').on('click',function(e){
            e.preventDefault();
            var href = $(this).attr('href');
            var tbody = $(this).parent().parent().parent();
            $.ajax({
                url:href,
                success:function(response){
                    var cartItem = $(response).find(".cart-item").text();
                    $('.cart-item').text(cartItem);
                    tbody.animate({opacity:'0'},500,function(){
                        tbody.remove();
                    });
                    totalCart(response);
                },
                error: function (error) {
                    alert(error);
                }
            });
        });
        $('.quantity-right-plus').click(function(e){
            e.preventDefault();
            var inputGrp = $(this).parents('.input-group');
            var closestInput = inputGrp.find('.input-number');
            var productId = inputGrp.find('span.product-id').attr('id');
            var quantity = parseInt(closestInput.val());
            var limit =  parseInt(inputGrp.find('span.product-id').attr('qty'));
            limit = limit > 5 ? 5 : limit;
                if(quantity<limit){
                    quantity = quantity + 1;
                    closestInput.val(quantity);
                    cartQuantityUpdate(productId,quantity);
                    if(quantity===limit){
                        $(this).prop("disabled",true).css('opacity','0.6');
                    }else{
                        $(this).parent().parent().find('.quantity-left-minus').prop("disabled",false).css('opacity','1');
                    }
                }
        });

         $('.quantity-left-minus').click(function(e){
            e.preventDefault();
            var inputGrp = $(this).parents('.input-group');
            var closestInput = inputGrp.find('.input-number');
            var productId = inputGrp.find('span.product-id').attr('id');
            var quantity = parseInt(closestInput.val());
                if(quantity>1){
                    quantity = quantity - 1;
                    closestInput.val(quantity);
                    cartQuantityUpdate(productId,quantity);
                    if(quantity===1){
                        $(this).prop("disabled",true).css('opacity','0.6');
                    }else{
                        $(this).parent().parent().find('.quantity-right-plus').prop("disabled",false).css('opacity','1');
                    }
                }
        });
//        $('.input-number').keyup(function(e){
//            if ($(this).val() > 5 
//                    && e.keyCode !== 46 // keycode for delete
//                    && e.keyCode !== 8 // keycode for backspace
//                ) {
//                e.preventDefault();
//            }
//        });
    });
</script>
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-23581568-13"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-23581568-13');
</script>
</body>

</html>
