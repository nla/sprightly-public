require 'rexml/document'
include REXML

#
# Manages requests details on Works - Catalogue items and DCM (Digitised) works.
#
# @author: tingram
#
class WorksController < ApplicationController

  before_filter :login_required
  
  def show
    @source = params[:source]
    @id = fix_id(params[:id], params[:format], params[:extra])
    @copydetails = get_copydetails(@id)
    @includeDojo = true;

    if @copydetails.nil?
      render :partial => "common/error.html"
    else

      case @source
        when "catalogue" then
          @work = CatalogueWork.new(@id)
          @work.add_rightsholders
        when "dcm" then
          @work = DcmWork.new(@id)
      end

      session[:source] = @source
      @page_title = "[Work] "+@work.title
      add_breadcrumb(@work.title)
      @active_agreements = Agreement.find_active_linked_to_work(@copydetails.copypid)
      @archived_agreements = Agreement.find_archived_linked_to_work(@copydetails.copypid)
      render "show.html", :layout => 'application.html'
    end
  end

  def print
    @source = params[:source]
    @id = fix_id(params[:id], params[:format], params[:extra])
    @copydetails = get_copydetails(@id)

    if @copydetails.nil?
      render :partial => "common/error.html"
      return
    else

      case @source
        when "catalogue" then
          @work = CatalogueWork.new(@id)
          @work.add_rightsholders
        when "dcm" then
          @work = DcmWork.new(@id)
      end

      session[:source] = @source

      @page_title = "[Work] "+@work.title

      @copyrightstatus = Copyrightstatus.new
      @copyrightstatus.determine(@id)
      @base_policy = get_base_policy(@work)
      @trimrecords = @copydetails.active_trimrecords
      @library_decision = @copydetails.library_decision
      @roles = Role.find_roles_linked_to_work(@copydetails.copypid)
      @rightsholders_from_roles = get_rightholders_from_roles(@roles)
      @active_agreements = Agreement.find_active_linked_to_work(@copydetails.copypid)
      @rightsholders_from_agreements = get_rightsholders_from_agreements(@active_agreements)
    end

    render :action => "print", :layout => "print"
  end

  def show_details
      @source = params[:source]
      @id = fix_id(params[:id], params[:format], params[:extra])
      @copydetails = get_copydetails(@id)

      if @copydetails.nil?
        render :partial => "common/error.html"
        return
      end

      case @source
        when "catalogue" then
          @work = CatalogueWork.new(@id)
          @work.add_rightsholders
        when "dcm" then
          @work = DcmWork.new(@id)
      end

      @copyrightstatus = Copyrightstatus.new
      @copyrightstatus.determine(@id)

      @base_policy = get_base_policy(@work)
      @trimrecords = @copydetails.active_trimrecords
      @library_decision = @copydetails.library_decision
      @roles = Role.find_roles_linked_to_work(@copydetails.copypid)
      @rightsholders_from_roles = get_rightholders_from_roles(@roles)

      @active_agreements = Agreement.find_active_linked_to_work(@copydetails.copypid)
      @rightsholders_from_agreements = get_rightsholders_from_agreements(@active_agreements)

      render :partial => "details.html"
  end

  def show_agreements
    @source = params[:source]
    @id = fix_id(params[:id], params[:format], params[:extra])
  
    @copydetails = get_copydetails(@id)
    @active_agreements = Agreement.find_active_linked_to_work(@copydetails.copypid)
    @archived_agreements = Agreement.find_archived_linked_to_work(@copydetails.copypid)

    @all_agreements = []
    @all_agreements.concat(@active_agreements)
    @all_agreements.concat(@archived_agreements)

    @rightholders_from_agreements = get_rightsholders_from_agreements(@all_agreements)

    render :partial => "agreements.html"
  end

  # Renders a partial of all the children of an id.
  # This is sepcific to returning a list of children
  # within DCM.
  def children
    @id = fix_id(params[:id], params[:format], params[:extra])
    if params[:root]=="source" then
      @isRoot = true;
      @work = DcmWork.new(@id)
      @children = [@work.pi]
    else
      @isRoot = false;
      @children = get_children("nla."+params[:root])
    end
    render :action => "children.json"
  end

   def add_work_resolver
      render :partial=>"works/work_resolver_item.html"
   end

   # Validates a work
   def validate_work
      copypid = params[:copypid].strip
      if (!Copydetails.validate(copypid).nil?) then
        copypid_validated = copypid
        valid = true
        copytitle = copypid
        shownew = true
      else
        copypid_validated = nil
        valid = false
        copytitle = nil
        shownew = false
      end
      render :partial=>"works/work_resolver_item.html", :locals=>{:copypid=>copypid,:copypid_validated=>copypid_validated,:valid=>valid,:copytitle=>copytitle,:shownew=>shownew,:just_validated=>true}
   end


  private

  # Deals with the rouing issue dealing with a "." in a nla.xxx pi
  # Rails drops the remainder of the pi in the fomat param, so this method
  # concats them together
  def fix_id(id, format, extra)
     id << "." + format if !format.blank?
     id << "." + extra if !extra.blank?
     return id
  end

  # Iterates through the list of roles and gets the identity information
  def get_rightholders_from_roles(roles)
    rightholders = Hash.new
    roles.each do |role|
      rightholders[role.partyid.to_i] = Rightsholder.get_rightsholder_by_partyid(role.partyid)
    end
    return rightholders
  end

  # Iterates through the list of agreements and gets the identity information
  def get_rightsholders_from_agreements(agreements)
    rightsholders = []
    agreements.each { |agreement|
      parties = Party.find_parties_attached_to_agreement(agreement.agreementid)
      parties.each { |party|
        rightsholders.push(Rightsholder.get_rightsholder_by_partyid(party.partyid))
      }
    }
    return rightsholders
  end

  # Searches DCM and returns a list of all the children of a pi.
  #
  # @param pi The DCM workpid
  def get_children(pi)
    response = Net::HTTP.get_response URI.parse(URI.escape(SERVICE_DCMDB + "work/" + pi + "/children"))
    children = Array.new
    case response
      when Net::HTTPSuccess
        doc =  Document.new(response.body)
        XPath.each(doc, "//workpid") { |el|
          children.push(el.text)
        }         
    end

    return children

  end

  # Searches for a COPYDETAILS record based on the id.
  # If the record does not exist, it's added to the database
  #
  # @param id Bibid or DCM workpid
  def get_copydetails(id)

    if @source.eql?("catalogue") && !id.match(/^nla.cat-vn/)
      id = "nla.cat-vn" + id
    end
    
    return Copydetails.validate(id)
  end

  # If a work has a bib_id get the bib record
  # check for contents of 506 field
  def get_base_policy(work)
    if work.bib_id.nil? || work.bib_id.empty?
      return nil
    else
      catalogue = CatalogueWork.new(work.bib_id)
      return catalogue.get_marcxml_datafield("506")
    end
  end
end
