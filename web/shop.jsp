<%@page import="java.util.ArrayList"%>
<%@page import="entity.Products"%>
<%@page import="java.util.List"%>
<%@page import="dao.productDAO"%>

<%
    
    int i = (int) productDAO.getCount();
    int pages = i / 12;
    String s_page = request.getParameter("page");
    int p = 1;
    
    if (s_page != null) {
        p = Integer.parseInt(s_page);            
    }
    int Start = (p*12)-12;
  
    String role = (String) session.getAttribute("role");
    List<Products> products = new ArrayList<Products>();
    
    String StringID = request.getParameter("id");
    int shop_id = 0;
    if(role == null){
        String uri = request.getRequestURI();
        String pageName = uri.substring(uri.lastIndexOf("/") + 1);
        response.sendRedirect("login.jsp?return_to=" + pageName);
    }
    else if(!role.equalsIgnoreCase("SHOPKEEPER")){
        if(StringID != null){
            shop_id = Integer.parseInt(StringID);
            products = productDAO.viewByShopId(shop_id, Start);
        }
        else {
            products = productDAO.viewAll(Start);
        }
    }
    else {
       String email = (String)session.getAttribute("email");
       products = productDAO.viewByShopEmail(email,Start);
    }
    
%>
<html lang="en">

<head>
<title>Shop - Vegefoods</title>
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
<script src="https://kit.fontawesome.com/d628db03e1.js" crossorigin="anonymous"></script>
</head>
<%
      if(session.getAttribute("email")==null){
          String uri = request.getRequestURI();
          String pageName = uri.substring(uri.lastIndexOf("/") + 1);
          //response.sendRedirect("login.jsp?return_to=" + pageName);
      }
  %>
<body class="goto-here">
    
    <jsp:include page="top_bar.html"/>
    <jsp:include page="menu_bar.jsp"/>
    
    <div class="hero-wrap hero-bread" style="background-image: url('images/bg_1.jpg');">
        <div class="container">
            <div class="row no-gutters slider-text align-items-center justify-content-center">
                <div class="col-md-9 ftco-animate text-center">
                    <p class="breadcrumbs"><span class="mr-2"><a href="index.jsp">Home</a></span> <span>Products</span></p>
                    <h1 class="mb-0 bread">Products</h1>
                </div>
            </div>
        </div>
    </div>
    <section class="ftco-section">
        <div class="container">
<!--            <div class="row justify-content-center">
                <div class="col-md-10 mb-5 text-center">
                    <ul class="product-category">
                        <li><a href="#" class="active">All</a></li>
                        <li><a href="#">Vegetables</a></li>
                        <li><a href="#">Fruits</a></li>
                        <li><a href="#">Juice</a></li>
                        <li><a href="#">Dried</a></li>
                    </ul>
                </div>
            </div>-->
            <div class="row">
<%
    for(Products product : products) {
%>
                <div class="col-md-6 col-lg-3 ftco-animate" id="delete">
                    <div class="product">
                        <a href="#" class="img-prod"><img class="img-fluid" src="data:image/jpg;base64,<%=productDAO.viewImage(product.getPId())%>">
                            <div class="overlay"></div>
                        </a>
                        <div class="text py-3 pb-4 px-3 text-center">
                            <h3><a href="#"><%=product.getName()%></a></h3>
                            <div class="d-flex">
                                <div class="pricing">
                                    <p class="price"><span><%=product.getPrice()%></span></p>
                                </div>
                            </div>
                            <%
                            if(role.equalsIgnoreCase("CUSTOMER") || role.equalsIgnoreCase("DELIVERYBOY")){
                            %>
                            <div class="bottom-area d-flex px-3">
                                <div class="m-auto d-flex">
                                    <a href="?productId=<%=product.getPId()%>" class="add-to-cart d-flex justify-content-center align-items-center text-center">
                                        <span><i class="fa fa-bars"></i></span>
                                    </a>
                                        <a href="?productId=<%=product.getPId()%>" class="buy-now d-flex justify-content-center align-items-center mx-1">
                                        <span><i class="fa fa-shopping-cart"></i></span>
                                    </a>
                                </div>
                            </div>
                            <% } else if(role.equalsIgnoreCase("SHOPKEEPER")){                          
                            %>
                            <div class="bottom-area d-flex px-3">
                                <div class="m-auto d-flex">
                                    <a href="?productId=<%=product.getPId()%>" class="add-to-cart d-flex justify-content-center align-items-center text-center">
                                        <span><i class="fas fa-pencil-alt"></i></span>
                                    </a>
                                    <a href="deleteProduct?productId=<%=product.getPId()%>" class="buy-now d-flex justify-content-center align-items-center mx-1">
                                        <span><i class="fas fa-trash-alt"></i></span>
                                    </a>
                                    <a href="?productId=<%=product.getPId()%>" class="heart d-flex justify-content-center align-items-center ">
                                        <span><i class="fa fa-bars"></i></span>
                                    </a>
                                </div>
                            </div>
                            <% }%>
                        </div>
                    </div>
                </div>
                        <% }%>
            </div>

            <div class="row mt-5">
                <div class="col text-center">
                    <div class="block-27">
                        <ul>
                            <% if (p > 1) {%>
                            <li><a href="<%="?page=" + (p - 1)%>">&lt;</a></li>
                                <% } %>
                                <%for (i = 0; i < pages; i++) { %>
                            <li <% if (p == (i + 1)) {%> class="active" <% }%>><a href="?page=<%=i + 1%>"><%=i + 1%></a></li>
                                <% }
                                    if (p < pages) {
                                %>
                            <li><a href="<%="?page=" + (p + 1)%>">&gt;</a></li>
                                <% }%>
                        </ul>
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

<script async src="https://www.googletagmanager.com/gtag/js?id=UA-23581568-13"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  
  gtag('config', 'UA-23581568-13');
</script>
</body>

</html>
