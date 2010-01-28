# Simple breadcrumb
#
# @author tingram
#
class Breadcrumb

  attr_accessor :name, :url

  def initialize(name, url)
    @name = name
    @url = url
  end

end