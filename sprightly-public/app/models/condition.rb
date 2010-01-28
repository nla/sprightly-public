class Condition < ActiveRecord::Base
    set_primary_key "conditionid"
    set_sequence_name "SQ_CONDITION"
    belongs_to :policy, :foreign_key => 'policyid'

    # Override the accessor to transform the number to a string
    def timeyears
      if self[:timeyears].nil?
        return ""
      else
        return self[:timeyears].to_i.to_s
      end
    end

    def self.time_operators
      ["Until", "After"]
    end

    def self.event_operators
      ["Until", "After"]
    end

    def self.event_types
      ["Creator year of death","Rights holder year of death", "Created year", "Published year", "Current year"]
    end

    def self.boolean_operators
      ["And", "Or"]
    end
end
