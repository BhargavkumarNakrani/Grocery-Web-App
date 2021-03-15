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
        @media(max-width:991.98px){
            .content{
                    padding-top:2rem;
            }
        }
    </style>
    <title>Login - Vegefoods</title>
  </head>
  <%
      if(session.getAttribute("email")!=null){
          response.sendRedirect("index.jsp");
      }
  %>
<body class="goto-here">
    
    <jsp:include page="top_bar.html"/>
    <jsp:include page="login_menu_bar.jsp"/>
    
<div class="content" style="background-image: url(images/bg.jpg);}">
    <div class="container">
      <div class="row justify-content-center">
        <!-- <div class="col-md-6 order-md-2"> -->
          <!-- <img src="images/undraw_file_sync_ot38.svg" alt="Image" class="img-fluid"> -->
        <!-- </div> -->
        <div class="col-md-6 contents">
            <%
                String Return_to = request.getParameter("return_to");
                String errorMessage = (String) session.getAttribute("errorMessage");
                String successMessage = (String) session.getAttribute("successMessage");
                
                if (errorMessage!=null){ 
                    out.print("<div class=\"alert alert-danger alert-dismissible fade show\">");
                    out.print("<strong>"+ errorMessage +"</strong>");
                    out.print("<button type=\"button\" class=\"close\" onclick=\"alert_dismiss()\" data-dismiss=\"alert\">&times;</button>");
                    out.print("</div>");
                
                }
                if(successMessage != null){
                    out.print("<div class=\"alert alert-success alert-dismissible fade show\">");
                    out.print("<strong>"+ successMessage +"</strong>");
                    out.print("<button type=\"button\" class=\"close\" onclick=\"alert_dismiss()\" data-dismiss=\"alert\">&times;</button>");
                    out.print("</div>");
                }
            %>
          <div class="row justify-content-center">
            <div class="col-md-12">
              <div class="form-block">
                <div class="mb-4">
                  <h3>Login to <strong>VEGEFOODS</strong></h3>
                </div>
                <form action="LoginController.jsp" method="post" autocomplete="off">
                    <% if (Return_to!=null){%>
                    <input type="hidden" name="return_to" value="<%=Return_to%>">
                    <%}%>
                    <div class="row mb-3">
                        <div class="col">
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" name="email" class="form-control" id="email">
                            </div>
                            <span id="email_error_message" class="text-danger"></span>
                        </div>
                    </div>
                    <div class="row mb-4">
                        <div class="col">
                            <div class="form-group">
                                <label for="pswd">Password</label>
                                <input type="password" name="pswd" class="form-control" id="pswd">
                            </div>
                            <span id="pswd_error_message" class="text-danger"></span>
                        </div>
                    </div>
                  <div class="d-flex mb-5 align-items-center">
                    <span class="ml-auto"><a href="index.jsp" class="forgot-pass">Forgot Password?</a></span> 
                  </div>

                  <input type="submit" value="Log In" id="submit" class="btn btn-primary" style="width:100%">

                </form>
              </div>
            </div>
          </div>
          
        </div>
        
      </div>
    </div>
  </div>
  <%--<jsp:include page="footer.html" />--%>
  <script>
    function alert_dismiss() {
        
        <% session.removeAttribute("errorMessage"); %>
        <% session.removeAttribute("successMessage"); %>
                
    }
</script>
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/login_validation.js"></script>
    <script src="js/floating_label.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>