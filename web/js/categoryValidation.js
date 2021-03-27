$('#category_error_message').hide();
$('.modal-footer .confirm-ok').click(function () {
    var noError = true;
    var pattern = /^[a-zA-Z]*$/;
    var categoryName = $("#category").val();
    if (categoryName === '') {
        $("#category_error_message").html("Enter category Name");
        $("#category_error_message").show();
        $("#category").css("border-bottom", "2px solid #F90A0A");
        noError = false;
    } else {
        if (pattern.test(categoryName)) {
            $("#category_error_message").hide();
            $("#fname").css("border-bottom", "1px solid #82ae41");
            noError = true;
        } else {
            $("#category_error_message").html("Only Characters is allowed");
            $("#category_error_message").show();
            $("#category").css("border-bottom", "2px solid #F90A0A");
            noError = false;
        }
    }

    return noError;
});