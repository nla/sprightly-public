class PermissionpurposeLu < ActiveRecord::Base
  set_primary_key "permissionpurpose_lu_id"
  has_many :permission

  def self.find_by_code(code)
    PermissionpurposeLu.find(:first, :conditions => {:code => code} )
  end

  def self.options
    @all = PermissionpurposeLu.find(:all);
    @options = []
    for permissionpurpose_lu in @all
      @options.push([permissionpurpose_lu.label,permissionpurpose_lu.permissionpurpose_lu_id])
    end
    @options
  end

  # Represents A static way to get the code values
  def  self.online
    "online"
  end

  def self.publications_merchandise_publicity
    "publications_merchandise_publicity"
  end

  def self.merchandise
    "merchandise"
  end

  def self.publicity
    "publicity"
  end

  def self.publications
    "publications"
  end

  def self.specific_exhibition_publication
    "specific_exhibition_publication"
  end
end