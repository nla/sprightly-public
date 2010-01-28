require 'net/http'
require 'rexml/document'
include REXML

class UpdateContactDetails < ActiveRecord::Migration

  class Party < ActiveRecord::Base
    set_primary_key "partyid"
    set_sequence_name "SQ_PARTY"
  end
  
  def self.up
    down
    
    puts "Getting a list of PARTY rows where pepoid is not null"

    Party.find_by_sql("select * from party where pepoid is not null").each do |party|
      pepoid = party.pepoid.gsub("http://nla.gov.au/nla.party-", "")
      response = Net::HTTP.get_response URI.parse(URI.escape(SERVICE_IDENTITY + pepoid + "/contacts?status=ALL"))
      doc = Document.new(response.body)
      case response
        when Net::HTTPSuccess
          count = Util::XmlUtil.get_attribute_text(doc, "//report/@count")
          puts "Processing: " + pepoid + " ... found " + count

          XPath.each(doc, '//contact' ) do |el|

            type = Util::XmlUtil.get_attribute_text(el.clone, "//@type")
            privacystatus = Util::XmlUtil.get_attribute_text(el.clone, "//@privacystatus")
            effectivedate = Util::XmlUtil.get_attribute_text(el.clone, "//@effectivedate")
            archivedate = Util::XmlUtil.get_attribute_text(el.clone, "//@archivedate")
            audituser = Util::XmlUtil.get_attribute_text(el.clone, "//@audituser")

            contact = Contact.new
            contact.partyid = party.partyid
            contact.privacy_lu_id = PrivacyLu.find_by_code(privacystatus.downcase).privacy_lu_id
            contact.createuser = audituser
            contact.createdate = effectivedate
            contact.audituser = audituser
            if !archivedate.empty?
              contact.auditdate = archivedate
              contact.status_lu_id = StatusLu.archived
            else
              contact.auditdate = effectivedate if archivedate.empty?
              contact.status_lu_id = StatusLu.active
            end

            if type == "POSTAL"
                contact.contacttype_lu_id = ContacttypeLu.find_by_code(type.downcase).contacttype_lu_id
                contact.save
                el.each_element do |value_el|
                  
                  key = Util::XmlUtil.get_attribute_text(value_el.clone, "//@type").downcase
                  value = value_el.text

                  if key == "note"
                    contact.note = value
                    contact.save
                  else
                    detail = Contactdetail.new
                    detail.key = key
                    detail.value = value
                    detail.contactid = contact.contactid
                    detail.save
                  end
                end
            else                
                el.each_element do |value_el|
                  key = Util::XmlUtil.get_attribute_text(value_el.clone, "//@type").downcase
                  value = value_el.text

                  if key == "note"
                    contact.note = value
                  else
                    contact.contacttype_lu_id = ContacttypeLu.find_by_code(key).contacttype_lu_id
                    contact.save

                    detail = Contactdetail.new
                    detail.key = key
                    detail.value = value
                    detail.contactid = contact.contactid
                    detail.save
                  end

                end
            end
          end          
        else
          puts "Processing: " + pepoid + " ... no contact details"
        end
      end
  end

  def self.down
    puts "Truncating the Contact Detail and Contact Tables ..."
    Contactdetail.delete_all
    Contact.delete_all
  end
end
