class StatusLu < ActiveRecord::Base
  set_primary_key "status_lu_id"

  def self.find_by_code(code)
    StatusLu.find(:first, :conditions => {:code => code} )
  end

  # Return the status_lu_id
  def self.active
    StatusLu.find_by_code("Active").status_lu_id
  end

  # Return the status_lu_id
  def self.deleted
    StatusLu.find_by_code("Deleted").status_lu_id
  end

  # Return the status_lu_id
  def self.archived
    StatusLu.find_by_code("Archived").status_lu_id
  end

  # Return the status_lu_id
  def self.draft
    StatusLu.find_by_code("Draft").status_lu_id
  end

end

