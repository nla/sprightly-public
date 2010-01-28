class Agreement < ActiveRecord::Base
  set_primary_key "agreementid"
  set_sequence_name "SQ_AGREEMENT"
  belongs_to :status_lu
  has_many :active_trimrecords, :class_name => Trimrecord.name, :foreign_key => "agreementid", :conditions => { :status_lu_id => StatusLu.active }, :order => :createdate
  has_many :active_permissions, :class_name => Permission.name, :foreign_key => :agreementid, :conditions => { :status_lu_id => StatusLu.active }, :order => "permissiontype_lu_id, permissionpolicy_lu_id"

  validates_presence_of :agreementdate

  def get_agreementid
    agreement.to_i
  end

  def get_associated_rightsholders
    rightsholders = Array.new
    Party.find_parties_attached_to_agreement(self.agreementid).each do |party|
      rightsholder = Rightsholder.get_rightsholder_by_partyid(party.partyid)
      rightsholders.push(rightsholder)
    end
    return rightsholders
  end

  def collection_display_label
    return "" if self.collection.nil?
    Agreement.collection_options[self.collection]
  end

  def formtype_display_label
    return "Multi-Collection Form" if self.formtype=="multi"
    return Agreement.collection_options[self.formtype] + " Form"
  end

  def draft?
    self.status_lu.code == "Draft"
  end

  def active?
    self.status_lu.code == "Active"
  end

  def archived?
    self.status_lu.code == "Archived"
  end

  def self.find_active_by_partyid(partyid)
    Agreement.find_by_sql "select agreement.* from (party left outer join partyagreement on party.partyid = partyagreement.partyid) left outer join agreement on partyagreement.agreementid = agreement.agreementid where agreement.status_lu_id = " + StatusLu.active.to_s + " and party.partyid = " + partyid.to_s + " order by agreementdate DESC"
  end

  def self.find_archived_by_partyid(partyid)
    Agreement.find_by_sql "select agreement.* from (party left outer join partyagreement on party.partyid = partyagreement.partyid) left outer join agreement on partyagreement.agreementid = agreement.agreementid where agreement.status_lu_id = " + StatusLu.archived.to_s + " and party.partyid = " + partyid.to_s + " order by agreementdate DESC"
  end

  def self.collection_options
    @options = Hash.new
    @options["public"] = "Public Programs"
    @options["pictures"] = "Pictures"
    @options["maps"] = "Maps"
    @options["music"] = "Music"
    @options["dance"] = "Dance"
    @options["oral"] = "Oral History"
    @options["manuscripts"] = "Manuscripts"
    @options["printed"] = "Printed Collections"
    return @options
  end

  def self.find_all_drafts
    Agreement.find(:all, :conditions => { :status_lu_id => StatusLu.draft }, :order => "auditdate DESC")
  end

  def self.find_drafts_for_user(userid)
    Agreement.find(:all, :conditions => { :createuser=>userid, :status_lu_id => StatusLu.draft }, :order => "auditdate DESC")
  end

  def self.find_submitted_for_user(userid)
    Agreement.find(:all, :conditions => { :createuser=>userid, :status_lu_id => StatusLu.active }, :order => "auditdate DESC")
  end

  def self.find_archived_for_user(userid)
    Agreement.find(:all, :conditions => { :createuser=>userid, :status_lu_id => StatusLu.archived }, :order => "auditdate DESC")
  end

  def self.find_active_and_archived_for_user(userid)
    Agreement.find(:all, :conditions => { :createuser=>userid, :status_lu_id => [StatusLu.active, StatusLu.archived] }, :order => "auditdate DESC")
  end

  def self.find_archived_linked_to_work(copypid)
    Agreement.find_by_sql  "select agreement.*
                            from agreement
                            where agreement.agreementid in (
                              select DISTINCT agreementid
                              from (copydetails join copyset on copydetails.copydetailsid = copyset.copydetailsid)
                                      join agreement on agreement.agreementid = copyset.agreementid
                                        where copydetails.copypid = '"+copypid.to_s+"'
                                        and copyset.status_lu_id = " + StatusLu.active.to_s + "
                                        and agreement.status_lu_id = " + StatusLu.archived.to_s + ")"
  end

  def self.find_active_linked_to_work(copypid)
    Agreement.find_by_sql  "select agreement.*
                            from agreement
                            where agreement.agreementid in (
                              select DISTINCT agreementid
                              from (copydetails join copyset on copydetails.copydetailsid = copyset.copydetailsid)
                                      join agreement on agreement.agreementid = copyset.agreementid
                                        where copydetails.copypid = '"+copypid.to_s+"'
                                        and copyset.status_lu_id = " + StatusLu.active.to_s + "
                                        and agreement.status_lu_id = " + StatusLu.active.to_s + ")"
  end

  def self.collection_for_formtype(formtype)
    return nil if formtype=='multi'
    formtype
  end


  # Agreement functions to support reporting
  def self.number_of_active(date_type="createdate", start_date=nil, end_date=nil)
    sql = 'SELECT count(*) FROM agreement WHERE agreement.status_lu_id = ' + StatusLu.active.to_s
    if not start_date.blank? then
      sql += " and agreement."+date_type+" >= to_date('"+start_date+"', 'dd-mm-yyyy')"
    end
    if not end_date.blank? then
      sql += " and agreement."+date_type+" <= to_date('"+end_date+"', 'dd-mm-yyyy')"
    end
    ActiveRecord::Base.connection.select_value(sql)
  end

  def self.number_of_draft(date_type="createdate", start_date=nil, end_date=nil)
    sql = 'SELECT count(*) FROM agreement WHERE agreement.status_lu_id = ' + StatusLu.draft.to_s
    if not start_date.blank? then
      sql += " and agreement."+date_type+" >= to_date('"+start_date+"', 'dd-mm-yyyy')"
    end
    if not end_date.blank? then
      sql += " and agreement."+date_type+" <= to_date('"+end_date+"', 'dd-mm-yyyy')"
    end
    ActiveRecord::Base.connection.select_value(sql)
  end

  def self.number_of_archived(date_type="createdate", start_date=nil, end_date=nil)
    sql = 'SELECT count(*) FROM agreement WHERE agreement.status_lu_id = ' + StatusLu.archived.to_s
    if not start_date.blank? then
      sql += " and agreement."+date_type+" >= to_date('"+start_date+"', 'dd-mm-yyyy')"
    end
    if not end_date.blank? then
      sql += " and agreement."+date_type+" <= to_date('"+end_date+"', 'dd-mm-yyyy')"
    end
    ActiveRecord::Base.connection.select_value(sql)
  end

  def self.number_of_deleted(date_type="createdate", start_date=nil, end_date=nil)
    sql = 'SELECT count(*) FROM agreement WHERE agreement.status_lu_id = ' + StatusLu.deleted.to_s
    if not start_date.blank? then
      sql += " and agreement."+date_type+" >= to_date('"+start_date+"', 'dd-mm-yyyy')"
    end
    if not end_date.blank? then
      sql += " and agreement."+date_type+" <= to_date('"+end_date+"', 'dd-mm-yyyy')"
    end
    ActiveRecord::Base.connection.select_value(sql)
  end

  def self.agreements_by_collection_and_status(date_type="createdate", start_date=nil, end_date=nil)
    metrics = {}
    Agreement.collection_options.keys.each { |collection|
       metrics[collection] = {"Active"=>0,"Draft"=>0,"Archived"=>0,"Deleted"=>0}
    }
    metrics[""] = {"Active"=>0,"Draft"=>0,"Archived"=>0,"Deleted"=>0}

    sql = 'select agreement.collection, status_lu.code, count(*) from agreement, status_lu where status_lu.status_lu_id = agreement.status_lu_id '
    if not start_date.blank? then
      sql += " and agreement."+date_type+" >= to_date('"+start_date+"', 'dd-mm-yyyy')"
    end
    if not end_date.blank? then
      sql += " and agreement."+date_type+" <= to_date('"+end_date+"', 'dd-mm-yyyy')"
    end
    sql += " group by  agreement.collection, status_lu.code"

    rows = ActiveRecord::Base.connection.select_rows(sql)
    rows.each { |row|
      if (row[0].nil?) then
        metrics[""][row[1]] = row[2]
      else
        metrics[row[0]][row[1]] = row[2]
      end
    }
    return metrics
  end

  def self.agreements_by_user_and_status(date_type="createdate", start_date=nil, end_date=nil)
    metrics = {}
    sql = "select agreement.createuser, status_lu.code, count(*), TO_CHAR(max(agreement.createdate),'YYYY-MM-DD') from agreement, status_lu where status_lu.status_lu_id = agreement.status_lu_id"
    if not start_date.blank? then
      sql += " and agreement."+date_type+" >= to_date('"+start_date+"', 'dd-mm-yyyy')"
    end
    if not end_date.blank? then
      sql += " and agreement."+date_type+" <= to_date('"+end_date+"', 'dd-mm-yyyy')"
    end

    sql += " group by  agreement.createuser, status_lu.code"
    rows = ActiveRecord::Base.connection.select_rows(sql)
    rows.each { |row|
      if not metrics.has_key?(row[0]) then
        metrics[row[0]] = {"Active"=>0,"Draft"=>0,"Archived"=>0,"Deleted"=>0, "lastCreated"=>row[3]}
      end
      metrics[row[0]][row[1]] = row[2]
    }
    return metrics
  end

end
