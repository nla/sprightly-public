# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
#
# @author tingram

class ApplicationController < ActionController::Base

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  filter_parameter_logging "password"  # Scrub sensitive parameters from your log
  layout :custom_layout

  # Overrides the process instance method in actionpack/lib/action_controller/base.rb
  def process(request, response, method = :perform_action, *arguments)
    if request[:ajax] && request[:ajax]=='true' then
      @isAjaxRequest = true
    else
      @isAjaxRequest = false
    end
    super(request, response, method, *arguments);
  end

  protected

    # Ensures that a user is logged on
    # If false the user is redirected to the login page
    # It stores the requested URL by the user, so that upon successful authentication
    # the user is redirected back to the requested page.
    def login_required
      return true if session[:user]
      session[:return_to] = request.request_uri
      session[:user] = nil
      session[:breadcrumbs] = clear_breadcrumbs
      redirect_to :controller => 'usersession', :action => 'new'
    end

    def admin_access_required
      return true if session[:user].administrator?
      redirect_to :controller => :search
    end

    def update_access_required
      return true if session[:user].updater?
      redirect_to :controller => :search
    end

    # Add a new breadcrumb or restore the breacrumbs to the position
    #
    # @param name The display name of the breadcrumb
    def add_breadcrumb(name)
      @breadcrumbs = session[:breadcrumbs]
      position = params[:position]
      start = params[:start]

      if @breadcrumbs[@breadcrumbs.length-1].url.to_s.eql?(request.request_uri.to_s)
        # Do nothing as this is the last page that has been refreshed
      elsif !start.nil? && position.nil?
        # This means that the user is viewing another page within searchresults
        # overwrite the last crumb
        @breadcrumbs.pop
        @breadcrumbs.push(Breadcrumb.new(name.slice(0..20) + "...", request.request_uri))
      elsif position.nil?
        # New page, add the breadcrumb
        @breadcrumbs.push(Breadcrumb.new(name.slice(0..20) + "...", request.request_uri))
      else
        # pop breadcrumbs that are no longer needed to the position within the breabcrumbs
        while ((position.to_i + 1) < @breadcrumbs.length)
          @breadcrumbs.pop
        end
      end

    end

    # Clears the breadcrumbs and sets the home breadcrumb
    def clear_breadcrumbs
      session[:breadcrumbs] = nil
      breadcrumbs = Array.new
      breadcrumbs.push(Breadcrumb.new("Home", url_for(:controller => :search, :action => 'new')))
      session[:breadcrumbs] = breadcrumbs
    end


  private
    def custom_layout
       @isAjaxRequest ? nil : "application"
    end

     # Remove unwanted characters from the query string that limit the results
    def format_query(query)
      query.gsub(/[-]/, ' ')
    end

end
