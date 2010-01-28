class Trimrecord < ActiveRecord::Base
  set_primary_key "trimrecordid"
  set_sequence_name "SQ_TRIMRECORD"

  validates_presence_of :trimrefnumber
  validates_format_of :trimdate, :with => /(19|20)\d\d[-](0[1-9]|1[012])[-](0[1-9]|[12][0-9]|3[01])[ 00:00:00 UTC]/i,
                      :allow_nil => :true, :message => 'invalid date format', :on => :save

  def get_trimrecordid
    trimrecordid.to_i
  end

  def self.find_active_by_agreementid(agreementid)
    Trimrecord.find(:all, :conditions => { :agreementid => agreementid, :status_lu_id => StatusLu.active }, :order => :createdate)
  end

  # Returns a URL for the trim_ref. If the trim_ref contains more than
  # one '/' then only return the trim_ref.
  def self.get_trim_url(trim_ref)
    if (trim_ref.count("/") > 1)
      return nil
    else
      return SERVICE_TRIM + trim_ref
    end
  end

end
