/*******************************************************************************
 *******************************************************************************
 *
 * AjaxFormHelper
 *
 * To be used in conjunction with the ajax_form_for helper method.
 *
 * Converts the standard POST form into an ajax form which will not refresh the
 * page upon submit.  Instead post loads the subsequent reponse into the element
 * defined by the parentSelector.
 *
 * Other info:
 *  - as this is generally used here within a dialog, the AjaxFormHelper will
 *    add a cancel or dialog close button by default (avoid this by adding a
 *    child with the class .ajax-form-cancel and hiding it.
 *  - upon receiving a response from the POST, the AjaxFormHelper will trigger
 *    the event "ajaxload" on the element defined by the parentSelector.
 *
 * By pgiles
 *
 *******************************************************************************
 */
var AjaxFormHelper = {};


/*******************************************************************************
 * AjaxFormHelper.init
 *      id (String) - form id
 *      parentSelector (String) - dom selector of the element to load the reponse into
 *      validateFunc (String) - a client side js function to run before submit
 *
 * Initialises the form element including overriding all submit to use the
 * AjaxFormHandler.ajaxFormSubmit function.
 *
 *
 */
AjaxFormHelper.initForm = function(id, parentSelector, validateFunc) {
    var shouldAddCancelButton = $("#"+id).find(".ajax-form-cancel").length == 0;    
    $.each($("#"+id+" input[type=submit]"),
        function() {
            $(this).click(function() {
                  if (validateFunc && !validateFunc()) {
                      return false;
                  }
                  AjaxFormHelper.ajaxFormSubmit(this);
                  return false;
            });
            if (shouldAddCancelButton) {                
                $(this).after(AjaxFormHelper.cancelButtonHtml());
            }
        }
    );
    $("#"+id).data("parentSelector",parentSelector); 
};

/*******************************************************************************
 * AjaxFormHelper.ajaxFormSubmit
 *      el (Element) - the form element
 *
 * Perform an ajax post based and load the result into the element defined by
 * the parentSelector.
 *
 */
AjaxFormHelper.ajaxFormSubmit = function(el) {
    var formEl = (el.tagName=="FORM")?el:el.form;
    var submitEl = (el.tagName=="FORM")?$(el).find("input[type=submit]:first"):el;
    var obj = $(formEl).serializeArray();

    if ($(submitEl).hasClass("disabled")) {
        return false;
    }

    $(submitEl).attr("disabled", true);
    $(submitEl).addClass("disabled");

    $(submitEl).after($("<img src='"+imagePath+"busy.gif'>"));

    $(formEl).parents($(formEl).data("parentSelector")).load(formEl.action+"?ajax=true", obj, this.handleResponse);

    return false;
};

/*******************************************************************************
 * AjaxFormHelper.handleResponse
 *      (responseText, textStatus, XMLHttpRequest)
 *
 * Handle the POST reponse and trigger the event "ajaxload" on the element
 * defined by the parentSelector if successful.
 *
 */
AjaxFormHelper.handleResponse = function (responseText, textStatus, XMLHttpRequest) {
        if (textStatus=="error") {
           $(this).html(responseText);
           return;
        }
        $(this).triggerHandler("ajaxload", [responseText,textStatus, XMLHttpRequest]);
    };

/*******************************************************************************
 * AjaxFormHelper.closeDialog
 *      el (Element) - an element in the form
 *
 * Close the parent dialog.
 *
 */
AjaxFormHelper.closeDialog = function (el, suppressDialogCloseFunction) {
    $(el).parents(".ui-dialog-content:first").data("ajaxDialog").destroy(suppressDialogCloseFunction);
};

/*******************************************************************************
 * AjaxFormHelper.cancelButtonHtml
 *
 * HTML to define the cancel button.
 *
 */
AjaxFormHelper.cancelButtonHtml = function () {
  return " <span class='ajax-form-seperator'>|</span> <a class='ajax-form-cancel' onclick='AjaxFormHelper.closeDialog(this, true); return false;' href='javascript:void(0);'>Cancel</a>";
};
