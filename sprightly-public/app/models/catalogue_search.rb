require 'net/http'
require 'rexml/document'
include REXML

# Model that queries the NLA Catalgue Search API
class CatalogueSearch

  attr_accessor :num_found, :start, :items

  def initialize(query_response, page)
    response = Document.new(query_response)
    @num_found = XPath.first(response, "//ResultSet/RecordCount").text
    @start = page
    @items = Array.new
    XPath.each(response, "//ResultSet/record") do |element|
      @items << element
    end
  end

  def self.new_query(query, page, rows, extra_param)
    query = SERVICE_CATALOG_SEARCH + "&lookfor=#{query}&page=#{page.to_s}&rows=#{rows.to_s}" + extra_param
    response = Net::HTTP.get_response(URI.parse(URI.escape(query)))
    self.new(response.body, page)
  end

end