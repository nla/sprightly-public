class VoyagerdbController < ApplicationController

  def record
    render :partial => "voyagerdb/response_" + params[:id] + ".xml"
  end

  

end
