require 'net/http'
require 'uri'

include Net

# A utility class that makes REST style requests 'EASY' in Ruby
#
# @author tingram

module Util

  class HttpUtil

    # Post the body to the url. Sets the content type to application/xml.
    # Returns the Reponse object
    #
    # @param url The URL of the service
    # @param body The request body
    def HttpUtil.post_xml(url, body)

      headers = {
      'Content-Type' => 'application/xml'
      }

      request_url = URI.parse(url)
      http_response = Net::HTTP.start(request_url.host, request_url.port) {|http|
        http.post(request_url.path, body, headers)
      }

    end

    # Puts the body to the url. Sets the content type to application/xml.
    #
    # @param url The URL of the service
    # @param body The request body
    def HttpUtil.put_xml(url, body)

      headers = {
      'Content-Type' => 'application/xml'
      }

      request_url = URI.parse(url)
      http_response = Net::HTTP.start(request_url.host, request_url.port) {|http|
        http.put(request_url.path, body, headers)
      }

    end

    # Make a GET request to the URL using the params hash
    #
    # @param url The URL of the service
    # @param params Hash of parameters
    def HttpUtil.get(url, params)
      response = Net::HTTP.get_response URI.parse(URI.escape url)
    end
  
  end

end
