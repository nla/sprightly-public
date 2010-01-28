require 'net/http'
require 'uri'

include Net
include REXML

# The administrator functions
# Currently only used to manage users
#
# @author tingram
#

class AdminController < ApplicationController

  before_filter :login_required, :admin_access_required
  
  ADMINISTRATOR = "rms:administrator"
  UPDATER = "rms:updater"

  def index

  end

  def new
    @name = nil
    @group = params[:group]
  end

  def create
    @name = params[:name]
    @group = params[:group]

    if @name.nil? || @name.empty?
      @msg = "Please provide a user name."
      @msgClass = "error-msg"
      render :action => :new
    elsif !valid_user?(@name)
      @msg = "The user name is not valid. Please re-enter the name."
      @msgClass = "error-msg"
      render :action => :new
    elsif add(@name, @group)
        @msg = 'Successfull added user <b>' + @name + '</b> to group: <b>'+ @group +'</b>'
        @msgClass = "success-msg"
        @refreshPageOnSave = false
        @closeDialog = true
        render :partial => "common/refresh", :layout => nil
    else
      @msg = "Unable to grant permission to the user. Please try again."
      @msgClass = "error-msg"
      render :action => :new
    end
  end

  def delete
    @name = params[:id]
    @group = params[:group]
  end

  def destroy
    @name = params[:id]
    @group = params[:group]

    if remove(@name, @group)
      @msg = 'Successfull removed user <b>' + @name + '</b> from group: <b>'+ @group +'</b>'
      @msgClass = "success-msg"
      @refreshPageOnSave = false
      @closeDialog = true
      render :partial => "common/refresh", :layout => nil
    else
      @msg = "Unable to remove user from group."
      @msgClass = "error-msg"
      render :action => :delete
    end
  end

  def user_admin
    @administrators = get_group(ADMINISTRATOR)
    @updaters = get_group(UPDATER)
    render :partial=>"user_admin.html"
  end

  private

    # Query the UMS and retrieve a list of users
    # for the group_name
    def get_group(group_name)
      users = Array.new
      query_url = SERVICE_UMS + "group?groupid=" + group_name + "&listUsers=y"
      response = HTTP.get_response(URI.parse(query_url))
      case response
      when HTTPSuccess then
        XPath.each(Document.new(response.body), "//user" ) { |el| users.push(el.text.sub(/user:/, "")) }
      end
      return users
    end


    # Validates the user against the UMS
    def valid_user?(userid)
      if query_ums(SERVICE_UMS + "user?userid=user:" + userid + "&sessionNonce=" + session[:user].session_nonce)
        return true
      else
        # It could mean that the user is in Active Directory bu not in the UMS
        if in_active_directory?(userid)
          add_user_to_ums(userid)
          return true
        else
          return false
        end
      end
    end

    # Checks whether a user is in active directory
    def in_active_directory?(userid)
      query_url = SERVICE_UMS + "user?ADuserIdFilter=" + userid
      response = HTTP.get_response(URI.parse(query_url))
      case response
      when HTTPSuccess then
        XPath.each(Document.new(response.body), "//ADUser='" + userid.upcase + "'" ) { return true }
      end
      false
    end

    # Add a user to the UMS
    def add_user_to_ums(userid)
      query_ums(SERVICE_UMS + "user?simulatedMethod=put&userid=user:" + userid + "&nlauserid=y&sessionNonce=" + session[:user].session_nonce)
    end

    # Add a user to a group
    def add(userid, group)
      query_ums(SERVICE_UMS + "user?simulatedMethod=post&userid=user:" + userid + "&addAttribute=ums:partOf%7C" + group + "&sessionNonce=" + session[:user].session_nonce)
    end

    # Remove a user from a group
    def remove(userid, group)
      query_ums(SERVICE_UMS + "user?simulatedMethod=post&userid=user:" + userid + "&delAttribute=ums:partOf%7C" + group + "&sessionNonce=" + session[:user].session_nonce)
    end

    # Queries the UMS and returns true if status = 200 otherwise false
    def query_ums(query_url)
      response = HTTP.get_response(URI.parse(query_url))
      case response
      when HTTPSuccess then
        true
      else
        false
      end
    end
      
end
