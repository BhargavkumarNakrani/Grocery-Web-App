<%@page import="dao.ShopkeeperDAO"%>
<%@page import="dao.AccountDAO"%>
<%@page import="dao.DeliveryBoyDAO"%>
<%@page import="entity.DeliveryBoy"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String email = "";//(String) session.getAttribute("email");
    //String role = (String) session.getAttribute("role");
    DeliveryBoy obj = new DeliveryBoy();
    int id = 0;
    String StringID = request.getParameter("id");
    String fname =""; 
    String lname = "";
    String password = "";
    String sname = "";
    long contact = 0;
    String address = "";
    String image = "";
    int Aid = 0;
    
    if(StringID != null && email != null){
        id = Integer.parseInt(StringID);
        obj = DeliveryBoyDAO.viewSinglebyID(id);
        String name =  obj.getName();
        String[] n = name.split(" ", 2);
        fname = n[0];
        lname = n[1];
        email = obj.getEmail();
        Aid = obj.getAccounts().getAcccountId();
        password = AccountDAO.getPassword(Aid);
        //image = ShopkeeperDAO.viewImage(id);
        //sname = obj.getShopName();
        contact = obj.getPhone();
        address = obj.getAddress();
        //role = obj.
        //out.println(image);
    }
%>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
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
            height: 695px;
            margin-bottom: 0px!important;
        }
    </style>
    <title>Employee Registration - Vegefoods</title>
  </head>
<body class="goto-here">
    
    <jsp:include page="top_bar.html"/>
   
<div class="content" style="background-image: url(images/bg.jpg);}">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-md-6 contents">
          <div class="row justify-content-center">
            <div class="col-md-12">
              <div class="form-block">
                  <div class="mb-4">
                  <h3>Employee Registration</h3>
                  </div>
                <form action="SingupController.jsp" method="POST" autocomplete="off">   
                    <div class="row mb-3">
                        <input type="hidden" name="role" value="DELIVERYBOY" id="role">
                    <input type="hidden" name="id" value="<%=id%>" id="id">
                    <input type="hidden" name="accountId" value="<%=Aid%>" id="id">
                        <div class="col">
                            <div class="form-group">
                                <label for="fname" class="fname">First Name</label>
                                <input type="text" name="fname" value="<%=fname%>" class="form-control" id="fname" autocomplete="nope">
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
                                <label for="email">Email</label>
                                <input type="email" name="email" value="<%=email%>" class="form-control" id="email" autocomplete="nope">
                            </div>
                            <span id="email_error_message" class="text-danger"></span>
                        </div>
                        <div class="col">
                            <div class="form-group">
                                <label for="contact">Contact Number</label>
                                <input type="number" value="<% if(contact != 0) out.print(contact); %>" name="contact" class="form-control" id="contact" >
                            </div>
                            <span id="contact_error_message" class="text-danger"></span>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col">
                            <div class="form-group">
                                <label for="pswd">Password</label>
                                <input type="password" name="pswd"  value="<%=password %>" class="form-control" id="pswd" autocomplete="nope">
                            </div>
                            <span id="pswd_error_message" class="text-danger"></span>
                        </div>
                        <div class="col">
                            <div class="form-group">
                                <label for="cpswd">Confirm Password</label>
                                <input type="password" name="cpswd"  value="<%=password %>" class="form-control" id="cpswd" autocomplete="nope">
                            </div>
                            <span id="cpswd_error_message" class="text-danger"></span>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col">
                            <div class="form-group">
                                <label for="Address">Address</label>
                                <input type="text" name="address"  value="<%=address %>" class="form-control" id="address" autocomplete="nope">
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
  </body>
</html>

