$(document).ready(function () {
    var searchbar;

    $(".desktop-search .fa-search").click(function() {
        searchbar = $(this).siblings('.searchbar');

        if($(searchbar).is(':hidden')){
            searchbar.fadeIn(1000,function(){
                $(this).show();
                $(this).find("input[type='text']").focus();
            });
        }else if($(searchbar).is(':visible')){
            searchbar.fadeOut(1000,function(){
                $(this).hide();
            });
        }
    });
    
    $('.ftco-section').click(function(){
        if($(searchbar).is(':visible')){
            searchbar.fadeOut(1000,function(){
                $(this).hide();
            });
        }
      });
});

