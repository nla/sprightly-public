class CopystatusLu < ActiveRecord::Base
  set_primary_key "copystatus_lu_id"
  has_many :copystatus
end
