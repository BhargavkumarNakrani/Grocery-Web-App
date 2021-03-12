<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    .table tbody tr td{cursor: pointer;padding:25px 10px;}
</style>
</head>
<body>
    <jsp:include page="top_bar.html" />
    <jsp:include page="menu_bar.jsp" />
    
    <section class="ftco-section ftco-cart">
        <div class="container">
            <div class="row mb-5 justify-content-start">
                <div class="col-lg-6 cart-wrap ftco-animate fadeInUp ftco-animated">
                    <div class="cart-total mb-3">
                        <h3>Order Details</h3>
                        <p class="d-flex">
                            <span>Order ID</span>
                            <span>12345</span>
                        </p>
                        <p class="d-flex">
                            <span>Customer Name</span>
                            <span>XYZ</span>
                        </p>
                        <p class="d-flex">
                            <span>Shipping Address</span>
                            <span>PQR</span>
                        </p>
                        <h3>Shop Details</h3>
                        <p class="d-flex">
                            <span>Shop-1</span>
                            <span>ABCD</span>
                        </p>
                        <p class="d-flex">
                            <span>Shop-2</span>
                            <span>EFGH</span>
                        </p>
                    </div>
                </div>
            </div>
            <div id="accordion">
                <div class="card mb-2">
                    <div class="card-header" id="headingOne">
                        <h5 class="mb-0">
                            <a class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
                                Shop Name-1
                            <i class="fa fa-plus float-right m-1"></i>
                            </a>
                        </h5>
                    </div>

                    <div id="collapseOne" class="collapse" aria-labelledby="headingOne" data-parent="#accordion">
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
                                                <th>Price</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>500</td>
                                            </tr>
                                            <tr>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card mb-2">
                    <div class="card-header" id="headingTwo">
                        <h5 class="mb-0">
                            <a class="btn btn-link collapsed float-left" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                Shop Name-2
                            <i class="fa fa-plus float-right m-1"></i>
                            </a>
                        </h5>
                    </div>
                    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
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
                                                <th>Price</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>500</td>
                                            </tr>
                                            <tr>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-header" id="headingThree">
                        <h5 class="mb-0">
                            <a class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                Shop Name-3
                            <i class="fa fa-plus float-right m-1"></i>
                            </a>
                        </h5>
                    </div>
                    <div id="collapseThree" class="collapse" aria-labelledby="headingThree" data-parent="#accordion">
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
                                                <th>Price</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td rowspan="3">500</td>
                                            </tr>
                                            <tr>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                            </tr>
                                            <tr>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                                <td>Cell</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
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
    $('[data-toggle="collapse"]').click(function () {
        $(this).find('i').toggleClass('fas fa-plus fas fa-minus'); 
    });
</script>
</body>
</html>