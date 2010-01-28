class Copydetails < ActiveRecord::Base
  set_primary_key "copydetailsid"
  set_sequence_name "SQ_COPYDETAILS"
  has_many :copyset
  has_many :active_trimrecords, :class_name => Trimrecord.name, :foreign_key => "copydetailsid", :conditions => { :status_lu_id => StatusLu.active }, :order => :createdate
  has_one :library_decision, :class_name => Copystatus.name, :foreign_key => "copydetailsid", :conditions => { :status_lu_id => StatusLu.active }

  def get_copydetailsid
    copydetailsid.to_i
  end

  def self.find_by_copypid(copypid)
    Copydetails.find(:first, :conditions => ["copypid = ?", copypid])
  end

  # Validates the COPYPID (i.e. WORKPID or BIBID) against DCM or CATALOGUE.
  # If valid it returns the copydetails record otherwise returns nil.
  # If this is a new copy, it's then added to the RMS database.
  def self.validate(copypid)

    # All copypid's WORKPID and BIBID's must start with nla.
    if !copypid.match(/^nla./)
      return nil
    end

    # Check if the copypid exists within the RMS database
    copydetails = Copydetails.find_by_copypid(copypid)
    return copydetails if !copydetails.nil?

    if valid?(copypid)
      copydetails = Copydetails.new()
      copydetails.copypid = copypid
      copydetails.copyrole_lu_id = 1
      copydetails.save
      return copydetails
    else
      return nil
    end
  end

  # Validate the existence of id against the collection service.
  # The collection service determines whether it's a DCM pi
  # or bibid and returns the record accordingly.
  # 
  # Returns false if no record exists for the id.
  def self.valid?(id)
    response = Net::HTTP.get_response URI.parse(URI.escape(SERVICE_COLLECTION + id))
    case response
      when Net::HTTPSuccess then return true
      else return false
    end
  end
end
