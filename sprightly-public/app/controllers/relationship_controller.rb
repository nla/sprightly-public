class RelationshipController < ApplicationController

  before_filter :login_required, :update_access_required

  # It shows all rightsholders with relationships
  def index
    @relationships = Relationship.find(:all, :conditions => { :status_lu_id => StatusLu.active} )
    @rightsholders = Hash.new
    # Iterate through the relaiosnhips to create a unique list of rightsholders
    @relationships.each do |relationship|
      @rightsholders[relationship.delegator.to_i] = ""
      @rightsholders[relationship.delegatee.to_i] = ""
    end
    @rightsholders.each_key { |key| @rightsholders[key] = Rightsholder.get_rightsholder_by_partyid(key)}
  end
  
  def new
      @relationshipTypes = RelationshipLu.all_ordered_by_label
      @relationship = Relationship.new
      @rightsholderA = Rightsholder.new(params[:rightsholderid])
      @relationship.delegator = Party.get_party(params[:rightsholderid]).partyid
      @relationship.delegatee = nil
  end

  def delete
    @relationship = Relationship.find(params[:id])
    render :action => "delete.html"
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    @relationship.status_lu_id = StatusLu.deleted
    if @relationship.save then
      @msg = 'Relationship successfully deleted'
      @msgClass = "success-msg"
      @refreshPageOnSave = false
      @closeDialog = true
      render :partial => "common/refresh", :layout => nil
    else
      @msg = 'Unable to delete Relationship'
      @msgClass = "error-msg"
      render :action => "delete.html"
    end
  end


  def create

    relationship = Relationship.new(params[:relationship])
    relationship.audituser = session[:user].id
    relationship.auditdate = Date.today
    relationship.createdate = Date.today
    relationship.createuser = session[:user].id
    relationship.status_lu_id = StatusLu.active

    if not params[:delegatee_rightsholder_id].blank? then
      relationship.delegatee = Party.get_party(params[:delegatee_rightsholder_id]).partyid
    end

    if relationship.save then
      @msg = 'Relationship successfully created.'
      @msgClass = "success-msg"
      @closeDialog = true
      @refreshPageOnSave = false
      render :partial => "common/refresh", :layout => nil
    else
      @relationship = relationship
      @rightsholderA = Rightsholder.get_rightsholder_by_partyid(relationship.delegator)
      if relationship.delegatee then
        @rightsholderB = Rightsholder.get_rightsholder_by_partyid(relationship.delegatee)
      end
      @relationshipTypes = RelationshipLu.all_ordered_by_label
      render :action => :new
    end
  end
end
