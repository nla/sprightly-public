class TrimstatusLu < ActiveRecord::Base
  set_primary_key "trimstatus_lu_id"

  def self.find_by_code(code)
    TrimstatusLu.find(:first, :conditions => {:trimstatus => code} )
  end

  # Return the trimstatus_lu_id
  def self.active
    TrimstatusLu.find_by_code("Active").trimstatus_lu_id
  end

  # Return the trimstatus_lu_id
  def self.deleted
    TrimstatusLu.find_by_code("Deleted").trimstatus_lu_id
  end

end

