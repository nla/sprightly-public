class CollectionController < ApplicationController

  # Using the bibid it returns the record as marcxml
  def index
    id = params[:pi]
    id = id.sub(/^nla.cat-vn/, "") 
    render :partial => "collection/marc_" + id + ".xml"
  end
end
