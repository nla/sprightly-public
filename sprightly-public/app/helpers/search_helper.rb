module SearchHelper
  
  def catalogue_get_title(catalogue)
    return XPath.first(catalogue, "title").text
  end

  def catalogue_get_bibid(catalogue)
    return XPath.first(catalogue, "id").text
  end

  def catalogue_get_pi(catalogue)
    pi = XPath.first(catalogue, "pi")
    if pi.nil?
      return nil
    else
      return pi.text
    end
  end

  def catalogue_get_author(catalogue)
    author = XPath.first(catalogue, "author")
    if author.nil?
      return ""
    else
      return "<br/><a href='" + url_for(:controller => :search, :action => :search, 'source' => 'rightsholder', 'q' => author.text()) + "'>" + author.text() + "</a>"
    end
  end

  def catalogue_get_image(catalogue)
    return image_tag(SERVICE_NLATHUMB + XPath.first(catalogue, "id").text)
  end

  def catalogue_get_formats(catalogue)
    formats = Array.new
    XPath.match(catalogue, 'format').each do |el|
      formats.push(el.text() + "&nbsp;" + image_tag((el.text().downcase) + "-icon.png"))
    end
    return formats
  end

  def dcm_get_workpid(node)
    node.each_element_with_attribute('name', 'workpid' ) do |element|
      element.each do |str|
        return str.text()
      end
    end
  end

  def dcm_get_title(node)
    node.each_element_with_attribute('name', 'title' ) do |element|
      element.each do |str|
        return str.text()
      end
    end
  end

  def dcm_get_creator(node)
    node.each_element_with_attribute('name', 'creator' ) do |element|
      element.each do |str|
        if str.text().blank? || str.text().eql?('null')
          return ""
        else
          return "<br/><a href='" + url_for(:controller => :search, :action => :search, 'source' => 'rightsholder', 'q' => str.text()) + "'>" + str.text() + "</a>"
        end
      end
    end
    return ""
  end

  def rightsholder_get_source(node)
    node.each_element_with_attribute('name', 'source' ) do |element|
      return element.text
    end
  end

  def rightsholder_get_name(node)
    node.each_element_with_attribute('name', 'preferred' ) do |element|
      element.each do |str|
        return str.text()
      end
    end
  end

  def rightsholder_get_other_names(node)
    other_names = ""
    node.each_element_with_attribute('name', 'insteadOf' ) do |element|
      element.each do |str|
        other_names = other_names + "<br/>" + str.text()
      end
    end
    return other_names
  end

  def rightsholder_get_id(node)
    node.each_element_with_attribute('name', 'id' ) do |element|
      return element.text
    end
  end
end