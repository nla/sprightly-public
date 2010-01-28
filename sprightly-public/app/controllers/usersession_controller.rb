# Manages the User Authentication
# Currently authenticates against the userdb service
#
# @author tingram
#
class UsersessionController < ApplicationController

  def new
    clear_breadcrumbs
  end

  def create
    user = params[:login]
    password = params[:password]
    return_to = session[:return_to]

    new_user = User.new(user, password)

    if !user.nil? && new_user.authenticate?
      session[:user] = new_user

      if return_to.nil?
        redirect_to :controller => 'search', :action => 'index'
      else
        session[:return_to] = nil
        redirect_to(return_to)
      end
    else
      @msg = 'Unable to login. Please try again.'
      @msg_class = "error-msg"
      render :action => 'new'
    end
  end

  def logout
    session[:user] = nil
    session[:return_to] = nil
    session[:breadcrumbs] = nil
    @msg = 'You have been successfully logged out'
    @msg_class = "success-msg"
    render :action => 'new'
  end

end
