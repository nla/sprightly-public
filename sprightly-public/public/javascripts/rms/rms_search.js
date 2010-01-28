/* Initialize elements on the search pages */
$(document).ready(function() {
    /* add class used by rms_search.css */
	$(document.body).addClass("home");

    /* init all result items in the results list */
    initializeResultsList($(".results-list"));
});

function openRightsHolderBusinessCard(el, rhUrl) {
    $(".results-list .more-info-toggle a").removeClass("open");
    $(".results-list .result.selected").removeClass("selected");
    $(el).addClass("open");
    $(el).parents(".result:first").addClass("selected");

    if ($("#searchResultBusinessCard").length>0) {
        // move business card to focus        
        var newTopCoord = $(window).scrollTop() + $(window).height()/2 - $("#searchResultBusinessCard").height()/2;
        $("#searchResultBusinessCard").parents($(".ui-dialog:first")).animate({top: newTopCoord + "px"},1000);
        
        // update contents...
        $("#searchResultBusinessCard").dialog('option', 'title', 'loading...');
        $("#searchResultBusinessCard").data("ajaxDialog").changeContentURL(rhUrl, 'ajax=true');
    } else {
        AjaxDialogHelper.show(rhUrl, 'ajax=true', {title: "loading...", id: "searchResultBusinessCard", modal: false, height: 340, width: 450,close:onBusinessCardClose, dialogClass: 'business-card',dragStart: function() {}});
        $("#searchResultBusinessCard").bind("ajaxload", addBusinessCardNavigation)
    }
}

function addBusinessCardNavigation() {
    var currentCardIndex = $(".more-info-toggle a").index($(".more-info-toggle a.open"));
    if (currentCardIndex>0) {
        //Add left arrow
        $("#searchResultBusinessCard").append("<a class='business-card-nav' id='goLeft' href='javascript:void(0);'></a>");
        $("#goLeft").click(function() {
             $($(".more-info-toggle a")[$(".more-info-toggle a").index($(".more-info-toggle a.open"))-1]).triggerHandler("click");
        });
    }
    if (currentCardIndex<$(".more-info-toggle a").length-1) {
        //Add right arrow
        $("#searchResultBusinessCard").append("<a class='business-card-nav' id='goRight' href='javascript:void(0);'></a>");
        $("#goRight").click(function() {
             $($(".more-info-toggle a")[$(".more-info-toggle a").index($(".more-info-toggle a.open"))+1]).triggerHandler("click");
        });
    }
}

function onBusinessCardClose() {
    $(".results-list .more-info-toggle a").removeClass("open");
    $(".results-list .result.selected").removeClass("selected");
}

/*
function closeRightsHolderBusinessCard() {
    $("#searchResultBusinessCard").fadeOut(1000, function() {$(this).destroy()});
}
*/