class PermissiontypeLu < ActiveRecord::Base
  set_primary_key "permissiontype_lu_id"
  has_many :permission, :foreign_key  => 'permissiontype_lu_id'

  def self.find_by_code(code)
    PermissiontypeLu.find(:first, :conditions => {:code => code} )
  end

  def self.options
    @all = PermissiontypeLu.find(:all);
    @options = []
    for permissiontype_lu in @all
      @options.push([permissiontype_lu.label,permissiontype_lu.permissiontype_lu_id])
    end
    @options
  end

  # Represents A static way to get the code values
  def  self.access
    "access"
  end

  def self.publishing
    "publishing"
  end

  def self.exhibition
    "exhibition"
  end

  def self.copying
    "copying"
  end

end