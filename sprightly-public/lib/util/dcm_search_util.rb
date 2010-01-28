require 'net/http'
require 'rexml/document'
include REXML

# This class performs certain actions on the SOLR SERVICE_DCM_SEARCH
# It connects to the DCM Database and creates a new index of internal
# images

module Util

  class DcmSearchUtil

    # Drops all search indexes
    # Recreates all the indexes from the WORK table within DCM
    def self.reindex_dcm_search
      
      puts "Delete the index"
      if delete_index

        puts "Iterate through all nla.int images and insert them into the index"
        documents = ""
        count = 0
        Work.find(:all, :conditions => ["collection = 'nla.int'"]).each do |work|
          count += 1
          documents << get_doc_xml(work)

          if count == 10000
            puts "Posting 10000"
            Util::HttpUtil.post_xml(SERVICE_DCM_SEARCH_UPDATE, "<add>" + documents + "</add>")
            count = 0
            documents = ""
          end
        end

        # Send whatever is left over
        puts "Posting " + count.to_s
        Util::HttpUtil.post_xml(SERVICE_DCM_SEARCH_UPDATE, "<add>" + documents + "</add>") if count > 0

        puts "Commiting all changes"
        commit_changes

      else
        false
      end
    end

    private

    def self.delete_index
      # Search for all records that have nla in the id
      xm = Builder::XmlMarkup.new
      xm.instruct!
      xm.delete {
        xm.query("nla")
      }

      response = Util::HttpUtil.post_xml(SERVICE_DCM_SEARCH_UPDATE, xm.target!)
      case response
      when Net::HTTPOK
         commit_changes
      else
        puts "Delete Index FAILED"
        puts response
        false
      end
    end

    # Sends a commit request to the SERVICE_DCM_SEARCH
    def self.commit_changes
      response = Util::HttpUtil.post_xml(SERVICE_DCM_SEARCH_UPDATE, "<commit/>")
      case response
      when Net::HTTPOK
         true
      else
        puts response
        false
      end
    end

    # Creates the <doc> solr element
    def self.get_doc_xml(work)
      xm = Builder::XmlMarkup.new
      xm.doc {
        xm.field(work.workpid, "name"=>"id")
        xm.field(work.workpid, "name"=>"workpid")
        xm.field(work.creator, "name"=>"creator")
        xm.field(work.title, "name"=>"title")
        xm.field(work.biblevel, "name"=>"biblevel")
        xm.field(work.digitalstatus, "name"=>"digitalstatus")
        xm.field(work.localsystemno, "name"=>"localsystemno")
        xm.field(work.parentpid, "name"=>"parentpid")
      }
      return xm.target!
    end

  
  end

end