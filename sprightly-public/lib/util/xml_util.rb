require 'rexml/document'
include REXML

# Utility Xpath / XML functions
#
# @author tingram
#

module Util

  class XmlUtil

    # Retrieves the text from the result of the xpath
    #
    # @param doc A document or element or node
    # @param xpath The xpath string
    # @return The text of the result or empty string
    def self.get_node_text(doc, xpath)
      return nil if doc.nil?
      node = XPath.first(doc, xpath)
      node.blank? ? "" : node.text
    end

    # Retrieves the text from an attribute from the result of the xpath
    #
    # @param doc A document or element or node
    # @param xpath The xpath string
    # @return The text of the result or empty string
    def self.get_attribute_text(doc, xpath)
      attribute = XPath.first(doc, xpath)
      attribute.nil? ? "" : attribute.value
    end

  end

end
