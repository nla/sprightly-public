class PermissionpolicyLu < ActiveRecord::Base
  set_primary_key "permissionpolicy_lu_id"
  has_many :permission

  def self.find_by_code(code)
    PermissionpolicyLu.find(:first, :conditions => {:code => code} )
  end

  def self.options
    @all = PermissionpolicyLu.find(:all);
    @options = []
    for permissionpolicy_lu in @all
      @options.push([permissionpolicy_lu.label,permissionpolicy_lu.permissionpolicy_lu_id])
    end
    @options
  end

  # Represents A static way to get the code values
  def  self.permission_required
    "permission_required"
  end

  def self.closed
    "closed"
  end

  def self.open
    "open"
  end

  def self.part_open_part_permission_required
    "part_open_part_permission_required"
  end

  def self.part_open_part_closed
    "part_open_part_closed"
  end

  def self.part_permission_required_part_closed
    "part_permission_required_part_closed"
  end
end