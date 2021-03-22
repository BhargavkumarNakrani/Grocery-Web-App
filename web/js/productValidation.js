$("document").ready(function() {
    
        $("#pname_error_message").hide();
        $("#category_error_message").hide();
        $("#stock_error_message").hide();
        $("#productimg_error_message").hide();
        $("#uom_error_message").hide();
        $("#price_error_message").hide();

        var error_pname = false;
        var error_category = false;
        var error_stock = false;
        var error_productimg = false;
        var error_uom = false;
        var error_price = false;
        
        
        $("#pname").focusout(function() {
            check_pname();
         });
        $("#category").change(function() {
            check_category();
         });
        $("#stock").focusout(function() {
            check_stock();
         });
        $('#productimg').on('change',function(){
            check_productimg();
         });
        $("#uom").change(function() {
            check_uom();
         });
        $("#price").focusout(function() {
            check_price();
         });
        
        function check_pname() {
            var pname = $("#pname").val();
            if (pname===''){
               $("#pname_error_message").html("Enter Product Name");
               $("#pname_error_message").show();
               $("#pname").css("border-bottom","2px solid #F90A0A");
               error_pname = true;
            }else{
                    $("#pname_error_message").hide();
                    $("#pname").css("border-bottom","1px solid #82ae41");
            }
            
        }
        
        function check_category() {
            var category = $("#category").val();
            if (category === 'category'){
                $("#category_error_message").html("Select Product Category");
                $("#category_error_message").show();
                $("#category").css("border-bottom","2px solid #F90A0A");
                error_stock = true;
            }else{
                $("#category_error_message").hide();
                $("#category").css("border-bottom","1px solid #82ae41");
            }
         
        }
        
        function check_stock() {
            var stock = $("#stock").val();
            if (stock === ''){
                $("#stock_error_message").html("Enter Available Stock");
                $("#stock_error_message").show();
                $("#stock").css("border-bottom","2px solid #F90A0A");
                error_stock = true;
            }else{
                $("#stock_error_message").hide();
                $("#stock").css("border-bottom","1px solid #82ae41");
            }
         
        }

        function check_productimg(){
            var allowedFiles = [".png", ".jpg", ".jpeg"];
            var fileUpload = $("#productimg");
            var lblError = $("#productimg_error_message");
            var regex = new RegExp("([a-zA-Z0-9 ()\s_\\.\-:])+(" + allowedFiles.join('|') + ")$");
            
            if (fileUpload.val()===''){
                if($('div').is(".preview")){
                    error_productimg = false;
                }else{
                    lblError.html("Upload Image File.");
                    lblError.show();
                    $('.upload-file').addClass("file-hover");
                    error_productimg = true;
                }
            }else{
                if (!regex.test(fileUpload.val().toLowerCase())) {
                    $('.file-name').html("No file Choosen");
                    lblError.html("Upload image file only.");
                    lblError.show();
                    $('.upload-file').addClass("file-hover");
                    error_productimg = true;
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
        function check_uom() {
            var uom = $("#uom").val();
            if (uom === 'uom'){
                $("#uom_error_message").html("Select Unit of Measurement");
                $("#uom_error_message").show();
                $("#uom").css("border-bottom","2px solid #F90A0A");
                error_stock = true;
            }else{
                $("#uom_error_message").hide();
                $("#uom").css("border-bottom","1px solid #82ae41");
            }
         
        }
        
        function check_price() {
            var price = $("#price").val();
            if (price === ''){
                $("#price_error_message").html("Enter Product Price");
                $("#price_error_message").show();
                $("#price").css("border-bottom","2px solid #F90A0A");
                error_stock = true;
            }else{
                $("#price_error_message").hide();
                $("#price").css("border-bottom","1px solid #82ae41");
            }
         
        }
        
        
        $("#submit").click(function(){
            
            error_pname = false;
            error_category = false;
            error_stock = false;
            error_productimg = false;
            error_uom = false;
            error_price = false;

            check_pname();
            check_category();
            check_stock();
            check_productimg();
            check_uom();
            check_price();
            
                        
            if (error_pname === false && error_category === false && error_stock === false && error_productimg === false && error_uom === false && error_price === false) {
//               alert("Registration Successfull");
               return true;
            } else {
//               alert("Please Fill the form Correctly");
               return false;
            }
         });
      });