<%@page import="dao.AccountDAO"%>
<%@page import="javax.security.sasl.AuthenticationException"%>
<%@page import="entity.Customer"%>
<%@page import="dao.CustomerDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="en">
    <%
        String sEmail = (String)session.getAttribute("email");
        String role = (String) session.getAttribute("role");
        //String action = request.getParameter("action");
        int id = 0;
        int AId = 0;
        if(sEmail==null){sEmail="";}
        if(role==null){role="";}
//        if(action==null){action="";}
//        if(role!="CUSTOMER"){throw new AuthenticationException(); }

    %>
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
    <link rel="stylesheet" href="css/style.css">
    <style>
        @media(max-width:991.98px){.content{padding-top:2rem;}}
    </style>
    <title>Signup - Vegefoods</title>
  </head>
  <%
        String fname = "";
        String lname = "";
        String email = "";
        String address = "";
        String password = "";
        long contact = 0;
  %>
  
  <%if(sEmail!=""){
                    
        Customer customer = CustomerDAO.viewByEmail(sEmail);
        String name =  customer.getName();
        String[] n = name.split(" ", 2);
        fname = n[0];
        lname = n[1];
        email = customer.getEmail();
        contact = customer.getPhone();
        address = customer.getAddress();
        AId = customer.getAccounts().getAcccountId();
        password = AccountDAO.getPassword(AId);
        id = customer.getCId();
  %>
  <style>
      .content{height:695px;}
  </style>
  <%}%>
<body class="goto-here">
    
    <jsp:include page="top_bar.html"/>
    <%if(sEmail==""){%>
    <jsp:include page="login_menu_bar.jsp"/> 
    <%}else{%>
    <jsp:include page="menu_bar.jsp"/>   
    <%}%>
   
<div class="content" style="background-image: url(images/bg.jpg);}">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-md-9 col-lg-6 contents">
          <div class="row justify-content-center">
            <div class="col-md-12">
              <div class="form-block">
                  <div class="row">
                      <%if(sEmail==""){%>
                      <div class="mb-4">
                          <h3>Signup to <strong>VEGEFOODS</strong></h3>
                      </div>
                      <%}else{%>
                      <div class="col-7 mb-4">
                          <h3>Profile</h3>
                      </div>
                      <div class="col-4">
                          <button class="btn btn-primary editProfile">Edit Profile</button>
                      </div>
                      <%}%>
                  </div>
                <form action="SingupController.jsp" method="GET" autocomplete="off">  
                    <input type="hidden" name="id" value="<%=id%>" id="id">
                    <input type="hidden" name="accountId" value="<%=AId%>" id="id">
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
                                <input type="text" value="<%=lname%>" name="lname" class="form-control" id="lname" autocomplete="nope">
                            </div>
                            <span id="lname_error_message" class="text-danger"></span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" value="<%=email%>" name="email" class="form-control" id="email" autocomplete="nope">
                            </div>
                            <span id="email_error_message" class="text-danger"></span>
                        </div>
                        <div class="col">
                            <div class="form-group">
                                <label for="contact">Contact Number</label>
                                <input type="number" value="<%if(contact!=0){out.print(contact);}%>" name="contact" class="form-control" id="contact" >
                            </div>
                            <span id="contact_error_message" class="text-danger"></span>
                        </div>
                    </div>
                    <%if(sEmail!=""){%>
                    <div class="d-flex mt-2 align-items-center">
                        <label class="control control--checkbox mb-0"><span class="caption">Change Password</span>
                            <input type="checkbox" id="ckbox" class="form-check-input" style="display:none">
                            <div class="control__indicator"></div>
                        </label>
                    </div>
                    <%}%>
                    <div class="row mt-4">
                        <div class="col">
                            <div class="form-group">
                                <label for="pswd">Password</label>
                                <input type="password" value="<%=password%>" name="pswd" class="form-control" id="pswd" autocomplete="nope">
                            </div>
                            <span id="pswd_error_message" class="text-danger"></span>
                        </div>
                        <div class="col">
                            <div class="form-group">
                                <label for="cpswd">Confirm Password</label>
                                <input type="password" value="<%=password%>" name="cpswd" class="form-control" id="cpswd" autocomplete="nope">
                            </div>
                            <span id="cpswd_error_message" class="text-danger"></span>
                        </div>
                    </div>
                    <% if(sEmail!=""){%>
                    <div class="mb-3"></div>
                    <div class="row">
                        <div class="col">
                            <div class="form-group">
                                <label for="Address">Address</label>
                                <input type="text" name="address" value="<%=address%>" class="form-control" id="address" autocomplete="nope">
                            </div>
                            <span id="add_error_message" class="text-danger"></span>
                        </div>
                    </div>
                    <%}%>
                  <div class="mb-5"></div>
                  <input type="submit"
                         value="<%if (sEmail!="") {%>Save<%} else if(sEmail=="") {%>Register<%}%>" id="submit" class="btn btn-primary" style="width:100%">
                </form>
              </div>
            </div>
          </div>          
        </div>
      </div>
    </div>
  </div>
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/signup_validation.js"></script>
    <script src="js/floating_label.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
  <script>
  </script>
  <script>
    <% if(sEmail!=""){%>
        $('input').each(function(){
            var value = $(this).attr('value');
            if (value!=null && value!=""){
                $(this).siblings('label').css('margin-top','-25px');
            }
        });
        $('input').on('input',function(){
                if(!$(this).val()){
                    $(this).siblings('label').removeAttr("style");
                }
        });
        $('input').not(':checkbox').prop("disabled",true).css('opacity','0.6');
        $('.editProfile').click(function(){
            $(this).text($(this).text()== "Edit Profile" ? "Cancel" : "Edit profile");
//            $(this).text('Cancel');
            $('input').not(':checkbox , :password').prop("disabled",function(){
                if($(this).is(':disabled')){
                    $(this).css('opacity','1');
                    return false;
                }else{
                    $(this).css('opacity','0.6');
                    return true;
                }
            });
        });
        $('input[type="checkbox"]').click(function(){
            if($(this).is(':checked')){
                $('input[type="password"]').prop('disabled',false).css('opacity','1');
                $('input[type="submit"]').prop('disabled',false).css('opacity','1');
            }else{
                $('input[type="password"]').prop('disabled',true).css('opacity','0.6');
                $('input[type="submit"]').prop('disabled',true).css('opacity','0.6');
            }
        });
    <%}%>
  </script>
</html>
