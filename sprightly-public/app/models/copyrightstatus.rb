require 'net/http'
require 'rexml/document'
include REXML

class Copyrightstatus

  attr_accessor :creatorAliveStatus, :creatorDateOfDeath, :copyrightStatusReason, :creationDate,
                :materialType, :publicationDate, :publishedStatus, :govtCopyrightOwnership, :copyrightStatus

  # Calculates the copyright of an item based on the pi
  def determine(pi)
    query = SERVICE_COPYRIGHTSTATUS + "/" + pi
    response = Net::HTTP.get_response(URI.parse(URI.escape(query)))

    case response
      when Net::HTTPSuccess
        instantiate_from_reponse_from_copyrightstatusservice(response.body)
      else
        @copyrightStatus = "Undetermined"
        @copyrightStatusReason = "There is no catalogue record" #response.message
    end
  end

  private

  # This populates the relevant accessors based on succesful query of
  # the SERVICE_COPYRIGHTSTATUS
  def instantiate_from_reponse_from_copyrightstatusservice(response_body)
    response = Document.new(response_body)
    @creatorAliveStatus = XPath.first(response, "//creatorAliveStatus").text
    @creatorDateOfDeath = XPath.first(response, "//creatorDateOfDeath").text
    @copyrightStatusReason = XPath.first(response, "//copyrightStatusReason").text
    @creationDate = XPath.first(response, "//creationDate").text
    @materialType = XPath.first(response, "//materialType").text
    @publicationDate = XPath.first(response, "//publicationDate").text
    @publishedStatus = XPath.first(response, "//publishedStatus").text
    @govtCopyrightOwnership = XPath.first(response, "//govtCopyrightOwnership").text
    @copyrightStatus = XPath.first(response, "//copyrightStatus").text
  end

end
