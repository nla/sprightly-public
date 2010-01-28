require "forms/form"
require "forms/multi"
require "forms/manuscripts"
require "forms/pictures"
require "forms/maps"
require "forms/oral"
require "forms/public"

#
# Manages requests for the Agreement Wizard resources
# @author pgiles
#
class WizardController < ApplicationController

  before_filter :login_required, :update_access_required
  helper :all # include all helpers, all the time

  # Confirms if the user wants to create a new agreement
  def confirm_new
    @formtype = params[:formtype]
    if @formtype.nil? then
      @formtype = "multi"
    end
    render :partial => "wizard/confirm_new.html", :layout => false
  end

  # Creates a new agreement
  def new
    @formtype = params[:formtype]
    if @formtype.nil? then
      @formtype = "multi"
    end

    @agreement = Agreement.new
    @agreement.formtype = @formtype;
    @agreement.collection = Agreement.collection_for_formtype(@agreement.formtype)
    @agreement.audituser = session[:user].id
    @agreement.auditdate = Date.today
    @agreement.createdate = Date.today
    @agreement.createuser = session[:user].id
    @agreement.agreementdate = Date.today
    @agreement.status_lu_id = StatusLu.draft
    @agreement.save
    
    redirect_to :controller=>:wizard, :action => "wizard", :id => @agreement.id.to_i
  end

  def wizard
    @page_title = "Agreement Wizard"
    @agreement = Agreement.find(params[:id])
    @copysets = Copyset.find(:all, :conditions=>{:agreementid=>@agreement.agreementid})
  end

  def materials
    @agreement = Agreement.find(params[:id])
    @copysets = Copyset.find(:all, :conditions=>{:agreementid=>@agreement.agreementid})
    render :partial => "wizard/wizard_materials.html", :layout => false
  end

  def edit_materials
    @agreement = Agreement.find(params[:id])
    @copysets = Copyset.find(:all, :conditions=>{:agreementid=>@agreement.agreementid})
    render :partial => "wizard/materials.html", :layout => false
  end

  def update_materials
    @agreement = Agreement.find(params[:id])

    extent = ""

    # Oral Histories
    if @agreement.formtype=='oral' then
      if params[:materials]=="new_from_fields" then
        extent = "[TRC: %s] %s interviewed by %s. Recorded on %s at %s." % [params[:trc_number], params[:interviewee], params[:interviewer], params[:date], params[:place]]
      else
        extent = params[:free_text]
      end

    #All other collection areas...
    else
      if params[:materials] == "all_in_areas"
        extent = "All material in the "
        if @agreement.formtype == "multi" then
          if not params[:collections].blank? then
            extent = extent + params[:collections].join(', ')
            if params[:collections].length>1 then
              extent = extent + " Collections"
            else
              extent = extent + " Collection"
            end
          end
        else
          extent = extent + @agreement.collection_display_label + " Collection"
        end
      elsif params[:materials] == "all_in_library" then
            extent = 'All material in the Library\'s Collections'
      else
        extent = params[:material]
      end
    end

    #process any copypids
    copypids = params[:copypid]
    copypids = copypids.reject{|copypid| copypid==""}
    copypids = copypids.uniq
    #create copyset for agreement
    Copyset.delete_all_for_agreementid(@agreement.agreementid)
    copypids.each do |copypid|
      copydetails = Copydetails.find_by_copypid(copypid)
      copyset = Copyset.new;
      copyset.copydetailsid = copydetails.copydetailsid
      copyset.agreementid = @agreement.agreementid
      copyset.audituser = session[:user].id
      copyset.auditdate = Date.today
      copyset.createdate = Date.today
      copyset.createuser = session[:user].id
      copyset.status_lu_id = StatusLu.active
      copyset.save
    end    

    @agreement.extent = extent

    @agreement.audituser = session[:user].id
    @agreement.auditdate = Date.today

    if @agreement.save then
      @refreshPageOnSave = false
      @closeDialog = true
      @msg = "Agreement materials successfully updated."
      @msgClass = "success-msg"
      render :partial => "common/refresh", :layout => false
    else 
      render :partial => "wizard/materials.html", :layout => false
    end
  end

  # Get a list of rightsholders attached to an agreement
  def rightsholders
    @agreement = Agreement.find(params[:id])
    @rightsholders = Array.new
    @contacts = Hash.new
    Party.find_parties_attached_to_agreement(@agreement.agreementid).each do |party|
      rh = Rightsholder.get_rightsholder_by_partyid(party.partyid)
      @rightsholders.push(rh.clone)
      @contacts[rh.id] = party.active_contacts
    end

    render :partial => "wizard/wizard_rights_holders.html", :layout => false
  end

  # Adds a rightsholder to an agreement
  def add_rights_holder
    @agreement = Agreement.find(params[:id])
    @page_source = "wizard"
    render :partial => "wizard/add_rights_holder.html", :layout => false
  end

  # Form to create a new rightsholder and attach to an agreement
  def new_rights_holder
    @agreement = Agreement.find(params[:id])
    @party = Party.new
    if params[:type]!=nil and params[:type].length > 0 then
      @rightsholder_type = params[:type]
    else
      @rightsholder_type = nil
    end
    render :partial => "wizard/new_rights_holder.html", :layout => false
  end

  def relationships
    @agreement = Agreement.find(params[:id])
    @rightsholders = Array.new
    Party.find_parties_attached_to_agreement(@agreement.agreementid).each do |party|
      rh = Rightsholder.get_rightsholder_by_partyid(party.partyid)
      @rightsholders.push(rh.clone)
    end
    render :partial => "wizard/wizard_relationships.html", :layout => false
  end

  # The "Instructions for Access and Use" accordion
  def permissions
    @agreement = Agreement.find(params[:id])
    @agreementid = params[:id]
    @permissions = @agreement.active_permissions 
    render :partial => "wizard/wizard_permissions.html", :layout => false
  end

  # The "Agreement details" accordion
  def admin
    @agreement = Agreement.find(params[:id])
    @trimrecords = @agreement.active_trimrecords
    render :partial => "wizard/wizard_admin.html", :layout => false
  end

  # Render the 'Intructions for use and access' Questions
  def question
    @agreement = Agreement.find(params[:id])
    @qid = params[:qid]
    render :partial => "wizard/wizard_question.html", :layout => false
  end

  # Generate Permissions and Policies based on questions answered for the
  # 'Intructions for use and access'
  def answer
    @agreement = Agreement.find(params[:id])
    @qid = params[:qid]

    case @agreement.formtype
    when "multi" then process_form_answers(Multi.new, params)
    when "public" then process_form_answers(Public.new, params)
    when "pictures" then process_form_answers(Pictures.new, params)
    when "maps" then process_form_answers(Maps.new, params)
    when "oral" then process_form_answers(Oral.new, params)
    when "manuscripts" then process_form_answers(Manuscripts.new, params)
    else render :partial => "common/error.html"
    end
  end

  # Attaches a Rightsholder to an agreement by creating
  # new entry in the PartyAgreement table
  def attach_rights_holder
    @agreement = Agreement.find(params[:id])
    
    rightsholderid = params[:rightsholderid]
    party = Party.get_party(rightsholderid)

    party_agreement = Partyagreement.new
    party_agreement.status_lu_id = 1
    party_agreement.partyid = party.partyid
    party_agreement.agreementid = @agreement.agreementid
    party_agreement.createdate = Date.today
    party_agreement.createuser = session[:user].id
    party_agreement.auditdate = Date.today
    party_agreement.audituser = session[:user].id
    
    if party_agreement.save then
      @refreshPageOnSave = false
      @closeDialog = true
      @msg = "Rights Holder successfully added to Agreement."
      @msgClass = "success-msg"
      render :partial => "common/refresh", :layout => false
    #else
    #  render :partial => ???
    #end
    end
  end

  # Detaches a Rightsholder from an agreement by deleting
  # the entry in the PartyAgreement table
  def detach_rights_holder
    @agreement = Agreement.find(params[:id])
    @rightsholderid = params[:rightsholderid]

    if request.post? then
      party = Party.get_party(@rightsholderid)
      party_agreements = Partyagreement.find(:all, :conditions=>{:partyid=>party.partyid, :agreementid=>@agreement.agreementid})

      party_agreements.each { |party_agreement|
        party_agreement.delete
      }

      @msg = "Rights Holder successfully detached from Agreement."
      @msgClass = "success-msg"
      @refreshPageOnSave = false
      @closeDialog = true
      render :partial => "common/refresh", :layout => false
    else
      render :partial => "wizard/detach_rights_holder.html", :layout => false
    end
  end

   def add_relationship
      @agreement = Agreement.find(params[:id])
      @relationshipTypes = RelationshipLu.all_ordered_by_label
      @rightsholderA = Rightsholder.get_rightsholder_by_partyid(params[:partyid])
      @rightsholders = Array.new
      Party.find_parties_attached_to_agreement(@agreement.agreementid).each do |party|
        rh = Rightsholder.get_rightsholder_by_partyid(party.partyid)
        if (not rh.id.eql?(@rightsholderA.id)) then
          @rightsholders.push(rh.clone)
        end
      end
      render :partial => "wizard/add_relationship", :layout => false
   end

   def add_role
      @agreement = Agreement.find(params[:id])
      @roleTypes = RoleLu.all_ordered_by_label
      @rightsholder = Rightsholder.new(params[:rightsholderid])
      @copysets = Copyset.find(:all, :conditions=>{:agreementid=>@agreement.agreementid})
      render :partial => "wizard/add_role", :layout => false
   end

   private

   # Calls the appropriate form and proccesses the answers
   def process_form_answers(form, params)
      form.process_question(@agreement.id, @qid, params, session[:user].id)

      if form.error then
        #Handle error
        @qid = form.qid.to_s
        render :partial => "wizard/wizard_question.html", :layout => false
      else
        #Handle Success
        @msg = "<p><b>Question "+@qid.to_s+" Answered. </b></p>"
        if form.permission_count > 0 then
          @msg += "<p>" + form.permission_count.to_s + " Permissions Created.</p>"
        end
        if not form.message.blank? then
          @msg += "<p>" + form.message + "</p>"
        end
        @msgClass = "success-msg"
        @closeDialog = true
        @refreshPageOnSave = false
        render :partial => "common/refresh"
      end
   end

end
