class Copystatus < ActiveRecord::Base
  set_primary_key "copystatusid"
  set_sequence_name "SQ_COPYSTATUS"
  belongs_to :copystatus_lu

  validates_presence_of :datedetermined, :note

  def get_copystatusid
    copystatusid.to_i
  end

  def get_copydetailsid
    copydetailsid.to_i
  end

end
