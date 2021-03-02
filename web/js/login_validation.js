$("document").ready(function() {
    
        $("#email_error_message").hide();
        $("#pswd_error_message").hide();

        var error_email = false;
        var error_pswd = false;
        
        
        $("#email").focusout(function() {
            check_email();
         });
        $("#pswd").focusout(function() {
            check_pswd();
         });
         
        
        function check_pswd() {
            var pswd_length = $("#pswd").val().length;
            if (pswd_length === 0){
                $("#pswd_error_message").html("Enter Strong Password");
                $("#pswd_error_message").show();
                $("#pswd").css("border-bottom","2px solid #F90A0A");
                error_pswd = true;
            }else{
                if (pswd_length < 8) {
                    $("#pswd_error_message").html("Atleast 8 Characters required");
                    $("#pswd_error_message").show();
                    $("#pswd").css("border-bottom","2px solid #F90A0A");
                    error_pswd = true;
                } else {
                    $("#pswd_error_message").hide();
                    $("#pswd").css("border-bottom","1px solid #82ae41");
                }
            }
        }
               
        function check_email() {
            var pattern = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
            var email = $("#email").val();
            if (email === ''){
                $("#email_error_message").html("Enter Email Address");
                $("#email_error_message").show();
                $("#email").css("border-bottom","2px solid #F90A0A");
                error_email = true;
            }else{
                if (pattern.test(email)) {
                    $("#email_error_message").hide();
                    $("#email").css("border-bottom","1px solid #82ae41");
                } else {
                    $("#email_error_message").html("Invalid Email");
                    $("#email_error_message").show();
                    $("#email").css("border-bottom","2px solid #F90A0A");
                    error_email = true;
            }
         }
        }

        $("#submit").click(function(){
            
            error_email = false;
            error_pswd = false;

            check_email();
            check_pswd();

            if (error_email === false && error_pswd === false) {
//               alert("Registration Successfull");
               return true;
            } else {
//               alert("Please Fill the form Correctly");
               return false;
            }
         });
      });