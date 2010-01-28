# This represents the WORK table within DCM
# This class is only used for a RAKE task to
# migrate all internal images into a SOLR Search
class Work < ActiveRecord::Base
    establish_connection :production_dcm

    def self.pi_prefixes
      [
        "nla.cat-vn",
        "nla.aus",
        "nla.con",
        "nla.gen",
        "nla.int",
        "nla.map",
        "nla.ms",        
        "nla.mus",
        "nla.oh",
        "nla.pic"                
      ]
    end
end