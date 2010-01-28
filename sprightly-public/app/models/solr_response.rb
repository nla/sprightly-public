require 'net/http'
require 'rexml/document'
include REXML

# Searches a Solr Index
class SolrResponse

  attr_accessor :num_found, :start, :items

  def initialize(query_response)
    response = Document.new(query_response)
    @num_found = XPath.first(response, "/response/result/@numFound").to_s
    @start = XPath.first(response, "/response/result/@start").to_s

    @items = Array.new
    XPath.each(response, "/response/result/doc") do |element|
      @items << element
    end
  end

  # Performs a query and returns a SolrResponse object
  def self.new_query(service, query, start, rows, extra_param)
    query = service + "?q=#{query}&start=#{start.to_s}&rows=#{rows.to_s}" + extra_param
    response = Net::HTTP.get_response(URI.parse(URI.escape(query)))
    self.new(response.body)
  end

  # Returns the id of the result
  def get_id_of_first_result
    if @items.size > 0
      @items[0].each_element_with_attribute('name', 'id' ) { |element| return element.text() }
    end
  end
 
end