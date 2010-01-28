/*******************************************************************************
 * Class:  AjaxDialog
 * Arguments:
 *      url : String ->
 *      params : String ->
 *      options : Object/Hash ->
 *
 * Useage:
 *      e.g. new AjaxDialog("/work/1234","ajax=true",{title="Work 1234", initDialogContents: function () {blah...}})
 *
 *
 * Options:
 *      id : String -> id of the dialog (if null will auto-gen)
 *      title : String -> displayed as the title of the dialog
 *      close : function -> run upon closing of the dialog
 *      modal : boolean -> if dialog should be displayed as a modal dialog
 *      initDialogContents : function -> run upon loading of content from ajax call
 *
 * By pgiles
 * 
 */


var AjaxDialogHelper = {};
AjaxDialogHelper.show = function(url, params, options) {
    new AjaxDialog(url, params, options);
    return false;
}

var AjaxDialog = function(url, params, options) {
    this.options = $.extend({}, this.defaultOptions,options);
    this.url = url;
    this.params = params;
    this.init();
}

$.extend(AjaxDialog.prototype, {
    defaultOptions: {
      title: "Dialog",
      close: function() {},
      modal: true,
      closeOnEscape: false,
      initDialogContents: function() {},
      addCloseButton: false,
      closeButtonText: "Close"
    },
	init: function() {
        this.initDialogDOM();
        this.initDimensions();
        this.openDialog();
    },
    initDialogDOM: function() {
        if (this.options.id==null) {
            this.options.id = "ajaxDialog"+$(".ui-dialog-content").length;
        }
        var domString = "<div id='"+this.options.id+"' class='ui-dialog-content ui-widget-content' style='display:none'><img src='"+imagePath+"busy.gif' alt='Loading...' /></div>";
        $(domString).appendTo($("body"));        
    },
    initDimensions: function() {
        if (this.options.height==null) {
            this.options.height = $(window).height() - 200;
        }
        if (this.options.width==null) {
            this.options.width = $(document).width() - 300;
        }
    },
    openDialog: function() {
        $("#"+this.options.id).dialog(this.options).dialog("open");
        $("#"+this.options.id).load(this.url, this.params, this.handleResponse);
        $("#"+this.options.id).data("ajaxDialog", this);


        $("#"+this.options.id).bind('dialogclose', function() {
            $(this).data("ajaxDialog").options.close();
            $(this).remove();
        });

        $("#"+this.options.id).parents(".ui-dialog:first").find(".ui-dialog-titlebar-close").unbind("click").click(function() {
            $(this).parents(".ui-dialog:first").find(".ui-dialog-content").data("ajaxDialog").destroy(true);
        });
    },
    handleResponse: function (responseText, textStatus, XMLHttpRequest) {
        //$("#"+this.options.id).html(responseText);
        var self = $(this).data("ajaxDialog");
        
        if (textStatus=="error") {
           $(this).html(responseText);
           return;
            //$(responseText).appendTo($("body")).dialog().dialog("show");
        }

        initialiseSections("#"+self.options.id);
        self.options.initDialogContents();

        if (self.options.addCloseButton) {
            if ($("#"+self.options.id+" input[type='submit']").length > 0) {
                $.each($("#"+self.options.id+" input[type='submit']"),
                    function() {
                        $(this).after(self.closeButtonHtml());
                    }
                );
            } else {
                $(this).append(self.closeButtonHtml());
            };
        }

        $(this).triggerHandler("ajaxload");
    },
    changeContent: function(params) {
        $("#"+this.options.id).html("<img src='"+imagePath+"busy.gif' alt='Loading...' />");
        $("#"+this.options.id).load(this.url, params, this.handleResponse);
    },
    closeButtonHtml: function() {
        //return "<input type='button' value='"+this.options.closeButtonText+"' onclick='$(\"#"+ this.options.id +"\").data(\"ajaxDialog\").destroy();' />"
        return " | <a href='javascript:void(0);' onclick='$(\"#"+ this.options.id +"\").data(\"ajaxDialog\").destroy(true);'>"+this.options.closeButtonText+"</a>";
    },
    changeContentURL: function(url, params) {
        $("#"+this.options.id).html("<img src='"+imagePath+"busy.gif' alt='Loading...' />");
        $("#"+this.options.id).load(url, params, this.handleResponse);        
    },
    destroy: function(suppressCloseFunction) {
        $("#"+this.options.id).dialog("destroy");
        if (!suppressCloseFunction) {
            this.options.close();
        }
        $("#"+this.options.id).remove();       
    }
});

