class RoleLu < ActiveRecord::Base
  set_primary_key "role_lu_id"
  has_many :role

  def self.all_ordered_by_label
    RoleLu.find(:all, :order => "label ASC")
  end

end
