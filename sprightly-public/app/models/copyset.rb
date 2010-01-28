class Copyset < ActiveRecord::Base
  set_primary_key "copysetid"
  set_sequence_name "SQ_COPYSET"
  belongs_to :role
  belongs_to :copydetails, :foreign_key => "copydetailsid"


  def self.delete_all_for_agreementid(agreementid)
    self.delete_all("agreementid="+agreementid.to_i.to_s)
  end

  def self.delete_all_for_roleid(roleid)
    #self.delete_all("roleid="+roleid.to_i.to_s)
    self.update_all("status_lu_id = "+StatusLu.deleted.to_s,"roleid = "+roleid.to_i.to_s + " and status_lu_id = " + StatusLu.active.to_s)
  end

end
