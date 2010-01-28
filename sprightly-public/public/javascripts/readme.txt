################################################################################
#                           Sprightly - RMS 3                                  #
#                          Javascript Overview                                 #
################################################################################

lib/ -> All reusable libraries and plugins
rms/ -> All RMS specific javascript - used for init of pages, widgets, sections
        and other RMS page specific behaviour.




In detail:

################################################################################
### rms/rms_common.js
### rms/rms_search.js
All RMS specific javascript - used for init of pages, widgets, sections and
some other RMS page specific behaviour.  rms_search is loaded for any page
loaded by the SearchController.



################################################################################
### lib/digit
### lib/dojo

The Dojo core and (partial) UI library.  Currenly only use dojo for the splitter
container widget (see the Agreement split view pane on the Rightsholder and work
detail pages).

Source: www.dojotoolkit.org


################################################################################
### lib/jquery-1.3.2.js

The jQuery framework.

Source: jquery.com

################################################################################
### lib/jquery-ajax-dialog.nla.js

Implements "AjaxDialog" and the "AjaxDialogHelper" which wraps the jQuery UI
dialog widget with an API to easily create, display and modify the content
with ajax/remote content.

Source: Written by PGiles (NLA)


################################################################################
### lib/jquery-ajax-form.nla.js

Implements "AjaxFormHelper" which ajaxifies a normal HTML form to POST via an
ajax post.  Also added API for client-side validation.  When used in conjunction
with an AjaxDialog, AjaxFormHelper also provides API to refresh the dialog
contents upon POST and also add a "cancel" or dialog-close button automatically.

The AjaxFormHelper is currently coupled with the
ApplicationHelper>>ajax_form_for(name, *args, &proc).

Source: Written by PGiles (NLA)


################################################################################
### lib/jquery-ajax-helper.nla.js

Provides helper methods that wrap the standard jQuery ajax load methods.

*Currently implements jQuery.fn.ajaxload which wraps jQuery.fn.load with
error handling e.g. opens an AjaxDialog open receiving an "error" and displays
the resultant trace log or error message.

Source: Written by PGiles (NLA)


################################################################################
### lib/jquery-contextmenu.js

Third party plugin for a popup/context sensitive menu widget.

Source: http://abeautifulsite.net/notebook/80


################################################################################
### lib/jquery-multiselect.js

Third party plugin for a fancy multiselect widget - wraps a multiselect SELECT
element and adds checkboxes etc.

Source: http://abeautifulsite.net/notebook.php?article=62


################################################################################
### lib/jquery-popup.js

Third party plugin that provides a consistent API to open new windows or popups.

Source: ???


################################################################################
### lib/jquery-tablesorter.js

Third party plugin which adds clientside sorting to a given table.  NB. the
table requires the heading to be within a THEAD and all the content rows to be
within a single TBODY.

Source: http://tablesorter.com/docs/


################################################################################
### lib/jquery-tooltip.js

Third party plugin which adds fancy tooltips based on the element's title
attribute value.

Source:  http://docs.jquery.com/Plugins/Tooltip


################################################################################
### lib/jquery-treeview.js
### lib/jquery-treeview.async.js

Third party plugin for a tree widget with the ability to load child branches
using ajax.

Source:  http://bassistance.de/jquery-plugins/jquery-plugin-treeview/


################################################################################
### lib/jquery-ui.js

The official jQuery UI library. Provides dialog, accordion and tab widgets.

Source: http://jqueryui.com/


################################################################################
### lib/jquery-ui.autocomplete.js

Third party plugin which can add a autocomplete dropdown to any textfield or
text area.

Source: http://docs.jquery.com/UI/Autocomplete
