#
# Manages requests on Rights Holders.
#
# @author: tingram
#
class RightsholdersController < ApplicationController

  before_filter :login_required
  before_filter :update_access_required, :only => [:new, :create, :add_works]

  # GET /rightsholders/new
  # Display form to create new RMS rightsholder
  def new
    @party = Party.new
    if params[:type]!=nil and params[:type].length > 0  then
      @rightsholder_type = params[:type]
    else
      @rightsholder_type = nil
    end
    render :action => "new.html"
  end

   # POST /rightsholders
   # Used by standard Rights Holder add action and in the Wizard Attach Rights
   # Holder... if agreementid is present, then create the link between the
   # new party and the agreement.
  def create
    @party = Party.new(params[:party])
    @party.status_lu_id = StatusLu.active
    @party.createdate = Date.today
    @party.createuser = session[:user].id
    @party.auditdate = Date.today
    @party.audituser = session[:user].id

    if @party.save
      Util::RightsholderSearchUtil.add_rightsholder_to_search(@party.partyid, @party.forename, @party.surname, @party.birthdate, @party.deathdate, @party.familyname, @party.corporatename)

      @msg = 'The Rightsholder was successfully created.'
      @msgClass = "success"

      if (params[:agreementid]) then
          party_agreement = Partyagreement.new
          party_agreement.status_lu_id = 1
          party_agreement.partyid = @party.partyid
          party_agreement.agreementid = params[:agreementid]
          party_agreement.createdate = Date.today
          party_agreement.createuser = session[:user].id
          party_agreement.auditdate = Date.today
          party_agreement.audituser = session[:user].id
          if party_agreement.save then
              @msg = 'The Rightsholder was successfully created and attached to the agreement.'
          else
              @msg = 'The Rightsholder was successfully created but was not linked to the agreement.  Please try searching for the new rightsholder and attach to the agreement again.'
              @msgClass = "error"
          end
      end

      @refreshPageOnSave = false
      @closeDialog = false
      render :partial => "common/refresh", :layout => nil
    else
      render :action => "new.html"
    end

  end

  # GET /rightsholders/edit/:id
  # Used by standard Rights Holder edit action
  def edit
    @party = Party.find(params[:id])
    if not @party.corporatename.blank? then
      @rightsholder_type = "organisation"
    elsif not @party.familyname.blank? then
      @rightsholder_type = "family"
    else
      @rightsholder_type = "individual"
    end
    render :action => "edit.html"
  end
   # POST /rightsholders
   # Used by standard Rights Holder edit action
  def update
    @party = Party.find(params[:id])

    @party.auditdate = Date.today
    @party.audituser = session[:user].id

    if @party.update_attributes(params[:party])
      Util::RightsholderSearchUtil.add_rightsholder_to_search(@party.partyid, @party.forename, @party.surname, @party.birthdate, @party.deathdate, @party.familyname, @party.corporatename)

      @msg = 'The Rightsholder was successfully updated.'
      @msgClass = "success-msg"

      @refreshPageOnSave = true
      @closeDialog = true
      render :partial => "common/refresh", :layout => nil
    else
      render :action => "edit.html"
    end
    #render :partial=>"common/todo.html",:layout=>nil
  end

  # Shows the details of a Rights Holder
  # The id will be in the format:
  #  authid-12345
  #  partyid-12345
  def show
    @id = params[:id]
    @source = "rightsholder"
    @rightsholder = Rightsholder.new(@id)
    @page_title = "[RH] " + @rightsholder.name
    @party = Party.get_party(@id)

    # Data required to display counts
    @active_agreements = Agreement.find_active_by_partyid(@party.partyid.to_i)
    @archived_agreements = Agreement.find_archived_by_partyid(@party.get_partyid)
    
    @roles = @party.active_roles
    @delegators = @party.active_delagators
    @delegatees = @party.active_delagatees
    @related_works = get_related_voyager_works(@rightsholder.authorityid)

    
    add_breadcrumb(@rightsholder.name)

    @includeDojo = true;
  end

  # Shows only the details of a Rights Holder
  # The id will be in the format:
  #  authid-12345
  #  partyid-12345
  def show_details
    @id = params[:id]
    @rightsholder = Rightsholder.new(@id)
    @party = Party.get_party(@id)
    @notes = @party.active_notes
    @contacts = @party.active_contacts
    @trimrecords = @party.active_trimrecords
    render :partial => "details.html"
  end

  # Shows only the agreements of a Rights Holder
  def show_agreements
    @id = params[:id]
    @rightsholder = Rightsholder.new(@id)
    @party = Party.get_party(@id)
    @active_agreements = Agreement.find_active_by_partyid(@party.get_partyid)
    @archived_agreements = Agreement.find_archived_by_partyid(@party.get_partyid)
    @all_agreements = []
    @all_agreements.concat(@active_agreements)
    @all_agreements.concat(@archived_agreements)
    render :partial => "agreements.html"
  end

  # Shows only the roles/relationships of a Rights Holder
  def show_roles
    @id = params[:id]
    # Get the Identity and Contact Details
    @rightsholder = Rightsholder.new(@id)
    @party = Party.get_party(@id)
    @roles = @party.active_roles
    @delegators = @party.active_delagators
    @delegatees = @party.active_delagatees
    @rightsholders = Relationship.get_rightsholders_in_relationship(@delegators, @delegatees)
    @related_works = get_related_voyager_works(@rightsholder.authorityid)
    render :partial => "roles.html"
  end

  # Shows the works for the id [Identity]
  def show_works
    @id = params[:id]
    @rightsholder = Rightsholder.new(@id)
    @related_works = get_related_voyager_works(@rightsholder.authorityid)
    render :partial => "related_works_list"
  end

  # Returns a partial with a listing of the bibrecords / works that are linked
  # to a rights holder using the
  # @param id: authorityid
  # @param start: start position within the related works list array
  def show_related_works
    @authorityid = params[:id]
    @start = 0 if params[:start].nil?
    @start = params[:start].to_i

    @related_works = get_related_voyager_works(@authorityid)
    @rows = 5
    @rows = @related_works.size if @related_works.size < 5

    @works = Array.new
    (@start..@start+@rows-1).each { |i| @works.push(CatalogueWork.new(@related_works[i])) }
    @rows = 5

    render :partial => "related_works_list"
  end

  #Allow edit of the thumbnail associated to the rightsholder
  def edit_thumbnail
    @rightsholder = Rightsholder.new(params[:id])
    @copypid = ""
    render :partial=> "edit_thumbnail"
  end

  #Allow update of the thumbnail associated to the rightsholder
  def update_thumbnail
    @party = Party.get_party(params[:id])
    @party.image = params[:copypid_validated]

    if @party.save then
      @msg = 'The Rightsholder Thumbnail was successfully updated.'
      @msgClass = "success-msg"
      @closeDialog = true
    else
      @msg = 'Unable to update thumbnail'
      @msgClass = "error-msg"
      @closeDialog = false
    end

    @refreshPageOnSave = false
    render :partial => "common/refresh", :layout => nil
  end

  #Validate the thumbnail PI
  def validate_thumbnail
    @copypid = params[:copypid]

    @valid = false
    if (!Copydetails.validate(@copypid).nil?) then
        @valid = true
    end

    render :partial => "rightsholders/validate_thumbnail_message.html", :layout => nil
  end

  # Searches freebase for a thumnail of the rightsholder and
  # returns the img tag.
  # WARNING VERY ALPHA
  def thumbnail
    @party = Party.get_party(params[:id])
    @rightholderid = params[:id]
    @image = nil
    if @party.image.blank?
      freebase = Freebase.get(params[:name], params[:life_dates])
      @image = RightsholderImage.new(freebase.id, freebase.src) if !freebase.blank?
    else
      @image = RightsholderImage.new("http://nla.gov.au/" + @party.image, "http://nla.gov.au/" + @party.image.strip + "-t")
    end

  end

  def search
    @rows = SEARCH_RESULT_MAX_PAGE_DISPLAY

    if params[:q] != nil
      @source = params[:source]
      @query = params[:q]
      @start = params[:start]
    end

      callback = params[:callback]
      parent_selector = params[:parent_selector]

    if @start == nil
        @start = 0
    end

    if (@query!=nil and @query.length>0) then
      @server = SERVICE_RIGHTSHOLDER_SEARCH
      @solr_response = perform_solr_search(@server, format_query(@query), @start, @rows)
    end
    if params[:page_source]=="wizard" then
      @page_source = "wizard"
      render :partial => "search_and_select", :locals=>{:js_callback=>callback,:parent_selector=>parent_selector, :show_create_rightsholder_button=>true, :create_rightsholder_action=>"openCreateRightsholderPanel()"}
    else
      render :partial => "search_and_select", :locals=>{:js_callback=>callback,:parent_selector=>parent_selector}
    end
  end

  def worksearch
    @rows = SEARCH_RESULT_MAX_PAGE_DISPLAY

    if params[:q] != nil
      @source = params[:source]
      @query = params[:q]
      @start = params[:start]
    end

    if @start == nil
        @start = 0
    end

    @solr_response = case @source
        when "catalogue" then @service = SERVICE_CATALOG_SEARCH
                          SolrResponse.new_query(SERVICE_CATALOG_SEARCH, @query, @start, @rows, "")

        when "dcm" then @service = SERVICE_DCM_SEARCH
                    SolrResponse.new_query(SERVICE_DCM_SEARCH, @query, @start, @rows, "")
    end
    render :partial => "worksearch"
  end

  def add_works
    @workIds = params[:id]
    puts "Ids: " + @workIds.to_s
    render :text =>  "WORDIZZLE"
  end

  # Shows the details of a Rights Holder in a print friendly manner
  def print
    @id = params[:id]
    @source = "rightsholder"

    session[:id] = @id
    session[:source] = @source

    @rightsholder = Rightsholder.new(@id)
    @page_title = "[RH] "+@rightsholder.name
    @party = Party.get_party(@id)
    @contacts = @party.active_contacts
    @notes = @party.active_notes
    @trimrecords = @party.active_trimrecords
    @active_agreements = Agreement.find_active_by_partyid(@party.get_partyid)
    @archived_agreements = Agreement.find_archived_by_partyid(@party.get_partyid)
    @all_agreements = []
    @all_agreements.concat(@active_agreements)
    @all_agreements.concat(@archived_agreements)
    @roles = @party.active_roles
    @delegators = @party.active_delagators
    @delegatees = @party.active_delagatees
    @rightsholders = Relationship.get_rightsholders_in_relationship(@delegators, @delegatees)
    @related_works = get_related_voyager_works(@rightsholder.authorityid)

     render :action => "print", :layout => "print"
  end


  def check_duplicates
    case params[:party_type]
    when "individual" then
      query = params[:party][:forename] + " " + params[:party][:surname]
    when "family" then
      query = params[:party][:familyname]
    when "organisation" then
      query = params[:party][:corporatename]
    end

    if not query.blank? then
      @source = "rightsholder"
      @server = SERVICE_RIGHTSHOLDER_SEARCH
      @solr_response = perform_solr_search(@server, format_query(query), 0, 1000)
    end
    render :partial => "rightsholders/checked_duplicates_message.html"
  end

  def business_card
    @rightsholder = Rightsholder.new(params[:id])
    @party = Party.get_party(@rightsholder.id)
    @active_agreements = Agreement.find_active_by_partyid(@party.get_partyid)

    render :partial => "rightsholders/business_card.html"
  end

  def agreement_count
    rightsholder = Rightsholder.new(params[:id])
    party = Party.get_party(rightsholder.id)
    active_agreements = Agreement.find_active_by_partyid(party.get_partyid)
    #render :partial => "rightsholders/summary.html", :locals=>{:agreements=>active_agreements,:party=>party,:rightsholder=>rightsholder, :display_link_to_agreements=>true}
    render :text => active_agreements.length
  end


  private

  # Retrieves a list of bibid's based on the authority_id
  def get_related_voyager_works(authority_id)

    if authority_id.nil?
      return nil
    end

    related_works = Array.new
    response = Net::HTTP.get_response URI.parse(URI.escape(SERVICE_VOYAGERDB + "authority/" + authority_id + "/records"))
    case response
      when Net::HTTPSuccess
        doc =  Document.new(response.body)
        XPath.each(doc, "//bibid") { |el| related_works.push(el.text) }
    end

    return related_works
  end

  def perform_solr_search(server, query, start, rows)
    return SolrResponse.new_query(server, format_query(query), start, rows,  "&sort=name asc")
  end

end

class RightsholderImage
  attr_accessor :id, :src

  def initialize(id, src)
    @id = id
    @src = src
  end
end
