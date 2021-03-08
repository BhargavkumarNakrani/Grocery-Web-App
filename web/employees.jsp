<html lang="en">

<head>
<title>Employees - Vegefoods</title>
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
<script src="https://kit.fontawesome.com/d628db03e1.js" crossorigin="anonymous"></script>
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


    <div class="hero-wrap hero-bread" style="background-image: url('images/bg_1.jpg');">
        <div class="container">
            <div class="row no-gutters slider-text align-items-center justify-content-center">
                <div class="col-md-9 ftco-animate text-center">
                    <p class="breadcrumbs"><span class="mr-2"><a href="index.jsp">Home</a></span> <span>Employees Details</span></p>
                    <h1 class="mb-0 bread">Employees Details</h1>
                </div>
            </div>
        </div>
    </div>
    <section class="ftco-section ftco-cart">
        <div class="container">
            <div class="row">
                <div class="col-md-12 ftco-animate">
                    <div class="cart-list">
                        <table class="table">
                            <thead class="thead-primary">
                                <tr class="text-center">
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Phone</th>
                                    <th>Email</th>
                                    <th>Salary</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="text-center">
                                    <td class="emp"><h3>ID</h3></td>
                                    <td class="emp"><h3>Hiren Patel</h3></td>
                                    <td class="emp"><h3>7894561230</h3></td>
                                    <td class="emp"><h3>hirenpateluhfsuhcj@hvdv.dfc</h3></td>
                                    <td class="emp"><h3>15000</h3></td>
                                    <td class="action">
                                        <div class="bottom-area d-flex px-3">
                                            <div class="m-auto d-flex">
                                                <a href="#" class="add-to-cart d-flex justify-content-center align-items-center text-center">
                                                    <span><i class="fas fa-pencil-alt"></i></span>
                                                </a>
                                                <a href="#" class="buy-now d-flex justify-content-center align-items-center mx-1">
                                                    <span><i class="fas fa-trash-alt"></i></span>
                                                </a>
                                                <a href="#" class="heart d-flex justify-content-center align-items-center ">
                                                    <span><i class="fa fa-bars"></i></span>
                                                </a>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="text-center">
                                    <td class="emp"><h3>ID</h3></td>
                                    <td class="emp"><h3>Hiren Patel</h3></td>
                                    <td class="emp"><h3>7894561230</h3></td>
                                    <td class="emp"><h3>hirenpateluhfsuhcj@hvdv.dfc</h3></td>
                                    <td class="emp"><h3>15000</h3></td>
                                    <td class="action">
                                        <div class="bottom-area d-flex px-3">
                                            <div class="m-auto d-flex">
                                                <a href="#" class="add-to-cart d-flex justify-content-center align-items-center text-center">
                                                    <span><i class="fas fa-pencil-alt"></i></span>
                                                </a>
                                                <a href="#" class="buy-now d-flex justify-content-center align-items-center mx-1">
                                                    <span><i class="fas fa-trash-alt"></i></span>
                                                </a>
                                                <a href="#" class="heart d-flex justify-content-center align-items-center ">
                                                    <span><i class="fa fa-bars"></i></span>
                                                </a>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
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