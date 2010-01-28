/* Initialize Sections and tooltips on page upon pageload */
$(document).ready(function() {
    initialiseSections("#titleZone"); //inits the action buttons only (no sections here!)
	initialiseSections("#main");    
});

/*******************************************************************************
 * initialiseSections
 *     parentSelector (string or jQuery selector)
 *
 * Initialise all sections and section actions that are children of the node(s)
 * defined by the parentSelector argument.
 * 
 */
function initialiseSections(parentSelector) {
    /* init section headers */
    jQuery.each($(parentSelector + " .section-header"), function() {
        /* if section is disabled no js init required */
		if ($(this).parents('.section:first').hasClass("disabled")) {
			return;
		}
        /* add click handlers to expand/collapse sections */
		$(this).find("h3:first").click(function() {
			toggleSectionDisplay($(this).parents('.section:first'));
		});
		$(this).find(".toggle-collapse-expand").click(function() {
			toggleSectionDisplay($(this).parents('.section:first'));
            return false;
		});
	});

    /* add hover handlers */
    jQuery.each($(parentSelector + " .section"), function() {
        $(this).hover(
		  function () {
			$(this).addClass("hovered");
		  },
		  function () {
			$(this).removeClass("hovered");
		  }
		);
    });

	jQuery.each($(parentSelector + " .action"), function() {
		$(this).hover(
		  function () {
			$(this).addClass("hovered");
		  },
		  function () {
			$(this).removeClass("hovered");
		  }
		);
	});

    $(".add-action").hover(
        function() {
           $(this).addClass("hovered");
        },
        function() {
            if ($(this).attr("id")!="wizardLauncher" || $("#wizardLauncherMenu:visible").length==0) {
              $(this).removeClass("hovered");
            }
        }
    );

    /* add client side sorting to all section data tables */
    jQuery.each($(parentSelector + " .data"), function() {
        if ($(this).hasClass("no-sort")) return;
        var headersConf = {};
        $.each($(this).find("th.no-sort"), function() {            
            var index = $(this).attr("cellIndex");
            eval("var newObj = { "+index+" : { sorter : false }}");
            $.extend(headersConf, newObj);
        });
        $(this).tablesorter({
            headers:headersConf
        });
        $(this).find("th.header").hover(
            function() {$(this).addClass("hovered")},
            function() {$(this).removeClass("hovered")}
        );
        $(this).bind("sortEnd", function() {
            $.each($(this).find("tbody tr"), function() {
               $(this).removeClass("odd");
               $(this).removeClass("even");
               $(this).addClass(($(this).attr("rowIndex")% 2 == 0)?"even":"odd");
            });
        });
    });

    initialiseTooltips(parentSelector);
}

/*******************************************************************************
 * initialiseTooltips
 *     parentSelector (string or jQuery selector)
 *
 * Initialise all tooltips that are children of the node(s)
 * defined by the parentSelector argument.
 *
 */
function initialiseTooltips(parentSelector) {
    $(parentSelector + " .glossary-term").tooltip({track: true, delay: 200, showBody:"::"});
    $(parentSelector + " .has-tooltip").tooltip({track: true, delay: 100,showURL: false});
}

/*******************************************************************************
 * toggleSectionDisplay
 *     sectionEl (jQuery wrapped Element i.e. $(div)
 *
 * expand or collapse the section (defined by the sectionEl argument) based on its current status
 *
 */
function toggleSectionDisplay(sectionEl) {
	if (sectionEl.hasClass("collapsed")) {
		sectionEl.find(".section-content:first").slideDown();
		sectionEl.addClass("expanded").removeClass("collapsed");		
	} else {
		sectionEl.find(".section-content:first").slideUp();
		sectionEl.addClass("collapsed").removeClass("expanded");				
	}
}


/*******************************************************************************
 * initializeResultsList
 *     listElement (Element)
 *
 * init all result items that are children of the listElement argument
 *
 * If listElement has class isSelectable - then enable the list to support styles
 *  for a single select list (radios or single select button)
 *
 * If listElement has class isMultiSelectable - then enable the list to support
 *  styles for a multiple select list (checkboxes)
 *
 */
function initializeResultsList(listElement) {
	var isSelectable = $(listElement).hasClass("selectable");
    var isMultiSelectable = $(listElement).hasClass("multiselect");
	jQuery.each(listElement.find(".result"), function() {
		$(this).hover(
		  function () {
			$(this).addClass("hovered");
		  }, 
		  function () {
			$(this).removeClass("hovered");
		  }
		);
        /* Override any anchors within the result item to select the result item */
		if (isSelectable || isMultiSelectable) {
			$(this).click(function() {selectResultItem($(this))});
            $(this).find("a").each(function() {
                $(this).click(function() {selectResultItem($(this))});
                $(this).attr("href","javascript:void(0)");
            });
		}
	});
}

/*******************************************************************************
 * selectResultItem
 *     itemEl (Element)
 *
 * apply all styles to the result item and ensure checkbox or radio is checked.
 *
 */
function selectResultItem(itemEl) {
    if (itemEl.hasClass("not-selectable")) {
        return false;
    }
    if (itemEl.parents(".results-list:first").hasClass("selectable")) {
        jQuery.each(itemEl.parent().find(".result"), function() {
            $(this).removeClass("selected");
        });
        itemEl.addClass("selected");
        itemEl.find("input[type=radio]").attr("checked","checked");
    } else if (itemEl.parents(".results-list:first").hasClass("multiselect")) {
        if (itemEl.hasClass("selected")) {
            itemEl.find("input[type=checkbox]").removeAttr("checked","checked");
            itemEl.removeClass("selected");
        } else {
            itemEl.find("input[type=checkbox]").attr("checked","checked");
            itemEl.addClass("selected");
        }
    }
	return false;
}

/*******************************************************************************
 * initFormWidgets
 *     formId (string or jQuery selector)
 *
 * init all form widgets within the form - including the calendar date picker.
 *
 */
function initFormWidgets(formId) {
    	jQuery.each($("#"+formId).find(".datepicker"), function() {
            $(this).after("<img onclick='$(\"#"+ $(this).attr("id")+ "\").attr(\"value\",\"\");' src='" + imagePath + "calendar_delete.png'>");
            $(this).datepicker(
                {
                  showOn: 'button',
                  buttonImage: imagePath + 'calendar.png',
                  buttonText: 'Click to select a date',
                  buttonImageOnly: true,
                  changeMonth: true,
                  changeYear: true,
                  dateFormat: 'dd-mm-yy',
                  yearRange: '-150:100'
                }
            );
        });
}

/*******************************************************************************
 * toggleAuditFields
 *     el (Element)
 *
 * toggle whether the audit fields are displayed for the parent table of the
 * el argument.
 *
 */
function toggleAuditFields(el) {
   jQuery.each($(el).parents("table:first").find(".audit"), function() {
       if ($(this).hasClass("show")) {
           $(this).addClass("hide");
           $(this).removeClass("show");
       } else {
           $(this).addClass("show");
           $(this).removeClass("hide");
       }
   });
}


/*******************************************************************************
 * toggleMoreDetails
 *     toggleEl (Element)
 *     url (String)
 *     params (String or object)
 *
 * Toggle the display of the moredetails container (Parent of toggleEl argument)
 * and ajax load into it the content from url/params.
 *
 * Used by list_toggle.html.erb (which isn't currently used?)
 *
 */
function toggleMoreDetails(toggleEl, url, params) {
    var row = $(toggleEl).parents("tbody:first").find(".more-details");
    if (row.css("display") == "none") {
        //PG IE doesn't support the display property table-row
        if ($.browser.msie) {
            row.css("display","block");
        } else {
            row.css("display","table-row");
        }
        row.find(".more-details-container").html("<img src='" + imagePath + "/busy.gif'/>");
        row.find(".more-details-container").ajaxload(url, params + "&ajax=true");
    } else {
        row.css("display","none");

    }
}

var transientMessageTargetSelector = "#main"
function showTransientMessage(msg, msgClass) {
    var msgHTML = "<div id='transientMessage' class='"+msgClass+"'>"+msg+"</div>";
    if ($('#transientMessage').length>0) {
        $('#transientMessage').stop();
        $('#transientMessage').replaceWith(msgHTML)
    } else {
        $(transientMessageTargetSelector).append(msgHTML);
    }
    $('#transientMessage').fadeIn(500)
    setTimeout("$('#transientMessage').fadeOut(1000,function() {$('#transientMessage').remove();})",3000);
}


function addAgreementCountToRightsholderLinks() {
    $.each($("a.rightsholder-link[rel^='authid-']"), function() {
       var authid = $(this).attr("rel");
       if ($(this).find(".work-tray-count").length == 0) {
           $.ajax({
              async : false,
              url: $(this).attr("href").substring(0, $(this).attr("href").indexOf("authid"))+"agreement_count/"+authid,
              success: function(data){
                var title = (data=="0"?"No":data) + " Agreement(s) made with Rights Holder";
                $("a.rightsholder-link[rel^='"+authid+"']").append(" <span class='work-tray-count blue' style='display: none' title='"+title+"'>"+data+"</span>");
                $("a.rightsholder-link[rel^='"+authid+"'] .work-tray-count").fadeIn(500);
              }
           });
       }
    });
}



/* jQuery Extensions */
jQuery.fn.addHoverCSS = function() {
    $(this).hover(
        function() {
            $(this).addClass("hovered");
        },
        function() {
            $(this).removeClass("hovered");
        }
    );
};

/*******************************************************************************
 * toggleCoolBoxSize
 */
function toggleCoolBoxSize() {
  var coolBoxEl = $(this).parents(".cool-box:first").find(".cool-box-content:first");
  if ($(this).hasClass("collapsed")) {
    $(coolBoxEl).parent().css("height", "auto");
    $(coolBoxEl).animate({height: $(coolBoxEl)[0].scrollHeight}, 1000, null, function() {$(coolBoxEl).css("height","auto")});
    $(this).removeClass("collapsed");
    $(this).addClass("expanded");
  } else {
    $(coolBoxEl).animate({height: "15em"}, 1000, null, function() {$(coolBoxEl).parent().css("height", "18.5em");});

    $(this).removeClass("expanded");
    $(this).addClass("collapsed");
  }
}

