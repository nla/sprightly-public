class Party < ActiveRecord::Base
  set_primary_key "partyid"
  set_sequence_name "SQ_PARTY"
  has_many :role, :foreign_key => "partyid"
  has_many :partyagreement, :foreign_key => "partyid"

  has_many :active_notes, :class_name => Note.name, :foreign_key => "partyid", :conditions => { :status_lu_id => StatusLu.active }, :order => "auditdate DESC"
  has_many :active_trimrecords, :class_name => Trimrecord.name, :foreign_key => "partyid", :conditions => { :status_lu_id => StatusLu.active }, :order => :createdate
  has_many :active_contacts, :class_name => Contact.name, :foreign_key => "partyid", :conditions => { :status_lu_id => StatusLu.active }, :order => "preferred, contacttype_lu_id"
  has_many :archived_contacts, :class_name => Contact.name, :foreign_key => "partyid", :conditions => { :status_lu_id => StatusLu.archived }, :order => "contacttype_lu_id"
  has_many :active_roles, :class_name => Role.name, :foreign_key => "partyid", :conditions => { :status_lu_id => StatusLu.active }, :include => {:copyset => :copydetails }
  has_many :active_delagators, :class_name => Relationship.name, :foreign_key => :delegator, :conditions => { :status_lu_id => StatusLu.active }
  has_many :active_delagatees, :class_name => Relationship.name, :foreign_key => :delegatee, :conditions => { :status_lu_id => StatusLu.active }

  # Active record returns oracle number as decimal by default
  def get_partyid
    partyid.to_i
  end

  # Searches the Party table for the ID i.e. authid-12345 or partyid-12345
  # If it does not exist the identity is added to the
  # database.
  #
  # @param id This is the AUTHORITY ID or PARTYID
  # @return Returns a party
  def self.get_party(id)

    if id.starts_with?("authid-")
      authorityid = id.sub('authid-', '')
      party = Party.find(:first, :conditions => ["authorityid = ?", authorityid])
      if party.nil?
        party = Party.new()
        party.authorityid = authorityid
        party.status_lu_id = StatusLu.active
        party.auditdate = Date.today
        party.audituser = "RMS"
        party.createuser = "RMS"
        party.createdate = Date.today
        party.save
      end
      return party

    else
      partyid = id.sub('partyid-', '')
      return Party.find(partyid.to_i)
    end

  end

  def self.find_parties_attached_to_agreement(agreementid)
    Party.find_by_sql("select party.* from party left join partyagreement on party.partyid = partyagreement.partyid where agreementid = " + agreementid.to_s)
  end

end
