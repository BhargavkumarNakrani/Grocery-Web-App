

<%@page import="dao.AccountDAO"%>
<%@page import="dao.ShopkeeperDAO"%>
<%@page import="entity.Shopkeeper"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Shopkeeper obj = new Shopkeeper();
    int id = 0;
    String StringID = request.getParameter("id");
    String fname =""; 
    String lname = "";
    String email = "";
    String password = "";
    String sname = "";
    long contact = 0;
    String address = "";
    String image = "";
    int Aid = 0;
    
    if(StringID != null){
        id = Integer.parseInt(StringID);
        obj = ShopkeeperDAO.viewSinglebyID(id);
        String name =  obj.getName();
        String[] n = name.split(" ", 2);
        fname = n[0];
        lname = n[1];
        email = obj.getEmail();
        Aid = obj.getAccounts().getAcccountId();
        password = AccountDAO.getPassword(Aid);
        image = ShopkeeperDAO.viewImage(id);
        sname = obj.getShopName();
        contact = obj.getPhone();
        address = obj.getAddress();
        //out.println(image);
    }
   
%>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.1/css/bulma.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
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
            padding-top:30px;
            height: 750px;
            margin-bottom: 0px!important;
        }
        .content h3{
            line-height:1.5;
            font-weight:400;
            color:#000;
            margin-bottom: 2rem;
        }
    </style>
    <title>Shop Registration - Vegefoods</title>
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
                  <h3>Shop Registration</h3>
                  </div>
                  <% if(id!=0){ %>
                  <style>
                      .content{height: 900px;}
                  </style>
                  <div class="mb-4">
                      <img src="images/product-1.jpg" style="width:40%" class="img-fluid">
                  </div>
                  <%}%>
                <form action="SingupController.jsp" method="POST" autocomplete="off" enctype="multipart/form-data">
                    <input type="hidden" name="role" value="SHOPKEEPER" id="role">
                    <input type="hidden" name="id" value="<%=id%>" id="id">
                    <input type="hidden" name="accountId" value="<%=Aid%>" id="id">
                    <input type="hidden" name="image" value="<%=image%>" id="id">
                    <div class="row mb-3">
                        <div class="col">
                            <div class="form-group">
                                <label for="fname" class="fname">First Name</label>
                                <input type="text" value="<%=fname%>" name="fname" class="form-control" id="fname" autocomplete="nope">
                            </div>
                            <span id="fname_error_message" class="text-danger"></span>
                        </div>
                        <div class="col">
                            <div class="form-group">
                                <label for="lname">Last Name</label>
                                <input type="text" name="lname" value="<%=lname%>" class="form-control" id="lname" autocomplete="nope">
                            </div>
                            <span id="lname_error_message" class="text-danger"></span>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col">
                            <div class="form-group">
                                <label for="sname">Shop Name</label>
                                <input type="text" name="sname" value="<%=sname%>" class="form-control" id="sname" autocomplete="nope">
                            </div>
                            <span id="sname_error_message" class="text-danger"></span>
                        </div>
                        <div class="col" style="width:50%!important;">
                            <div class="file has-name">
                                <label class="file-label">
                                    <input class="file-input" id="shopimg" type="file" name="shopimg">
                                    <span class="file-cta">
                                        <span class="file-icon">
                                            <i class="fa fa-upload"></i>
                                        </span>
<!--                                        <span class="file-label">
                                            Choose a file…
                                        </span>-->
                                    </span>
                                    <span class="file-name">No file Choosen
                                    </span>
                                </label>
                            </div>
                            <span id="shopimg_error_message" class="text-danger"></span>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col">
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" name="email" value="<%=email%>" class="form-control" id="email" autocomplete="nope">
                            </div>
                            <span id="email_error_message" class="text-danger"></span>
                        </div>
                        <div class="col">
                            <div class="form-group">
                                <label for="contact">Contact Number</label>
                                <input type="number" name="contact" value="<%if(contact!=0){out.print(contact);}%>" class="form-control" id="contact" >
                            </div>
                            <span id="contact_error_message" class="text-danger"></span>
                        </div>
                    </div>
                    <div class="row  mb-3">
                        <div class="col">
                            <div class="form-group">
                                <label for="pswd">Password</label>
                                <input type="password" name="pswd" value="<%=password%>" class="form-control" id="pswd" autocomplete="nope">
                            </div>
                            <span id="pswd_error_message" class="text-danger"></span>
                        </div>
                        <div class="col">
                            <div class="form-group">
                                <label for="cpswd">Confirm Password</label>
                                <input type="password" name="cpswd" value="<%=password%>" class="form-control" id="cpswd" autocomplete="nope">
                            </div>
                            <span id="cpswd_error_message" class="text-danger"></span>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col">
                            <div class="form-group">
                                <label for="Address">Shop Address</label>
                                <input type="text" name="address" value="<%=address%>" class="form-control" id="address" autocomplete="nope">
                            </div>
                            <span id="add_error_message" class="text-danger"></span>
                        </div>
                    </div>
                    
                  <div class="mb-5"></div>
                  <input type="submit" value="Register" id="submit" class="btn btn-primary" style="width:100%">

                </form>
              </div>
            </div>
          </div>          
        </div>
      </div>
    </div>
  </div>
    <script src="js/jquery-3.3.1.min.js" type="text/javascript"></script>
    <script src="js/signup_validation.js"></script>
    <script src="js/floating_label.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script>
        $('#shopimg').on('change',function(){
                //get the file name
                var path = $(this).val();
                //replace the "Choose a file" label
                if (path==null){
                    $('.file-name').html("No file Choosen");
                }else{
                    var fileNameIndex = path.lastIndexOf('\\') + 1;
                    var fileName = path.substr(fileNameIndex);
                    $('.file-name').html(fileName);
                }
            })
    </script>
  </body>
</html>
