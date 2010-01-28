class Contactdetail < ActiveRecord::Base
  set_primary_key "contactdetailid"
  set_sequence_name "SQ_CONTACTDETAIL"
  belongs_to :contact, :foreign_key  => 'contactid'
  validates_presence_of :key, :contactid
end