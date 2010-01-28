require 'net/http'
require 'rexml/document'
include REXML

# This file includes:
# * 'class CatalogueWork'
# * 'class CatalogueRightsholder'
#
# Represents a work from thr NLA Catalogue.
# It uses the SERVICE_COLLECTION to get the catalogue work.
# It uses the SERVICE_VOYAGERDB to get more information about rightsholders.
#
class CatalogueWork

  attr_accessor :title, :bib_id, :pi, :marcxml_doc
  attr_accessor :rightsholders # hash of [name] = authorityid

  # Searches the SERVICE_COLLCETION for a bib record based on the bib_id
  def initialize(bib_id)
    return nil if bib_id.nil?
    response = Net::HTTP.get_response URI.parse(URI.escape(SERVICE_COLLECTION + bib_id))
    case response
      when Net::HTTPSuccess
        @marcxml_doc =  Document.new(response.body)
        @bib_id = bib_id
        @title = get_title(@marcxml_doc)
        @pi = get_pi(@marcxml_doc)
    end
  end

  # Uses the Catalogue API to retrieve the format information about this work/item.
  def get_formats
    catalogue_search = CatalogueSearch.new_query("id:" + @bib_id, 1, 1, "")
    formats = Array.new
    if catalogue_search.num_found.to_i == 1
      XPath.match(catalogue_search.items[0], 'format').each do |el|
        formats.push(el.text())
      end
    end
    return formats
  end

  # Matches the rightsholders (obtained from the bibrecord) against the
  # authorities in the voyagerdb to get the authority id's of a rightsholder.
  def add_rightsholders
    @rightsholders = get_rightsholders(@marcxml_doc)

    response = Net::HTTP.get_response URI.parse(URI.escape(SERVICE_VOYAGERDB + "record/" + @bib_id + "/authorities"))
    case response
      when Net::HTTPSuccess
        authority_doc =  Document.new(response.body)
        @rightsholders.each { |rh| rh.authorityid = get_authority_id(rh.original_name, authority_doc) }
    end
  end

  # Searches the marcxml doc for the datafield id
  # @param tag This is the datafield number ie 506
  # Pre: ensure that the marcxml doc is populated
  def get_marcxml_datafield(tag)
    field = ""
    XPath.each(@marcxml_doc, "//datafield[@tag='" + tag + "']/subfield") { |node| field += node.text + " " }
    return nil if field.empty?
    return field
  end

  private

  # Tries to match a name in the Marc record (100, 110, 700, 710) to a name
  # from the voyager authory database. Tha main issue is removing spurious
  # punctuation. If successful this method returns the authority_id
  #
  # @param original_name The name from the marc record to match
  # @param authority_doc A XML doc of the authorities
  def get_authority_id (original_name, authority_doc)
    XPath.each(authority_doc, "//authority") do |authority_el|
      authority_id = authority_el.elements['authorityid'].text
      authority_el.elements.each('subfield') do |subfield|
        if (original_name.chomp('.').eql?(subfield.text.chomp('.')))
          return 'authid-' + authority_id.to_s
        end
      end
    end
    return nil
  end


  # Iterates through the 245 field and appends all entries to create the title
  #
  # @param doc The MARCXML document
  def get_title(doc)
    title = ""
    XPath.each(doc, "//datafield[@tag='245']/subfield") { |node| title += node.text + " " }
    return title
  end

  # Searches the 856u field and strips out the pi and returns it.
  #
  # @param doc The MARCXML document
  def get_pi(doc)
    pi = ""
    XPath.each(doc, "//datafield[@tag='856']/subfield[@code='u']") { |node| pi += node.text + " " }

    if pi.nil? || pi.empty?
      return nil
    end

    return pi.strip.sub("http://nla.gov.au/", "")
  end

  # Search the 100, 110, 700 and 710 fields and return a hash of rightsholder names
  # i.e. creators / contributors known as rightsholders
  #
  # @param doc The MARCXML document
  def get_rightsholders(doc)
    rh_arr = Array.new
    rh_arr.concat(get_individuals(doc, "100", "Creator"))
    rh_arr.concat(get_organisations(doc, "110", "Creator"))
    rh_arr.concat(get_individuals(doc, "700", "Contributor"))
    rh_arr.concat(get_organisations(doc, "710", "Contributor"))
    return rh_arr
  end

  # Gets Individuals listed in the 100 and 700 subfield
  #
  # @param doc The MARCXML Document
  # @param subfield The subfield either 100 or 700
  def get_individuals(doc, subfield, role)
    
    array = Array.new

    XPath.each(doc, "//datafield[@tag='" + subfield + "']") do |datafield|

      rh = CatalogueRightsholder.new
      rh.role = role

      node = XPath.first(datafield, "subfield[@code='a']")
      if !node.nil?
        rh.name = format_name(node.text, XPath.first(datafield, "@ind1").to_s)
        rh.original_name = node.text
      end

      node = XPath.first(datafield, "subfield[@code='d']")
      if !node.nil?
        rh.life_dates = node.text
      end

      node = XPath.first(datafield, "subfield[@code='e']")
      if !node.nil?
        rh.secondary_role = node.text
      end
      
      array.push(rh)
    end

    return array
  end

  # Gets Individuals listed in the 110 and 710 subfield
  #
  # @param doc The MARCXML Document
  # @param subfield The subfield either 110 or 710
  def get_organisations(doc, subfield, role)
    array = Array.new

    XPath.each(doc, "//datafield[@tag='" + subfield + "']") do |datafield|

      rh = CatalogueRightsholder.new
      rh.role = role

      node = XPath.first(datafield, "subfield[@code='a']")
      node_b = XPath.first(datafield, "subfield[@code='b']")
      if !node.nil?
        rh.original_name = node.text
        if node_b.nil?
          rh.name = node.text
        else
          rh.name = node.text.strip + ", " + node_b.text.strip
        end
      end

      node = XPath.first(datafield, "subfield[@code='d']")
      if !node.nil?
        rh.life_dates = node.text
      end

      node = XPath.first(datafield, "subfield[@code='e']")
      if !node.nil?
        rh.secondary_role = node.text
      end

      array.push(rh)
    end

    return array
  end

  # Formats the name from the 100 subfield
  #
  # @param name The name text from the element
  # @param ind The indicator attributue
  #
  def format_name(name, ind)
    name = name.strip.chomp(",")
    if ind.eql?("0")
      names = name.split(",")
      name = names[1].strip + ", " + names[0].strip
    end
    return name
  end

end

# Represents the rightsholder as described in the Marc record
# in the 100, 110, 700 and 710 fields
class CatalogueRightsholder
  attr_accessor :authorityid, :name, :original_name, :life_dates, :role, :secondary_role
end
