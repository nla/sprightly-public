#
# Manages requests on the Note Table.
#
# @author: tingram
#
class NoteController < ApplicationController

 before_filter :login_required, :update_access_required

 # GET /note/new
 def new
    @note = Note.new
    @note.partyid = params[:partyid]
    render :action => "new.html"
 end

 # GET /note/edit/1
 def edit
   @note = Note.find(params[:id])
   render :action => "edit.html"
 end

 # GET /note/delete/1
 def delete
    @note = Note.find(params[:id])
    render :action => "delete.html"
 end

 # POST /note/create
 def create
    @note = Note.new(params[:note])
    @note.status_lu_id = StatusLu.active
    @note.audituser = session[:user].id
    @note.auditdate = Date.today
    @note.createdate = Date.today
    @note.createuser = session[:user].id

    if @note.save
      @msg = 'Note successfully saved.'
      @msgClass = "success-msg"
      @refreshPageOnSave = false
      @closeDialog = true
      render :partial => "common/refresh", :layout => nil
    else
      render :action => "new"
    end
 end

 # POST /note/update
 def update
    @note = Note.find(params[:id])
    @note.audituser = session[:user].id
    @note.auditdate = Date.today


    if @note.update_attributes(params[:note])
      @msg = 'Note successfully updated.'
      @msgClass = "success-msg"
      @refreshPageOnSave = false
      @closeDialog = true
      render :partial => "common/refresh", :layout => nil
    else
      render :action => "new", :id => @note.noteid.to_i
    end
 end

 # DELETE /note/1
 # Performs a soft delete by changing the status to DELETED
 def destroy
    @source = params[:source]
    @note = Note.find(params[:id])
    @note.status_lu_id = StatusLu.deleted
    @note.auditdate = Date.today
    @note.audituser = session[:user].id

    if @note.save
      @msg = 'Note successfully deleted.'
      @msgClass = "success-msg"
      @refreshPageOnSave = false
      @closeDialog = true
      render :partial => "common/refresh", :layout => nil
    else
      render :action => "delete", :id => @note.noteid.to_i
    end
  end

end
