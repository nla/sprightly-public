module WorksHelper

  # Generates a clickable list of Creator/Contribuors from the catalogue
  # The link is to the Rightsholder search
  def format_catalogue_rightsholder_list(rightsholders)
    list = ""
    rightsholders.each_with_index do |rh, index|
      list = list + "<div class='cat-rights-holder'>"
      if rh.authorityid.nil?
        list = list + get_rh_search_url(get_string(rh.name), get_string(rh.life_dates)) + "&nbsp;" + get_string(rh.role) + "&nbsp;" + get_string(rh.secondary_role)
      else
        list = list + get_rh_url(get_string(rh.name), get_string(rh.life_dates), rh.authorityid) + "&nbsp;" + get_string(rh.role) + get_string(rh.secondary_role) + "&nbsp;" # + get_view_agreements_action(rh.authorityid)
      end
      list = list + "</div>"
    end
    return list
  end

  # Formats the Creator of the work
  def format_dcm_rightsholder(name, role)
    get_rh_search_url(name, "") + "&nbsp;" + role
  end

  # Formats the Creator of the work
  def format_rms_rightsholder(surname, forename, life_dates, role, pepoid)
    get_rh_url(surname + " " + forename, life_dates, pepoid) + "&nbsp;" + role
  end

  def display_work_formats(formats)
    display = ""
    formats.each { |f| display = display + "&nbsp;" + f + "&nbsp;" + image_tag(f.downcase + "-icon.png") }
    return display
  end

  private
  
  def get_string(str)
    if str.nil?
      return ""
    else 
      return str + " "
    end
  end

  def get_rh_url(name, life_dates, id)
    return "<a href='" + url_for(:controller => :rightsholders, :action => :show, :id => id)  + "'>" + name + "&nbsp;" + life_dates + "</a>"
  end
  
  def get_rh_search_url(name, life_dates)
    return "<a href='" + url_for(:controller => :search, :action => :search, 'source' => 'rightsholder', 'q' => name + life_dates) + "'>" + name + life_dates + "</a>"
  end

end