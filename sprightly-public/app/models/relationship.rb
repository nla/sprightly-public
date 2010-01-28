class Relationship < ActiveRecord::Base
  set_primary_key "relationshipid"
  set_sequence_name "SQ_RELATIONSHIP"
  belongs_to :relationship_lu

  validates_presence_of :delegator, :delegatee, :relationship_lu_id

  #def self.find_active_delegator_relationships_by_partyid(partyid)
  #  Relationship.find(:all, :conditions => { :delegator => partyid, :status_lu_id => 1,})
  #end

  #def self.find_active_delegatee_relationships_by_partyid(partyid)
  #  Relationship.find(:all, :conditions => { :delegatee => partyid, :status_lu_id => 1})
  #end

  # Iterates through both relationship lists, and creates a hash
  # of partyid = Rightsholder
  def self.get_rightsholders_in_relationship(delegators, delegatees)
    rightsholders = Hash.new

    delegators.each do |relationship|
      rightsholders[relationship.delegatee] = Rightsholder.get_rightsholder_by_partyid(relationship.delegatee)
    end

    delegatees.each do |relationship|
      rightsholders[relationship.delegator] = Rightsholder.get_rightsholder_by_partyid(relationship.delegator)
    end

    return rightsholders
  end
end
