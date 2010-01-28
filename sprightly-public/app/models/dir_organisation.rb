require 'net/http'
require 'rexml/document'
require 'util/xml_util'
include REXML

# Convenience class that accesses the DIR Service to retrieve
#
# @author tingram
#
class DirOrganisation

  attr_accessor :id, :name

  def initialize(query_response)

    response = Document.new(query_response)

    @name = XmlUtil.get_node_text(response, "//name")
    @id = XmlUtil.get_node_text(response, "//organisation_id")

  end

  # Retrieves an organisation from teh service using the id.
  #
  # @param id The id of the organisation within the DIR database.
  def self.get(id)
    query = SERVICE_DIR + id
    response = Net::HTTP.get_response(URI.parse(URI.escape(query)))
    self.new(response.body)
  end

end