#
# Manages requests for Agreement resources
#
#
class AgreementController < ApplicationController

  before_filter :login_required
  before_filter :update_access_required, :except => :show

  helper :all # include all helpers, all the time

  def edit
    @agreement = Agreement.find(params[:id])
  end

  def update_details
    @agreement = Agreement.find(params[:id])
    @agreement.attributes=(params[:agreement])

    @agreement.audituser = session[:user].id
    @agreement.auditdate = Date.today

    if @agreement.save then
      @msg = "Agreement details successfully updated."
      @msgClass = "success-msg"
      @refreshPageOnSave = false
      @closeDialog = true
      render :partial => "common/refresh", :layout => nil
    else
      render :action => "edit", :layout => nil
    end
  end

  # Displays details of an agreement: Permissions and Trim References
  def show
    @agreementid = params[:id]
    @agreement = Agreement.find(@agreementid)
    @copysets = Copyset.find(:all, :conditions=>{:agreementid=>@agreement.agreementid})
    @trimrecords = @agreement.active_trimrecords
    @permissions = @agreement.active_permissions 
    @rightsholders = Array.new
    Party.find_parties_attached_to_agreement(@agreement.agreementid).each do |party|
      rh = Rightsholder.get_rightsholder_by_partyid(party.partyid)
      @rightsholders.push(rh.clone)
    end
    render "show.html"
  end

  # Provides a lists of all Agreements created by the current user that are still in draft/active/archived
  def work_tray
     @page_title = "Work Tray"
     add_breadcrumb(@page_title)
     @drafts = Agreement.find_drafts_for_user(session[:user].id)
     #@submitted = Agreement.find_submitted_for_user(session[:user].id)
     #@archived = Agreement.find_archived_for_user(session[:user].id)
  end

   # Provides a list of all Agreements created by the current user that are still in particular state
  def work_tray_listing
     @page_title = "Work Tray"
     add_breadcrumb(@page_title)

     agreements = []
     status = params[:status]

     if status == "draft" then
        agreements = Agreement.find_drafts_for_user(session[:user].id)
     elsif status == "submitted" then
        agreements = Agreement.find_submitted_for_user(session[:user].id)
        filter = params[:filter]
     elsif status == "archived" then
        agreements = Agreement.find_archived_for_user(session[:user].id)
     elsif status == "alldrafts" then
       agreements = Agreement.find_all_drafts()
     end

     render :partial=>"agreement/work_tray_list.html", :locals=>{:status=>status,:agreements=>agreements, :filter=>filter}
  end

   def delete
    @agreement = Agreement.find(params[:id])
    if params[:from_wizard]!=nil && params[:from_wizard]=="true" then
      @from_wizard=true;
    else
      @from_wizard=false;
    end
   end

   def delete_agreement
     @agreement = Agreement.find(params[:id])
     @agreement.status_lu_id = StatusLu.deleted

     @agreement.audituser = session[:user].id
     @agreement.auditdate = Date.today

     if @agreement.save then
        if params[:from_wizard]!=nil && params[:from_wizard]=="true" then
          @redirect_page_on_save = true
          @msg = "Agreement successfully deleted."
          @msgClass = "success-msg"
          @redirect_url = url_for :controller=>'agreement', :action=>"work_tray", :id=>-1
          render :partial => "common/refresh", :layout => nil
        else
          @refreshPageOnSave = false
          @closeDialog = true
          @msg = "Agreement successfully deleted."
          @msgClass = "success-msg"
          render :partial => "common/refresh", :layout => nil
        end
     else       
        render :action => "wizard", :id=>@agreement.id.to_int
     end
   end

   def archive
    @agreement = Agreement.find(params[:id])

    @from_wizard=false;

    if params[:from_wizard]!=nil && params[:from_wizard]=="true" then
      @from_wizard=true;    
    end
    
   end

   def archive_agreement
     @agreement = Agreement.find(params[:id])
     @agreement.status_lu_id = StatusLu.archived

     @agreement.audituser = session[:user].id
     @agreement.auditdate = Date.today

     if @agreement.save then
       if params[:from_wizard]!=nil && params[:from_wizard]=="true" then
          @redirect_page_on_save = true
          @msg = "Success."
          @msgClass = "success"
          @redirect_url = url_for :controller=>'agreement', :action=>"work_tray", :id=>-1, :anchor=>"wtArchived"
          render :partial => "common/refresh", :layout => nil
       elsif params[:_method]=="delete" then
          @refreshPageOnSave = false
          @closeDialog = true
          @msg = "Agreement successfully archived."
          @msgClass = "success-msg"
          render :partial => "common/refresh", :layout => nil
       else
         redirect_to :action => "work_tray", :id=>@agreement.id.to_int, :anchor=>"wtArchived"
       end
     else
       if params[:_method]=="delete" then
          @refreshPageOnSave = true
          @closeDialog = false
          @msg = "Delete failed"
          @msgClass = "error"
          render :partial => "common/refresh", :layout => nil
       else
        render :action => "wizard", :id=>@agreement.id.to_int
       end
     end
   end


   def activate_agreement
     @agreement = Agreement.find(params[:id])
     @agreement.status_lu_id = StatusLu.active

     @agreement.audituser = session[:user].id
     @agreement.auditdate = Date.today

     if @agreement.save then
       redirect_to :action => "work_tray", :id=>@agreement.id.to_int, :anchor=>"wtActive"
     else
       render :action => "wizard", :id=>@agreement.id.to_int
     end
   end

   def mark_as_draft
     @agreement = Agreement.find(params[:id])
     @agreement.status_lu_id = StatusLu.draft

     @agreement.audituser = session[:user].id
     @agreement.auditdate = Date.today

     if @agreement.save then
       redirect_to :action => "work_tray", :id=>@agreement.id.to_int, :anchor=>"wtDraft"
     else
       render :action => "wizard", :id=>@agreement.id.to_int
     end
   end

   private

    def render_refresh_page
      @closeDialog = true
      @refreshPageOnSave = false
      render :partial => "common/refresh"
    end

end
