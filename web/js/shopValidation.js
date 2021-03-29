$("document").ready(function() {
    
        $("#fname_error_message").hide();
        $("#lname_error_message").hide();
        $("#sname_error_message").hide();
        $("#shopimg_error_message").hide();
        $("#email_error_message").hide();
        $("#contact_error_message").hide();
        $("#pswd_error_message").hide();
        $("#cpswd_error_message").hide();
        $("#add_error_message").hide();

        var error_fname = false;
        var error_lname = false;
        var error_sname = false;
        var error_shopimg = false;
        var error_email = false;
        var error_contact = false;
        var error_pswd = false;
        var error_cpswd = false;
        var error_add = false;
        
        
        $("#fname").keyup(function(){
            check_fname();
         });
        $("#lname").keyup(function() {
            check_lname();
         });
        $("#sname").keyup(function() {
            check_sname();
         });
        $('#shopimg').on('change',function(){
            check_shopimg();
         });
        $("#email").keyup(function() {
            check_email();
         });
        $("#contact").keyup(function() {
            check_contact();
         });
        $("#pswd").keyup(function() {
            check_pswd();
         });
        $("#cpswd").keyup(function() {
            check_cpswd();
         });
        $("#add").keyup(function(){
            check_add();
         });
        
        function check_fname() {
            var pattern = /^[a-zA-Z]*$/;
            var fname = $("#fname").val();
            if (fname===''){
               $("#fname_error_message").html("Enter First Name");
               $("#fname_error_message").show();
               $("#fname").css("border-bottom","2px solid #F90A0A");
               error_fname = true;
            }else{
                if (pattern.test(fname)) {
                    $("#fname_error_message").hide();
                    $("#fname").css("border-bottom","1px solid #82ae41");
                } else {
                    $("#fname_error_message").html("Only Characters is allowed");
                    $("#fname_error_message").show();
                    $("#fname").css("border-bottom","2px solid #F90A0A");
                    error_fname = true;
                }
            }
            
        }

        function check_lname() {
            var pattern = /^[a-zA-Z]*$/;
            var lname = $("#lname").val();
            if (lname===''){
               $("#lname_error_message").html("Enter Last Name");
               $("#lname_error_message").show();
               $("#lname").css("border-bottom","2px solid #F90A0A");
               error_lname = true;
            }else{
                if (pattern.test(lname)) {
                    $("#lname_error_message").hide();
                    $("#lname").css("border-bottom","1px solid #82ae41");
                } else {
                    $("#lname_error_message").html("Only Characters is allowed");
                    $("#lname_error_message").show();
                    $("#lname").css("border-bottom","2px solid #F90A0A");
                    error_lname = true;
                }
            }
        }
        
        function check_sname() {
            var sname = $("#sname").val();
            if (sname===''){
                $("#sname_error_message").html("Enter Product Name");
                $("#sname_error_message").show();
                $("#sname").css("border-bottom","2px solid #F90A0A");
                error_sname = true;
            }else{
                $("#sname_error_message").hide();
                $("#sname").css("border-bottom","1px solid #82ae41");
            }
            
        }

        function check_shopimg(){
            var allowedFiles = [".png", ".jpg", ".jpeg"];
            var fileUpload = $("#shopimg");
            var lblError = $("#shopimg_error_message");
            var regex = new RegExp("([a-zA-Z0-9 ()\s_\\.\-:])+(" + allowedFiles.join('|') + ")$");
            
            if (fileUpload.val()===''){
                if($('div .preview').is(':visible')){
                    error_shopimg = false;
                }else{
                    lblError.html("Upload Image File.");
                    lblError.show();
                    $('.upload-file').addClass("file-hover");
                    error_shopimg = true;
                }
            }else{
                if (!regex.test(fileUpload.val().toLowerCase())) {
                    $('.file-name').html("No file Choosen");
                    lblError.html("Upload image file only.");
                    lblError.show();
                    $('.upload-file').addClass("file-hover");
                    error_shopimg = true;
                }else{
                    lblError.hide();
                    var fileNameIndex = fileUpload.val().lastIndexOf('\\') + 1;
                    var fileName = fileUpload.val().substr(fileNameIndex);
                    $('.file-name').html(fileName);
                    $('.upload-file').removeClass("file-hover");
                    $('.upload-file').addClass("right-file");
                }
            }
        }
        
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
        
        function check_cpswd() {
            var pswd = $("#pswd").val();
            var cpswd = $("#cpswd").val();
            var cpswd_length = cpswd.length;
            if (cpswd_length === 0){
                $("#cpswd_error_message").html("Confirm Your Password");
                $("#cpswd_error_message").show();
                $("#cpswd").css("border-bottom","2px solid #F90A0A");
                error_cpswd = true;
            }else{
                if (pswd !== cpswd) {
                    $("#cpswd_error_message").html("Passwords Did not Matched");
                    $("#cpswd_error_message").show();
                    $("#cpswd").css("border-bottom","2px solid #F90A0A");
                    error_cpswd = true;
                } else {
                    $("#cpswd_error_message").hide();
                    $("#cpswd").css("border-bottom","1px solid #82ae41");
                }
            }
        }

        function check_contact() {
            var pattern = /^[6-9]\d{9}$/;
            var contact = $("#contact").val();
            var contact_length = contact.length;
            if (contact_length === 0){
                $("#contact_error_message").html("Enter Contact Number");
                $("#contact_error_message").show();
                $("#contact").css("border-bottom","2px solid #F90A0A");
                error_contact = true;
            }else{
                if (pattern.test(contact)) {
                    $("#contact_error_message").hide();
                    $("#contact").css("border-bottom","1px solid #82ae41");
                } else {
                    $("#contact_error_message").html("Enter Valid Contact Number");
                    $("#contact_error_message").show();
                    $("#contact").css("border-bottom","2px solid #F90A0A");
                    error_contact = true;
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
        
        function check_add() {
            var add = $("#add").val();
            if (add===''){
               $("#add_error_message").html("Enter Product Name");
               $("#add_error_message").show();
               $("#add").css("border-bottom","2px solid #F90A0A");
               error_sname = true;
            }else{
                    $("#add_error_message").hide();
                    $("#add").css("border-bottom","1px solid #82ae41");
            }
            
        }
        
        $("#submit").click(function(){
            
            error_fname = false;
            error_lname = false;
            error_sname = false;
            error_email = false;
            error_shopimg = false;
            error_pswd = false;
            error_cpswd = false;
            error_contact = false;
            error_add = false;

            check_fname();
            check_lname();
            check_sname();
            check_shopimg();
            check_email();
            check_pswd();
            check_cpswd();
            check_contact();
            check_add();
            
                        
            if (error_fname === false && 
                error_lname === false && 
                error_sname === false && 
                error_shopimg === false && 
                error_pswd === false && 
                error_cpswd === false &&
                error_contact === false &&
                error_add === false) {
//               alert("Registration Successfull");
               return true;
            } else {
//               alert("Please Fill the form Correctly");
               return false;
            }
         });
      });