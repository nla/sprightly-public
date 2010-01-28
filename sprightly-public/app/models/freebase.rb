# An attempt tp query www.freebase.com for thumbnail pictures of people
#
# @author tingram
class Freebase

  attr_accessor :src, :id

  def initialize(query_response)
    response = ActiveSupport::JSON.decode(query_response)
    result = response['result']

    if !result.nil?
      @src = "http://www.freebase.com/api/trans/image_thumb/guid/" + result['guid'].sub("#", "") + "?maxwidth=200&maxheight=200"
      @id = "http://www.freebase.com/view" + result['id']
    end

  end

  # Queries freebase and returns a json object whicj is then used to retrieve the image
  # Currently only retrives images for people
  # Must have a birthdate for this method otherwise rturns nil
  def self.get(name, life_dates)

    options = Hash.new
    options["limit"] = 1
    options["id"] = nil
    options["guid"] = nil
    options["type"] = "/people/person"

    return nil if life_dates.nil? || life_dates.empty?

    if life_dates.match(/^\d\d\d\d/)
      birthdate = life_dates.match(/^\d\d\d\d/).to_s
      options["/people/person/date_of_birth>="] = birthdate + "-01-01"
      options["/people/person/date_of_birth<="] = birthdate + "-12-31"
    end
    
    if life_dates.match(/-\d\d\d\d/)
      deathdate = life_dates.match(/-\d\d\d\d/).to_s.gsub(/-/, "")
      options["/people/deceased_person/date_of_death>="] = deathdate + "-01-01"
      options["/people/deceased_person/date_of_death<="] = deathdate + "-12-31"
    end

    names = name.split(',')
    if names.size == 0
      return nil
    elsif names.size == 1
      options["name"] = name
    else
      options["name"] = names[1] + " " + names[0]
    end

    query = Hash.new
    query["query"] = options
    
    q = "http://api.freebase.com/api/service/mqlread?query=" + ActiveSupport::JSON.encode(query)
    response = Net::HTTP.get_response(URI.parse(URI.escape(q)))
    self.new(response.body)
  end

end