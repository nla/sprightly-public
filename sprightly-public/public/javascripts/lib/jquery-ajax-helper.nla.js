/**
 * Ajax Load Helper.
 *
 * Extend jQuery to support ajaxload function which wraps the standard load
 * function with some error notification.
 *
 * By pgiles
 */
jQuery.fn.ajaxload = function( url, params, callback){
 this.each( function() {
  $(this).load(url, params, function(responseText, textStatus, request) {
      if (request.status != 200) {
          var domString = "<div id='ajaxErrorDialog' class='ui-dialog-content ui-widget-content' style='display:none'><img src='/images/busy.gif' alt='Loading...' /></div>";
          $(domString).appendTo($("body"));
          responseText = responseText.replace(/<style.*?>[\s\S]*?<\/.*?style>/ig,"");
          $("#ajaxErrorDialog").html(responseText);
          $("#ajaxErrorDialog").dialog({title: "Ajax Load Error", dialogClass: "error", height: $(window).height() - 200, width: $(window).width() - 200, modal: true}).dialog("open");
          $("#ajaxErrorDialog").bind('dialogclose', function() {
               $("#ajaxErrorDialog").dialog("destroy");
               $("#ajaxErrorDialog").remove();
          });
          $(this).html("<p class='error-msg'>Error when loading content.  Please try again or contact the System Administrator.</p>")
      }
      if (callback) callback();
  });
 });
}


