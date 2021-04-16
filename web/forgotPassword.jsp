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
    <link rel="stylesheet" href="css/animate.css">
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">
    <link rel="stylesheet" href="css/magnific-popup.css">
    <link rel="stylesheet" href="css/aos.css">
    <link rel="stylesheet" href="css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="css/jquery.timepicker.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        @media(max-width:991.98px){
            .content{
                    padding-top:2rem;
            }
        }
    </style>
    <title>Get Password - Vegefoods</title>
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
        <div class="col-md-6 contents">
          <div class="row justify-content-center">
            <div class="col-md-12">
              <div class="form-block">
                <div class="mb-4">
                  <h3>Get Password - <strong>VEGEFOODS</strong></h3>
                </div>
                  <form action="passwordGenerator.jsp" method="post">
                    <div class="row mb-5">
                        <div class="col">
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" name="email" class="form-control" id="email" autocomplete="off">
                            </div>
                            <span id="email_error_message" class="text-danger"></span>
                        </div>
                    </div>

                  <input type="submit" value="Get Password" id="submit" class="btn btn-primary" style="width:100%">

                </form>
              </div>
            </div>
          </div>
          
        </div>
        
      </div>
    </div>
  </div>
    <script>
        $(document).ready(function(){
            var noError = true;
            function check_email() {
                var pattern = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
                var email = $("#email").val();
                if (email === ''){
                    $("#email_error_message").html("Enter Email Address");
                    $("#email_error_message").show();
                    $("#email").css("border-bottom","2px solid #F90A0A");
                    noError = false;
                }else{
                    if (pattern.test(email)) {
                        $("#email_error_message").hide();
                        $("#email").css("border-bottom","1px solid #82ae41");
                        noError = true;
                    } else {
                        $("#email_error_message").html("Invalid Email");
                        $("#email_error_message").show();
                        $("#email").css("border-bottom","2px solid #F90A0A");
                        noError = false;
                }
             }
             return noError;
            }
            $("#email").keyup(function() {
                check_email();
            });
            $("#submit").click(function(){
                return check_email();
            });
        });
    </script>
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/floating_label.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>