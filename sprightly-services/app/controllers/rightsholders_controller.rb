class RightsholdersController < ApplicationController

  # Tries to simulate the search ... well tries something
  def select

    q = params[:q].downcase
    q = "response_all" if q == "*" or q == "*:*" or q.blank?
    q = q.sub(/ /, "_")
    q = q.sub(/id\:/, "")
    q = q.sub(/-/, "_")

    begin
      render :partial => "rightsholders/" + q + ".xml"
    rescue
      #render :partial => "rightsholders/response_empty.xml"
      render :partial => "rightsholders/response_all.xml"
    end

  end
end
