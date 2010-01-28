module ContactHelper

  def format_preferred(preferred)
    return "" if preferred.nil?
    return "Yes" if preferred.downcase == 'y'
  end
  
  def format_contact_values_for_display(contact)
    if contact.contacttype_lu.code == "postal"
      postal = ""
      addressee = contact.contactdetail.select { |c| c.key == "addressee" }
      line1 = contact.contactdetail.select { |c| c.key == "line1" }
      line2 = contact.contactdetail.select { |c| c.key == "line2" }
      line3 = contact.contactdetail.select { |c| c.key == "line3" }
      suburb = contact.contactdetail.select { |c| c.key == "suburb" }
      postcode = contact.contactdetail.select { |c| c.key == "postcode" }
      state = contact.contactdetail.select { |c| c.key == "state" }
      country = contact.contactdetail.select { |c| c.key == "country" }

      if not addressee.blank? then postal += get_value(addressee.first.value) end
      if not line1.blank? then postal += get_value(line1.first.value) end
      if not line2.blank? then postal += get_value(line2.first.value) end
      if not line3.blank? then postal += get_value(line3.first.value) end
      if not suburb.blank? then postal += get_value(suburb.first.value) end      
      if not state.blank? then postal += get_value(state.first.value, postcode.blank?) end
      if not postcode.blank? then postal += get_value(postcode.first.value) end
      if not country.blank? then postal += get_value(country.first.value) end

      return postal
    else
      contact.contactdetail.each do |detail|
        return detail.value if contact.contacttype_lu.code == "email"
        return detail.value + " " + contact.contacttype_lu.label if contact.contacttype_lu.code == "fax"
        return detail.value + " " + contact.contacttype_lu.label if contact.contacttype_lu.code == "bh_phone"
        return detail.value + " " + contact.contacttype_lu.label if contact.contacttype_lu.code == "ah_phone"
        return detail.value + " " + contact.contacttype_lu.label if contact.contacttype_lu.code == "mobile"
      end
    end    
  end


  private

  def get_value(value, addLineBreak=true)
    if !value.nil?
      if addLineBreak then
        return value + "<br/>"
      else
        return value + " "
      end
    else
      return ""
    end
  end

end
