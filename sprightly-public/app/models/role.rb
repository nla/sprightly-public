class Role < ActiveRecord::Base
  set_primary_key "roleid"
  set_sequence_name "SQ_ROLE"
  belongs_to :role_lu
  belongs_to :party,  :foreign_key => "partyid"
  has_many :copyset, :foreign_key => "roleid"

  # Using a copypid from the COPYDETAILS table join tables COPYDETAILS, COPYSET, ROLE, PARTY together
  # to return a list of parties that are explicitly linked to a work based.
  def self.find_roles_linked_to_work(copypid)
    sql = "select role.* from (copydetails join copyset on copydetails.copydetailsid = copyset.copydetailsid) join role on role.roleid = copyset.roleid where copydetails.copypid = '" + copypid + "' and copyset.status_lu_id = " + StatusLu.active.to_s + " and role.status_lu_id = " + StatusLu.active.to_s
    return Role.find_by_sql(sql)
  end
end
