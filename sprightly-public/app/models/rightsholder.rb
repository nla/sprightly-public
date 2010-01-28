require 'net/http'
require 'rexml/document'
include REXML

# Represents a Rightsholder within RMS.
# Each rightsholder is stored within the PARTY table.
# The PARTY table will only store the names and lifedates for rightsholders added to RMS.
# The SERVICE_RIGHTSHOLDER_SEARCH stores an index of both the RMS added rightsholder
# and the Voyager Authority file.
#
# Therefore this class will interect with the PARTY table and the SERVICE_RIGHTSHOLDER_SEARCH
# to get all the details of a rightsholder.
#
# @author: tingram
#
class Rightsholder

  attr_accessor :id, :preferred, :other_names, :name, :life_dates, :partyid, :authorityid, :source

  # Initialize a rightsholder based on the id within the SERVICE_RIGHTSHOLDER_SEARCH.
  # The format of the id is either: authid-1234 or partyid-1234
  def initialize(id)
    solr_response = SolrResponse.new_query(SERVICE_RIGHTSHOLDER_SEARCH, "id:" + id, 0, 1, "")
    doc = solr_response.items[0]

    @id = id
    @preferred = Util::XmlUtil.get_node_text(doc, "//doc/arr[@name='preferred']/str")
    @other_names = get_other_names(doc)
    @name = Util::XmlUtil.get_node_text(doc, "//doc/str[@name='name']")
    @life_dates = Util::XmlUtil.get_node_text(doc, "//doc/str[@name='lifedates']")
    @partyid = Util::XmlUtil.get_node_text(doc, "//doc/str[@name='partyid']")
    @authorityid = Util::XmlUtil.get_node_text(doc, "//doc/str[@name='authid']")
    @source = Util::XmlUtil.get_node_text(doc, "//doc/str[@name='source']")
  end

  # A PARTYID is used to initialize this rightsholder
  def self.get_rightsholder_by_partyid(partyid)
    party = Party.find(partyid)

    if party.authorityid.nil?
      Rightsholder.new("partyid-" + party.partyid.to_i.to_s)
    else
      rh = Rightsholder.new("authid-" + party.authorityid)
      rh.partyid = party.partyid.to_i
      return rh
    end

  end

  def self.type_options
    options = []
    options.push(["Individual","individual"])
    options.push(["Organisation","organisation"])
    options.push(["Family","family"])
    options
  end

  private

  # Returns an array of other names 
  def get_other_names(doc)
    names = []
    return names if doc.nil?
    XPath.each(doc, "//doc/arr[@name='insteadOf']/str") { |node| names.push(node.text) }
    return names
  end

end
