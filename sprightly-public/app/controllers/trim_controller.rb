#
# Manages requests for Trim references.
# References the TrimRecord Table.
#
# Trim references are created for
# Agreements, Works (Copydetails) & Rightsholder (Party)
#
# @author: tingram
#
class TrimController < ApplicationController
 
  before_filter :login_required, :update_access_required

  # GET /trim
  def new
    @trim = Trimrecord.new

    if !params[:partyid].nil?
      @trim.partyid = params[:partyid]
    end

    if !params[:copydetailsid].nil?
      @trim.copydetailsid = params[:copydetailsid]
    end

    if !params[:agreementid].nil?
      @trim.agreementid = params[:agreementid]
    end
  end

  # GET /trim/1
  def edit
    @trim = Trimrecord.find(params[:id])
  end

  # POST /trim
  def create
    @trim = Trimrecord.new(params[:trim])
    @trim.status_lu_id = StatusLu.active
    @trim.createdate = Date.today
    @trim.createuser = session[:user].id
    @trim.auditdate = Date.today
    @trim.audituser = session[:user].id
    
    if @trim.save
      @msg = 'TRIM Reference successfully created.'
      @msgClass = "success-msg"
      @refreshPageOnSave = false
      @closeDialog = true

      if !@trim.agreementid.nil? then
        @refreshPageOnSave = false
        @closeDialog = true
      end

      render :partial => "common/refresh", :layout => nil
    else
      render :action => "new"
    end
  end

  # PUT /trim
  def update
      @trim = Trimrecord.find(params[:id])
      @trim.auditdate = Date.today
      @trim.audituser = session[:user].id

      if @trim.update_attributes(params[:trim])
        @msg = 'TRIM Reference successfully updated.'
        @msgClass = "success-msg"
        @refreshPageOnSave = false
        @closeDialog = true
        
        render :partial => "common/refresh", :layout => nil
      else
        render :action => "edit"
      end
  end

  # GET /trim/1
  def delete
    @trim = Trimrecord.find(params[:id])
  end

  
  # DELETE /trim/1
  # Soft delete
  def destroy
    @trim = Trimrecord.find(params[:id])
    @trim.status_lu_id = StatusLu.deleted
    @trim.auditdate = Date.today
    @trim.audituser = session[:user].id

    if @trim.save
      @msg = 'TRIM Reference successfully deleted.'
      @msgClass = "success-msg"
      @refreshPageOnSave = false
      @closeDialog = true

      render :partial => "common/refresh", :layout => nil
    else
      render :action => "delete", :id => @trim.get_trimrecordid
    end
  end

  # Lists the Trim References for an agreement
  def list
    @agreementid = params[:id]
    @trimrecords = Trimrecord.find_active_by_agreementid(@agreementid)
    render :action => "_reference_list"
  end
  
  # Returns a HTML fragment to toggle a list of trim references based on the id.
  # The id represents the originalpolicyid in the table.
  def list_toggle
    @agreementid = params[:id]
    @trimrecords = Trimrecord.find_active_by_agreementid(@agreementid)
    render :action => "list_toggle.html"
  end

  def deliver    
    trim = Trimrecord.find(params[:id])
    trim_url = Trimrecord.get_trim_url(trim.trimrefnumber)

    trim_error_msg = "Unable to retrieve TRIM record: " + trim.trimrefnumber + "<p>This may be due to one of the following:</p><ul><li>The TRIM record references a paper file;</li><li>The TRIM record references a restricted file; or</li><li>The TRIM record references a folder (not an individual file).</li></ul><p>Please try accessing the record from the TRIM application.</p>"

    if !trim_url.nil? then
      trim_response = Net::HTTP.get_response(URI.parse(URI.escape(trim_url)))
      if trim_response.nil? then
        render :partial => "common/error.html",:locals=>{:message=>trim_error_msg}
        return
      elsif trim_response.body.length>6 and trim_response.body[0, 6] == "Sorry!" then
        render :partial => "common/error.html",:locals=>{:message=>trim_error_msg}
        return
      end
    else
      render :partial => "common/error.html",:locals=>{:message=>trim_error_msg}
      return
    end
    response.content_type = trim_response.content_type
    render :text => trim_response.body
  end
end