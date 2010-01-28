require 'net/http'
require 'rexml/document'
include REXML

# This class performs certain actions on the SOLR SERVICE_RIGHTSHOLDER_SEARCH
# Add, Delete, Re-index of Rightsholders. Such Rightsholders are recorded in the
# PARTY table

module Util

  class RightsholderSearchUtil

  SOURCE = "SPRIGHTLY"

    # Adds a new rightsholder to the Search Index
    # Use this if you ara performing an update as well. SOLR will automatically replace the
    # old document with the new document: http://lucene.apache.org/solr/tutorial.html#Updating+Data
    def self.add_rightsholder_to_search(partyid, forename, surname, birthdate, deathdate, familyname, corporatename)
      lifedates = get_lifedates(birthdate, deathdate)
      name = get_name(forename, surname, familyname, corporatename)
      preferred = get_preferred_name(name, lifedates)
      post_to_service(get_add_xml(partyid.to_i.to_s, lifedates, name, preferred))
    end

    # Deletes the rightsholder from the search index
    def self.delete_rightsholder_from_search(partyid)
      xm = Builder::XmlMarkup.new
      xm.instruct!
      xm.delete {
        xm.id("partyid-" + partyid)
      }

      post_to_service(xm.target!)
    end

    # Drops all search indexes for SOURCE:SPRIGHTLY
    # Recreates all the indexes from the PARTY table for rightsholders that
    # DO NOT have an authorityid i.e. they have been added to RMS.
    def self.reindex_rightsholders_search
      xm = Builder::XmlMarkup.new
      xm.instruct!
      xm.delete {
        xm.query("source:" + SOURCE)
      }

      count = 0
      documents = ""
      if post_to_service(xm.target!)

        Party.find(:all, :conditions => ["authorityid is null and (surname is not null or familyname is not null or corporatename is not null) and status_lu_id = " + StatusLu.active.to_s]).each do |party|

          lifedates = get_lifedates(party.birthdate, party.deathdate)
          name = get_name(party.forename, party.surname, party.familyname, party.corporatename)
          preferred = get_preferred_name(name, lifedates)

          count+=1
          documents << get_doc_xml(party.partyid.to_i.to_s, lifedates , name, preferred)

          if count == 10000
              puts "Posting 10000"
              Util::HttpUtil.post_xml(SERVICE_RIGHTSHOLDER_SEARCH_UPDATE, "<add>" + documents + "</add>")
              count = 0
              documents = ""
            end
        end

        # Send whatever is left over
        puts "Posting " + count.to_s
        Util::HttpUtil.post_xml(SERVICE_RIGHTSHOLDER_SEARCH_UPDATE, "<add>" + documents + "</add>") if count > 0

        puts "Commiting all changes"
        commit_changes


      else
        false
      end
    end

    private

     # Posts a XML instruction to SERVICE_RIGHTSHOLDER_SEARCH_UPDATE
    def self.post_to_service(xml)
      response = Util::HttpUtil.post_xml(SERVICE_RIGHTSHOLDER_SEARCH_UPDATE, xml)
      case response
      when Net::HTTPOK
        commit_changes
      else
        false
      end
    end

    # Sends a commit request to the SERVICE_RIGHTSHOLDER_SEARCH_UPDATE
    def self.commit_changes
      response = Util::HttpUtil.post_xml(SERVICE_RIGHTSHOLDER_SEARCH_UPDATE, "<commit/>")
      case response
      when Net::HTTPOK
         true
      else
        false
      end
    end

    def self.get_doc_xml(partyid, lifedates, name, preferred)
      xm = Builder::XmlMarkup.new
      xm.doc {
        xm.field("partyid-" + partyid, "name"=>"id")
        xm.field(partyid, "name"=>"partyid")
        xm.field(lifedates, "name"=>"lifedates")
        xm.field(name, "name"=>"name")
        xm.field(preferred, "name"=>"preferred")
        xm.field(SOURCE, "name"=>"source")
      }
      return xm.target!
    end

    def self.get_add_xml(partyid, lifedates, name, preferred)
      xm = Builder::XmlMarkup.new
      xm.instruct!
      xm.add {
        xm.doc {
          xm.field("partyid-" + partyid, "name"=>"id")
          xm.field(partyid, "name"=>"partyid")
          xm.field(lifedates, "name"=>"lifedates")
          xm.field(name, "name"=>"name")
          xm.field(preferred, "name"=>"preferred")
          xm.field(SOURCE, "name"=>"source")
        }
      }
      return xm.target!
    end

    # Combines birthdate and deathdate into the format
    # birthdate-deathdate
    def self.get_lifedates(birthdate, deathdate)
      return nil if birthdate.nil? && deathdate.nil?
      return birthdate + "-" if deathdate.nil?
      return "-" + deathdate if birthdate.nil?
      return birthdate + "-" + deathdate
    end

    # Only surname, familyname or corporatename will be used.
    # Returns nil if all names are nil, otherwise returns the name that is not nil
    def self.get_name(forename, surname, familyname, corporatename)

      return corporatename if !corporatename.nil?
      return familyname if !familyname.nil?

      if !surname.nil?
        if forename.nil?
          return surname
        else
          return surname + ", " + forename
        end
      end

      return nil
    end

    def self.get_preferred_name(name, lifedates)
      if !lifedates.nil?
        return name + ", " + lifedates
      else
        return name
      end
    end

  end

end