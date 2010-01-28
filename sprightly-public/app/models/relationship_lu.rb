class RelationshipLu < ActiveRecord::Base
  set_primary_key "relationship_lu_id"
  has_many :relationship

  def self.all_ordered_by_label
    RelationshipLu.find(:all, :order=>"label ASC")
  end
end
