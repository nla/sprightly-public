require 'net/http'
require 'rexml/document'
include REXML

class ReconcilePartyWithAuthorityid < ActiveRecord::Migration

  class Party < ActiveRecord::Base
    set_primary_key "partyid"
    set_sequence_name "SQ_PARTY"
  end

  def self.up

    puts "Getting a list of PARTY rows where pepoid is not null"

    Party.find_by_sql("select * from party where pepoid is not null").each do |party|
      pepoid = party.pepoid.gsub("http://nla.gov.au/nla.party-", "")
      puts "Processing: " + pepoid
      response = Net::HTTP.get_response URI.parse(URI.escape(SERVICE_IDENTITY + pepoid))
      doc = Document.new(response.body)
      case response
      when Net::HTTPSuccess
        
        authorityid = Util::XmlUtil.get_attribute_text(doc, "//eacid[@ownercode='AuCNL']/@syskey")
   
        if !authorityid.empty?
          party.authorityid = authorityid
        else
          surname = get_name(doc, "surname")
          forename = get_name(doc, "forename")
          life_dates = Util::XmlUtil.get_node_text(doc, "//pershead[@authorized='RMS']/existdate")
          corpname = get_org_name(doc) if surname.nil? or surname.length==0
          familyname = get_name(doc, "familyname")

          party.surname = surname if !surname.nil?
          party.forename = forename if !forename.nil?
          party.corporatename = corpname if !corpname.nil?
          party.familyname = familyname if familyname.nil?

          if !life_dates.empty?
            birthdate = life_dates.match('\d\d\d\d-').to_s.gsub('-','')
            deathdate = life_dates.match('-\d\d\d\d').to_s.gsub('-','')
          end

          party.birthdate = birthdate if !birthdate.nil?
          party.deathdate = deathdate if !deathdate.nil?
        end
        
        party.save
      end
    end
  end

  def self.down
    #Party.update_all("authority = null", "authorityid is not null")
  end

  # Gets a name where type = surname or forename
  def self.get_name(doc, type)
    name = Util::XmlUtil.get_node_text(doc, "//pershead[@authorized='PEPO']/part[@type='" + type + "']")
    if name.nil? || name.length == 0
      name = Util::XmlUtil.get_node_text(doc, "//pershead[@authorized='AuCNL']/part[@type='" + type + "']")
    end
    return name
  end

    # Gets a name where type = surname or forename
  def self.get_org_name(doc)
    name = Util::XmlUtil.get_node_text(doc, "//corphead[@authorized='PEPO']/part")
    if name.nil? || name.length == 0
      name = Util::XmlUtil.get_node_text(doc, "//corphead[@authorized='AuCNL']/part")
    end
    return name
  end

end
