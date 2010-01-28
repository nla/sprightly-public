# Methods added to this helper will be available to all templates in the application.
require 'markaby'

module ApplicationHelper

  # Format date for display as dd-mm-yyyy
  def format_date_for_display(date)

    if date.nil?
      return ""
    end
    
    year = date.to_s.slice(0..3)
    month = date.to_s.slice(5..6)
    day = date.to_s.slice(8..9)
    return day + "-" + month + "-" + year
  end

  # Remove unwanted characters from the query string that limit the results
  def format_query(query)
    query.gsub(/[-]/, ' ')
  end

  def trunc_to_dotdotdot(string, limit, for_html)
    for_html = false if for_html.nil?
    if (string.length<limit) then
      return string
    end
    if for_html then
      return string[0,limit]+"..."
    else
      return string[0,limit]+"&hellip;"
    end

  end

  def remove_null(str)

    if str == 'null'
      return ''
    else
      return str
    end
  end

  def ajax_form_for(name, *args, &proc)
   
    if not args[0].has_key?(:html) then
     args[0][:html] = {}     
    end
    if not args[0][:html].has_key?(:id) then
     args[0][:html][:id] = "ajaxForm";
    end
    if not args[0].has_key?(:parent_selector) then
     args[0][:parent_selector] = ".ui-dialog-content:first";
    end
    form_id = args[0][:html][:id]
    parent_selector = args[0][:parent_selector]
    validate_function = args[0][:validate_function]
    if !validate_function.nil? then
      validate_function_js = ', '+validate_function
    else
      validate_function_js = ""
    end
    form_for(name, *args, &proc)
    concat('<script type="text/javascript">AjaxFormHelper.initForm("'+form_id+'","'+parent_selector+'"'+validate_function_js+'); initFormWidgets("'+form_id+'")</script>')
    concat('<script type="text/javascript">$("#'+form_id+'").submit(function(){AjaxFormHelper.ajaxFormSubmit($("#'+form_id+'")[0]); return false;});</script>')
  end

  def list_rightsholders(rightsholders, displayAsLink)
    mab = Markaby::Builder.new

    url = url_for({:controller=>"rightsholders",:action=>"show",:id=>nil})
    mab.span :class=>"rh-list" do
      rightsholders.each_with_index { |rh, i|
        if displayAsLink then
          a rh.name, :href=> url+"/"+rh.id
        else
          span rh.name
        end        
        if i < rightsholders.length-1 then
          self << "; "
        else
          self << " "
        end
      }
    end

    mab.to_s
  end

  def label_and_value(label, value, hideIfNil = false, preserve_newlines = true)
    mab = Markaby::Builder.new

    if preserve_newlines  then
      _value = nl2br(value)
    else
      _value = value
    end
    if hideIfNil and ( _value.nil? or _value.empty? ) then

    else
      mab.div :class=> "label-value-pair" do
        div.label do
          self << label
          self << ":"
        end
        if _value.blank? then
          div.value.empty "N/A"
        else
          div.value do
            self << _value
          end
        end
      end
    end
    mab.to_s
  end

  def clear_fix
    mab = Markaby::Builder.new
    mab.div :class=>"clear-fix"
    mab.to_s
  end

  def empty_options
    mab = Markaby::Builder.new
    mab.option :value=>""
    mab.to_s     
  end

  def nl2br(s)
    return "" if s.nil?
    s.gsub(/(\r)?\n/, '<br />')
  end

  def get_view_agreements_action(rightsholderid, agreements_count=nil)

    url = url_for(:controller => :rightsholders, :action => :show, :id => rightsholderid, :anchor=>"rhAgreements")
    img_tag = image_tag("view_agreements.png", :alt=>"View Agreements", :title=>"View Agreements")

    mab = Markaby::Builder.new
    mab.span :class=>"add-action" do
      a :href => url, :class=>"view-agreements-link rightsholder-link", :rel=>rightsholderid do
           self << img_tag
           self << " "
           self.span :class=>"add-action-text" do
             self << "View Agreements"
             if not agreements_count.blank? then
               self << " "
               self << get_submitted_agreement_count_html(agreements_count)
             end
           end
        end
    end    
    mab.to_s
  end

  def get_view_agreements_basic_action(rightsholderid)

    url = url_for(:controller => :rightsholders, :action => :show, :id => rightsholderid, :anchor=>"rhAgreements")
    img_tag = image_tag("view_agreements.png", :alt=>"View Agreements", :title=>"View Agreements")

    mab = Markaby::Builder.new
    mab.a :href => url do
       self << img_tag
    end
    mab.to_s
  end

  def catalogue_link(bibid)

    url = NLA_CATALOGUE_RECORD_URL + bibid
    img_tag = image_tag("catalogue.png", :alt=>"View In Catalogue", :title=>"View In Catalogue")

    mab = Markaby::Builder.new
    mab.span :class=>"add-action blue catalogue-link" do
      a :href => url, :target=>"_blank" do
           self << img_tag
           self << " "
           self.span :class=>"add-action-text" do
             self << "View In Catalogue"
           end
        end
    end
    mab.to_s
  end

  def get_submitted_agreement_count_html(count)
    get_agreement_count_html(count, "blue")
  end

  def get_agreement_count_html(count, colour)
    get_count_html(count, count.to_s + " Agreement(s) made with Rights Holder", colour)
  end

  def get_count_html(count, title, colour)
    mab = Markaby::Builder.new
    mab.span :class=>"work-tray-count "+colour, :title=>title do
     self << count
    end
    mab.to_s
  end

  def action(label, url, tooltip="", open_js_dialog=false, js_dialog_params="", css_class="", extra_attributes="")

    if not label.include?("<img") then
      css_class += " text"
    end

    if open_js_dialog then
      render :partial => "common/action_js_dialog.html", :locals=>{:label=>label, :url=>url, :js_dialog_params=>js_dialog_params, :css_class=>css_class, :extra_attributes=>extra_attributes, :tooltip=>tooltip}
    else
      render :partial => "common/action.html", :locals=>{:label=>label, :url=>url, :css_class=>css_class, :extra_attributes=>extra_attributes, :tooltip=>tooltip}
    end
  end

  # Used by all list to either hide or display the ACTION like add based on the user group.
  # The action is shown if the user has edit access otherwise it's hidden.
  def action_input_only(label, url, tooltip="", open_js_dialog=false, js_dialog_params="", css_class="", extra_attributes="")
      # Render if user is an administrator or updater
      if session[:user].updater?
        action(label, url, tooltip, open_js_dialog, js_dialog_params, css_class, extra_attributes)
      end
  end

  def get_user_title
    if !session[:user].group.nil?
      return session[:user].id + "|" + session[:user].group
    else
      return session[:user].id
    end
  end

  def glossary_term(label, term_code)
    label = term_code if label.nil?
    definition = Glossary.get_definition_for_term(term_code)
    render :partial=>"common/glossary_term.html", :locals=>{:definition=>definition, :label=>label}
  end

  def label_glossary_term(label,label_for_attr, term_code)
    definition = Glossary.get_definition_for_term(term_code)
    render :partial=>"common/glossary_term.html", :locals=>{:definition=>definition, :label=>label, :label_for_attr=>label_for_attr}
  end  

  def format_source_for_display(source_string)
    if source_string.eql?("dcm") then
      return source_string.upcase
    end
    return source_string.capitalize
  end

end

class Array
  def to_js_a
    html = "["
    html += collect { |element|
                      "\"" + element + "\""
                    }.join(",")
    html += "]"
    html
  end
end

