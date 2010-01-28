require 'net/http'
require 'rexml/document'
require 'marc'
include REXML

# This class performs actions on the SOLR SERVICE_RIGHTSHOLDER_SEARCH specifically
# for the Authority File coming from Voyager.

module Util

  class AuthorityUtil

  SOURCE = "VOYAGER"

    # Drops all search indexes for SOURCE:VOYAGER
    # Reads the authority file and re-indexes the Search
    def self.reindex_rightsholders_search

      puts "Delete the index"
      if delete_index
        
        puts "Read the Authority File"
        reader = MARC::Reader.new(AUTHORITY_FILE_LOCATION)
        count = 0
        documents = ""
        for record in reader
          # Determine if it's a valid record
          # Determine type of record
          if valid?(record)
            count+=1
            documents << get_doc_xml(record)

            if count == 10000
              puts "Posting 10000"
              Util::HttpUtil.post_xml(SERVICE_RIGHTSHOLDER_SEARCH_UPDATE, "<add>" + documents + "</add>")
              count = 0
              documents = ""
            end
          end

        end

        # Send whatever is left over
        puts "Posting " + count.to_s
        Util::HttpUtil.post_xml(SERVICE_RIGHTSHOLDER_SEARCH_UPDATE, "<add>" + documents + "</add>") if count > 0

        puts "Commiting all changes"
        commit_changes

      end

    end

    private


    def self.delete_index
      xm = Builder::XmlMarkup.new
      xm.instruct!
      xm.delete {
        xm.query("source:" + SOURCE)
      }

      response = Util::HttpUtil.post_xml(SERVICE_RIGHTSHOLDER_SEARCH_UPDATE, xm.target!)
      case response
      when Net::HTTPOK
         commit_changes
      else
        puts "Delete Index FAILED"
        puts response
        false
      end
    end

    # Determines if this is a valid authority record
    # The rule is to allow only those with 100 or 110 fields
    # However, if there is a subfieled $t then exclude it as well
    def self.valid?(record)
      fields = record.find_all {|field| field.tag =~ /^1[0-1]0/}
      if fields.size > 0
        # Iterate through all the fields searching for all subfields $e - $z
        fields.each do |field|
          field.each { |subfield| return false if subfield.code.match(/[e-z]/) }
        end
        return true
      else
        return false
      end
    end

    # Creates the <doc> solr element
    def self.get_doc_xml(record)
      id = record['001'].value
      name = get_name(record)
      lifedates = get_lifedates(record)
      xm = Builder::XmlMarkup.new
      xm.doc {
        write_field(xm, "id", "authid-" + id)
        write_field(xm, "authid", id)
        write_field(xm, "lifedates", lifedates) if !lifedates.blank?
        write_field(xm, "name", name)
        write_field(xm, "source", SOURCE)
        write_other_fields(xm, record)
      }
      return xm.target!
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

    # Based on an authority record generates XML add document for SOLR
    def self.get_add_xml(record)
      id = record['001'].value
      name = get_name(record)
      lifedates = get_lifedates(record)
       
      xm = Builder::XmlMarkup.new
      xm.instruct!
      xm.add {
        xm.doc {
          write_field(xm, "id", "authid-" + id) 
          write_field(xm, "authid", id)
          write_field(xm, "lifedates", lifedates) if !lifedates.blank?
          write_field(xm, "name", name)
          write_field(xm, "source", SOURCE)
          write_other_fields(xm, record)
        }
      }
      return xm.target!
    end

    # Writes preferred, insteadOf, seeAlso, scopenote
    def self.write_other_fields(xm, record)

      record.each do |field|       
        if field.tag.match(/^1..$/)
          name = "preferred"
        elsif field.tag.match(/^4..$/)
          name = "insteadOf"
        elsif field.tag.match(/^5..$/)
          name = "seeAlso"
        elsif field.tag.match(/^(665|663|360)$/)
          name = "scopenote"
        end

        if !name.blank?
          value = ""
          field.each do |subfield|
            if (subfield.code == 'w')
                next;
            end
            if (subfield.code == 'v' ||
                subfield.code == 'x' ||
                subfield.code == 'y' ||
                subfield.code == 'z')

                value << "-- "
            end
            value << subfield.value + " "
           end
           write_field(xm, name, value)
          end
        end
     end
    

    def self.write_field(xm, name, value)
      xm.field(clean(value), "name"=>name)
    end

    # If the 100 field exists return the subfield $d if it exists
    def self.get_lifedates(record)
      field_100 = record.find {|f| f.tag == '100'}
      if !field_100.blank?
        return field_100['d']
      end
    end

    # Returns either the 100$a or 110$a
    def self.get_name(record)

      field_100 = record.find {|f| f.tag == '100'}
      field_110 = record.find {|f| f.tag == '110'}

      if !field_100.blank?
        return field_100['a']
      elsif !field_110['a'].blank?
        return field_110['a']
      else
        return nil
      end

    end

    def self.get_preferred_name(name, lifedates)
      if !lifedates.nil?
        return name + ", " + lifedates
      else
        return name
      end
    end

     # Removes leading and trailing punctuation
    def self.clean(str)
      str = str.sub(/[, ;]+$/, "") # Trailing
      str = str.sub(/^[, .;]+/, "") # Leading
      return str
    end

  end
end