<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.1/css/bulma.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
    <link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Lora:400,400i,700,700i&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Amatic+SC:400,700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="fonts/icomoon/style.css">
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
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .content{
            background-image: url(images/bg_1.jpg);
            height: 695px;
            margin-bottom: 0px!important;
        }
        .content h3{
            line-height:1.5;
            font-weight:400;
            color:#000;
            margin-bottom: 2rem;
        }
    </style>
    <title>Add Product - Vegefoods</title>
  </head>
<body class="goto-here">
    
    <jsp:include page="top_bar.html"/>
    <%--<jsp:include page="login_menu_bar.jsp"/>--%>
   
<div class="content" style="">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-md-6 contents">
          <div class="row justify-content-center">
            <div class="col-md-12">
              <div class="form-block">
                  <div class="mb-4">
                  <h3>Add Product</h3>
                  </div>
                  <% //if(id!=0){ %>
<!--                      <style>
                          .content{height: 900px;}
                      </style>
                      <div id="div" class="mb-4 preview">
                          <img src="images/product-1.jpg"  style="width:40%;" class="img-fluid">
                      </div>-->
                  <% //}%>
                <form action="" method="post" autocomplete="off" enctype="multipart/form-data">
<!--                    <input type="hidden" name="role" value="SHOPKEEPER" id="role">
                <input type="hidden" name="id" value="<%//=id%>" id="id">
                    <input type="hidden" name="accountId" value="<%//=Aid%>" id="id">
                    <input type="hidden" name="image" value="<%//=image%>" id="id">-->
                    <div class="row mb-3">
                        <div class="col">
                            <div class="form-group">
                                <label for="pname" class="fname">Product Name</label>
                                <input type="text" value="" name="pname" class="form-control" id="pname">
                            </div>
                            <span id="pname_error_message" class="text-danger"></span>
                        </div>
                        <div class="col">
                            <div class="form-group">
                                <select name="category" id="category">
                                    <option value="category">Category</option>
                                    <option value="">ABC</option>
                                    <option value="">DEF</option>
                                    <option value="">GHI</option>
                                    <option value="">JKL</option>
                                </select>
                            </div>
                            <span id="category_error_message" class="text-danger"></span>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col">
                            <div class="form-group">
                                <label for="stock">Available Stock</label>
                                <input type="number" name="stock" value="" class="form-control" id="stock">
                            </div>
                            <span id="stock_error_message" class="text-danger"></span>
                        </div>
                        <div class="col" style="width:50%!important;">
                            <div class="file has-name">
                                <label class="file-label">
                                    <input class="file-input" id="productimg" accept="image/*" type="file" name="productimg">
                                    
                                    <span class="file-cta upload-file">
                                        <span class="file-icon">
                                            <i class="fa fa-upload"></i>
                                        </span>
                                        <span class="file-label">
                                            Product Image
                                        </span>
                                    </span>
                                    <span class="file-name upload-file">No file Choosen
                                    </span>
                                </label>
                            </div>
                            <span id="productimg_error_message" class="text-danger"></span>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col">
                            <div class="form-group">
                                <select name="uom" id="uom">
                                    <option value="uom">Unit Of Measurement</option>
                                    <option value="">ABC</option>
                                    <option value="">DEF</option>
                                    <option value="">GHI</option>
                                    <option value="">JKL</option>
                                </select>
                            </div>
                            <span id="uom_error_message" class="text-danger"></span>
                        </div>
                        <div class="col">
                            <div class="form-group">
                                <label for="price">Price per quantity</label>
                                <input type="number" name="price" value="" class="form-control" id="price" >
                            </div>
                            <span id="price_error_message" class="text-danger"></span>
                        </div>
                    </div>
                  <div class="mb-5"></div>
                  <input type="submit" value="Add" id="submit" class="btn btn-primary" style="width:100%">

                </form>
              </div>
            </div>
          </div>          
        </div>
      </div>
    </div>
  </div>
    <script src="js/jquery-3.3.1.min.js" type="text/javascript"></script>
    <script src="js/productValidation.js"></script>
    <script src="js/floating_label.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>
