require 'net/http'
require 'uri'

include Net

# @author tingram
class DiagnosticsController < ApplicationController

  before_filter :login_required, :admin_access_required

  # Displays diagnostics on service availability
  def index
    @services = Array.new
    @services.push(available?(Service.new('SERVICE_COPYRIGHTSTATUS', SERVICE_COPYRIGHTSTATUS + "/12345")))
    @services.push(available?(Service.new('SERVICE_COLLECTION', SERVICE_COLLECTION + "12345")))
    @services.push(available?(Service.new('SERVICE_CATALOG_SEARCH', SERVICE_CATALOG_SEARCH)))
    @services.push(available?(Service.new('SERVICE_DCM_SEARCH', SERVICE_DCM_SEARCH + "?q=*:*")))
    @services.push(available?(Service.new('SERVICE_RIGHTSHOLDER_SEARCH', SERVICE_RIGHTSHOLDER_SEARCH + "?q=*:*")))
    @services.push(available?(Service.new('SERVICE_TRIM', SERVICE_TRIM + "12345")))
    @services.push(available?(Service.new('SERVICE_NLATHUMB', SERVICE_NLATHUMB + "382365")))
    @services.push(available?(Service.new('SERVICE_VOYAGERDB', SERVICE_VOYAGERDB + "record/12345/authorities")))
    @services.push(available?(Service.new('SERVICE_DCMDB', SERVICE_DCMDB)))
  end

  private

  def available?(service)
    response = Net::HTTP.get_response URI.parse(URI.escape(service.url))
    case response
    when Net::HTTPOK
      service.available = true
    else
      service.available = false
    end
    return service
  end

end

class Service
  attr_accessor :name, :url, :available

  def initialize (name, url)
    @name = name
    @url = url
  end
end
