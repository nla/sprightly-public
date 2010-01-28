#
# Manages requests on the Permission table.
#
# @author: tingram
#
class PermissionController < ApplicationController

  before_filter :login_required, :update_access_required
  
  def new
    @permission = Permission.new
    @permission.agreementid = params[:agreementid]
    render :action => "new.html"
  end

  def edit
    @permission = Permission.find(params[:id])
    render :action => "edit.html"
  end

  def delete
    @permission = Permission.find(params[:id])
    render :action => "delete.html"
  end

  def create
    @permission = Permission.new(params[:permission])
    @permission.triggerdate = format_trigger_date(params[:permission][:triggerdate])
    @permission.status_lu_id = StatusLu.active
    @permission.createdate = Date.today
    @permission.createuser = session[:user].id
    @permission.auditdate = Date.today
    @permission.audituser = session[:user].id

    if @permission.save
        @permission.originalpermissionid = @permission.permissionid
        @permission.save
        @msg = "Permission successfully saved."
        @msgClass = "success-msg"
        @refreshPageOnSave = false
        @closeDialog = true
        render :partial => "common/refresh", :layout => nil
    else
      render :action => "new.html"
    end
  end

  # Updates a permission. It effectively 'archives' the old permission and
  # creates a 'new' permission. The link between the old and new is the
  # originalpermissionid.
  #
  # PUT /permission/1
  def update
    old_permission = Permission.find(params[:id])
    old_permission.status_lu_id = StatusLu.deleted
    old_permission.auditdate = Date.today
    old_permission.audituser = session[:user].id

    new_permission = Permission.new(params[:permission])
    new_permission.triggerdate = format_trigger_date(params[:permission][:triggerdate])
    new_permission.status_lu_id = StatusLu.active
    new_permission.createdate = Date.today
    new_permission.createuser = session[:user].id
    new_permission.auditdate = Date.today
    new_permission.audituser = session[:user].id

    begin
      Permission.transaction do
        new_permission.save!
        old_permission.save!

        @msg = "Permission successfully updated."
        @msgClass = "success-msg"
        @refreshPageOnSave = false
        @closeDialog = true
        render :partial => "common/refresh", :layout => nil
    end
    rescue ActiveRecord::RecordInvalid => invalid
        @permission = new_permission
        @permission.permissionid = old_permission.permissionid
        render :action => "edit.html"
    end
  end

  # Peforms a soft delete by changing the status to Deleted
  def destroy
    @permission = Permission.find(params[:id])
    @permission.status_lu_id = StatusLu.deleted
    @permission.auditdate = Date.today
    @permission.audituser = session[:user].id

    if @permission.save    
       @refreshPageOnSave = false
       @closeDialog = true
        @msg = "Permission successfully deleted."
        @msgClass = "success-msg"
       render :partial => "common/refresh", :layout => nil
    else
      render :action => "delete", :id => @permission.permissionid.to_i
    end
  end

  private

  # The Copyright Act interprets Copyright expiry to be 31 Dec in the year that
  # copyright expires, rather than the exact anniversary of the author's death.
  # This means that if the user only enters a year the date needs to have
  # 31-Dec prefixed.
  def format_trigger_date(trigger)
    if trigger.blank?
      return trigger
    elsif trigger.match(/^\d\d\d\d/)
      return trigger = "31-12-" + trigger.to_s
    else
      return trigger
    end
  end

end
