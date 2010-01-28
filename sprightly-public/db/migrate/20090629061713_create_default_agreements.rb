# Migration to create Default Agrrements for existing legacy policy data
class CreateDefaultAgreements < ActiveRecord::Migration

  class Policy < ActiveRecord::Base
    set_primary_key "policyid"
    set_sequence_name "SQ_POLICY"
  end

  def self.up
    puts "Creating default agreements ... "

    Policy.find_by_sql("select distinct(partyid) from policy where partyid is not null").each_with_index do |policy, index|

      puts policy.partyid.to_i

      # Create a new Agreement
      agreement = Agreement.new
      agreement.agreementdate = Date.today
      agreement.status_lu_id = StatusLu.active
      agreement.createdate = Date.today
      agreement.createuser = 'sprightly'
      agreement.auditdate = Date.today
      agreement.audituser = 'sprightly'
      agreement.note = 'Pictures data migration. Bulk upload - 2007'
      agreement.formtype = 'pictures'
      agreement.collection = 'pictures'
      agreement.save

      # Create a new PartyAgreement
      partyagreement = Partyagreement.new
      partyagreement.status_lu_id = StatusLu.active
      partyagreement.createdate = Date.today
      partyagreement.createuser = 'sprightly'
      partyagreement.auditdate = Date.today
      partyagreement.audituser = 'sprightly'
      partyagreement.partyid = policy.partyid.to_i
      partyagreement.agreementid = agreement.agreementid.to_i
      partyagreement.save

      # Link the the agreement to all the Policies
      Policy.find(:all, :conditions => { :partyid => policy.partyid.to_i }).each_with_index do |p, i|
        p.agreementid = agreement.agreementid.to_i
        p.save
      end

    end
    
  end

  def self.down
    puts "Truncating table agreement ..."
    Agreement.delete_all
    puts "Truncating table partyagreement ..."
    Partyagreement.delete_all
  end
end
