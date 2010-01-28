require 'net/http'
require 'rexml/document'
include REXML

# Represents a work from DCM.
# It uses the SERVICE_COLLECTION to get the work.
class DcmWork

  attr_accessor :title, :creator, :bib_id, :pi, :parentpid, :bibid, :rightsholders, :workxml_doc

  # Retrieve a work from DCM using the SERVICE_COLLECTION based on a
  # DCM workpid
  def initialize(workpid)
    response = Net::HTTP.get_response URI.parse(URI.escape(SERVICE_COLLECTION + workpid))
    case response
      when Net::HTTPSuccess
        @workxml_doc = Document.new(response.body)
        @title = Util::XmlUtil.get_node_text(@workxml_doc, "//title")
        @creator = Util::XmlUtil.get_node_text(@workxml_doc, "//creator")
        @bib_id = Util::XmlUtil.get_node_text(@workxml_doc, "//bibId")
        @pi = Util::XmlUtil.get_node_text(@workxml_doc, "//pi")
        @parentpid = Util::XmlUtil.get_node_text(@workxml_doc, "//parentPid")
        @bibid = get_bibid(Util::XmlUtil.get_node_text(@workxml_doc, "//recordSource"), Util::XmlUtil.get_node_text(@workxml_doc, "//bibId"))
    end
  end

  private

  def get_rightsholders(bib_id)
    if !bib_id.nil?
      catalogue_work = CatalogueWork.new(bib_id)
      catalogue_work.add_rightsholders
      return catalogue_work.rightsholders
    end
  end

  def get_bibid(recordsource, bib_id)
    if !bib_id.nil? && !recordsource.nil? && recordsource.include?("VOYAGER")
      return bib_id
    elsif !@parentpid.nil?
      # Recusively look for the bibid
    else
      return nil
    end
  end

end