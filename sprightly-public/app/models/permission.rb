class Permission < ActiveRecord::Base
  set_primary_key "permissionid"
  set_sequence_name "SQ_PERMISSION"
  belongs_to :policy_lu
  belongs_to :permissionpolicy_lu
  belongs_to :permissionpurpose_lu
  belongs_to :permissiontype_lu, :foreign_key  => 'permissiontype_lu_id'

  validates_presence_of :permissionpolicy_lu_id, :permissiontype_lu_id, :permissionholder

  def self.permissionholder_options
    @options = Hash.new
    @options[Permission.permissionholder_everyone] = Permission.permissionholder_everyone
    @options[Permission.permissionholder_nla] = Permission.permissionholder_nla
    return @options
  end

  def self.eventoperator_options
    @options = Hash.new
    @options["Until"] = "Until"
    @options["After"] = "After"
    return @options
  end

  def self.permissionholder_nla
    "NLA"
  end

  def self.permissionholder_everyone
    "Everyone"
  end
end