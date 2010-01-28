#
# Manages the Library Decision widget on the work details.
# All library decisions are stored within the COPYSTATUS table.
#
# @author: tingram
#
class LibrarydecisionController < ApplicationController

  before_filter :login_required, :update_access_required
  
  def new
    @copydetailsid = params[:copydetailsid]
    @copystatus = Copydetails.find(@copydetailsid).library_decision

    if @copystatus.nil?
      @copystatus = Copystatus.new
      @copystatus.copydetailsid = @copydetailsid
      render :action => "new"
    else
      render :action => "edit"
    end
  end
  
  def create
    @copystatus = Copystatus.new(params[:copystatus])
    @copystatus.audituser = session[:user].id
    @copystatus.auditdate = Date.today
    @copystatus.createdate = Date.today
    @copystatus.createuser = session[:user].id

    if @copystatus.save
      @msg = 'Successfully saved Library Decision.'
      @msgClass = "success-msg"
      @refreshPageOnSave = false
      @closeDialog = true
      render :partial => "common/refresh", :layout => nil
    else
      render :action => "new", :copydetailsid => @copystatus.get_copydetailsid
    end
  end

  def update
    @copystatus = Copystatus.find(params[:id])
    @copystatus.audituser = session[:user].id
    @copystatus.auditdate = Date.today
  
    if @copystatus.update_attributes(params[:copystatus])
      @msg = 'Successfully updated Library Decision.'
      @msgClass = "success-msg"
      @refreshPageOnSave = false
      @closeDialog = true
      render :partial => "common/refresh", :layout => nil
    else
      render :action => "new", :copydetailsid => @copystatus.get_copydetailsid
    end
  end

  def delete
    @copystatus = Copystatus.find(params[:id])
  end

  def destroy
    @copystatus = Copystatus.find(params[:id])
    @copystatus.status_lu_id = StatusLu.deleted
    @copystatus.auditdate = Date.today
    @copystatus.audituser = session[:user].id

    if @copystatus.save
      @msg = 'Successfully removed Library Decision.'
      @msgClass = "success-msg"
      @refreshPageOnSave = false
      @closeDialog = true
      render :partial => "common/refresh", :layout => nil
    else
      render :action => "delete", :id => @copystatus.copystatusid.to_i
    end
  end

end
