#
# Manages requests for searching DCM, Catalogue and Rights Holders.
#
# @author: tingram
#

require 'util/rss_util'

class SearchController < ApplicationController

  before_filter :login_required, :except => :news_feed
  
  def index
    clear_breadcrumbs
    @page_title = "Home"
    @draft_agreements = Agreement.find_drafts_for_user(session[:user].id)
  end

  def new
    clear_breadcrumbs
    redirect_to :controller => :search
  end

  def todo
    render :partial=>"common/todo.html"
  end

  def news_feed
    index = params[:index]
    length = params[:length]

    index = 0 if index.blank?
    length = 5 if length.blank?

    render :text=>RssReader.parse_feed(SPRIGHTLY_BLOG_RSS, {:index=>index.to_i, :length=>length.to_i, :show_more_link=>true})
  end

  def search
    @rows = SEARCH_RESULT_MAX_PAGE_DISPLAY
    @source = params[:source]
    session[:search_source] = @source
    @query = params[:q]
    @start = params[:start]
    @sort = params[:sort]

    @page_title = "Search \""+@query+"\""


    if @query.match(/^nla./)
      # This is the case where just the PI or BIBID have been entered
      # This means that the query must start with nla.
      response = Net::HTTP.get_response URI.parse(URI.escape(SERVICE_COLLECTION + @query))
      case response
        when Net::HTTPSuccess
          if @query.match(/^nla.cat/)
            redirect_to :controller => :works, :action => :show, :id => @query.sub('nla.cat-vn', ''), :source => 'catalogue'
          else
            redirect_to :controller => :works, :action => :show, :id => @query, :source => 'dcm'
          end
        end
    end

    if @query.nil? || @query.strip.empty?
      # Blank query
      render "index.html"
    else
      if @start == nil
          @start = 0
      end

      if @sort == nil
          @sort = ""
      end


      @search_response = nil

      case @source
          when "catalogue" then @service = SERVICE_CATALOG_SEARCH
                                page = 1
                                if @start.to_i > 1
                                  page = (@start.to_i/@rows.to_i) + 1
                                end
                                @search_response = CatalogueSearch.new_query(@query, page, @rows, "&sort=" + @sort)
                                if @search_response.num_found.to_i == 1
                                  redirect_to :controller => :works, :id => @search_response.get_id_of_first_result, :source => @source
                                end

          when "dcm" then @service = SERVICE_DCM_SEARCH
                          @search_response = SolrResponse.new_query(@service, @query, @start, @rows, "")
                          if @search_response.num_found.to_i == 1
                            redirect_to :controller => :works, :id => dcm_get_workpid(@search_response.items[0]), :source => @source
                          end

          when "rightsholder" then @service = SERVICE_RIGHTSHOLDER_SEARCH
                                   @search_response = SolrResponse.new_query(@service, format_query(@query), @start, @rows,  "&sort=name asc")
                                   if @search_response.num_found.to_i == 1
                                     redirect_to :controller => 'rightsholders', :action => :show, :id => @search_response.get_id_of_first_result
                                   end
      end

      add_breadcrumb("Search: " + @query)

      if @start.to_i+@rows <= @search_response.num_found.to_i
        @finish = @start.to_i+@rows
      else
        @finish = @search_response.num_found
      end

    end
  end

  private

  # Get the WORKPID
  def dcm_get_workpid(node)
    node.each_element_with_attribute('name', 'workpid' ) do |element|
      element.each do |str|
        return str.text()
      end
    end
  end
  
end
