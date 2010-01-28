class Note < ActiveRecord::Base
  set_primary_key "noteid"
  set_sequence_name "SQ_NOTE"
  validates_presence_of :note
end
