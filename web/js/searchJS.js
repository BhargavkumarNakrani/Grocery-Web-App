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

    $('.desktop-search').find('.search_input').focusout(function (){
        $(this).parent().parent().fadeOut(1000,function(){
            $(this).hide();
        }); 
    });
});

