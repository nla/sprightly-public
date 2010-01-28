class RolesController < ApplicationController

  before_filter :login_required, :update_access_required

  # It shows all rightsholders with roles
  def index
    @roles = Role.find(:all, :conditions => { :status_lu_id => StatusLu.active} )
  end

  def create
    party = Party.get_party(params[:rightsholderid])
    role_lu_ids = params[:role_lu_id]
    copypids = params[:copypid]
    if !copypids.nil? then
      copypids = copypids.uniq
      copypids = copypids.reject { |id|id.nil? or id.length==0 }
    else
      copypids = []
    end

    if role_lu_ids.nil? or role_lu_ids.length==0 then
      @msg = 'Please select a Role Type'
      @msgClass = "error-msg"
      @roleTypes = RoleLu.all_ordered_by_label
      @rightsholder = Rightsholder.new(params[:rightsholderid])
      @copysets = []
      if params[:agreementid].blank? then
        render :action=>:new
      else
        @agreement = Agreement.find(params[:agreementid])
        render :partial=>"wizard/add_role.html"
      end
      return
    end

    role_lu_ids.each { |role_lu_id|
      role = Role.new
      role.role_lu_id = role_lu_id
      role.partyid = party.partyid
      role.audituser = session[:user].id
      role.auditdate = Date.today
      role.createdate = Date.today
      role.createuser = session[:user].id
      role.status_lu_id = StatusLu.active
      role.save

      copypids.each { |copypid|
        copydetails = Copydetails.find_by_copypid(copypid)
        copyset = Copyset.new;
        copyset.copydetailsid = copydetails.copydetailsid
        copyset.roleid = role.roleid
        copyset.audituser = session[:user].id
        copyset.auditdate = Date.today
        copyset.createdate = Date.today
        copyset.createuser = session[:user].id
        copyset.status_lu_id = StatusLu.active
        copyset.save
      }
    }

    @msg = 'Role successfully created'
    @msgClass = "success-msg"
    @refreshPageOnSave = false
    @closeDialog = true
    render :partial => "common/refresh", :layout => nil
    
  end

  def new
    @roleTypes = RoleLu.all_ordered_by_label
    if params[:rightsholderid] then
      @rightsholder = Rightsholder.new(params[:rightsholderid])
    end
    if params[:copypid] then
      @copydetails = Copydetails.find_by_copypid(params[:copypid])
    end
    @copysets = []
  end

  def edit
    @role = Role.find(params[:id])
    @roleTypes = RoleLu.all_ordered_by_label
    @rightsholder = Rightsholder.get_rightsholder_by_partyid(@role.partyid)
    @copysets = Copyset.find(:all, :conditions=>{:roleid=>@role.roleid, :status_lu_id=>StatusLu.active})
    render :action => "edit.html"
  end

  def update

    @role = Role.find(params[:id])

    copypids = params[:copypid]
    if !copypids.nil? then
      copypids = copypids.uniq
      copypids = copypids.reject { |id|id.nil? or id.length==0 }
    else
      copypids = []
    end

    # Mark existing copyset as DELETED
    Copyset.delete_all_for_roleid(@role.roleid)

    # Create a new copyset
    copypids.each { |copypid|
        copydetails = Copydetails.find_by_copypid(copypid)
        copyset = Copyset.new;
        copyset.copydetailsid = copydetails.copydetailsid
        copyset.roleid = @role.roleid
        copyset.audituser = session[:user].id
        copyset.auditdate = Date.today
        copyset.createdate = Date.today
        copyset.createuser = session[:user].id
        copyset.status_lu_id = StatusLu.active
        copyset.save
      }

    @role.audituser = session[:user].id
    @role.auditdate = Date.today
    @role.save

    @msg = 'Role successfully updated'
    @msgClass = "success-msg"
    @refreshPageOnSave = false
    @closeDialog = true
    render :partial => "common/refresh", :layout => nil
  end

  def delete    
    @role = Role.find(params[:id])
    render :action => "delete.html"
  end

  def destroy
    @role = Role.find(params[:id])
    @role.status_lu_id = StatusLu.deleted
    if @role.save then
      Copyset.delete_all_for_roleid(@role.roleid)

      @msg = 'Role successfully deleted'
      @msgClass = "success-msg"
      @refreshPageOnSave = false
      @closeDialog = true
      render :partial => "common/refresh", :layout => nil
    else
      @msg = 'Unable to delete Role'
      @msgClass = "error-msg"
      render :action => "delete.html"
    end
  end

end
