# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090923064737) do

  create_table "agreement", :primary_key => "agreementid", :force => true do |t|
    t.string   "extent",        :limit => 250
    t.string   "collection",    :limit => 50
    t.string   "formtype",      :limit => 50
    t.datetime "agreementdate",                 :null => false
    t.integer  "status_lu_id",  :limit => nil,  :null => false
    t.string   "note",          :limit => 4000
    t.datetime "auditdate",                     :null => false
    t.string   "audituser",     :limit => 50,   :null => false
    t.datetime "createdate",                    :null => false
    t.string   "createuser",    :limit => 50,   :null => false
  end

  create_table "condition", :primary_key => "conditionid", :force => true do |t|
    t.string  "timeoperator",  :limit => 10
    t.decimal "timeyears"
    t.string  "eventoperator", :limit => 10
    t.string  "event",         :limit => 50
    t.decimal "policyid",                    :null => false
  end

  create_table "contact", :primary_key => "contactid", :force => true do |t|
    t.decimal  "partyid",                           :null => false
    t.integer  "contacttype_lu_id", :limit => nil,  :null => false
    t.integer  "privacy_lu_id",     :limit => nil,  :null => false
    t.integer  "status_lu_id",      :limit => nil,  :null => false
    t.string   "preferred",         :limit => 10
    t.string   "note",              :limit => 4000
    t.datetime "auditdate",                         :null => false
    t.string   "audituser",         :limit => 50,   :null => false
    t.datetime "createdate",                        :null => false
    t.string   "createuser",        :limit => 50,   :null => false
  end

  create_table "contactdetail", :primary_key => "contactdetailid", :force => true do |t|
    t.decimal "contactid",                :null => false
    t.string  "key",       :limit => 250
    t.string  "value",     :limit => 250
  end

  create_table "contacttype_lu", :primary_key => "contacttype_lu_id", :force => true do |t|
    t.string "code",  :limit => 50
    t.string "label", :limit => 50
  end

  create_table "copydetails", :primary_key => "copydetailsid", :force => true do |t|
    t.string  "copypid",        :limit => 38,  :null => false
    t.integer "copyrole_lu_id", :limit => nil
  end

  create_table "copyrole_lu", :primary_key => "copyrole_lu_id", :force => true do |t|
    t.string "copyrole", :limit => 15
    t.string "display",  :limit => 15
  end

  create_table "copyset", :primary_key => "copysetid", :force => true do |t|
    t.decimal  "copydetailsid",                :null => false
    t.decimal  "roleid"
    t.integer  "status_lu_id",  :limit => nil, :null => false
    t.datetime "auditdate",                    :null => false
    t.string   "audituser",     :limit => 50,  :null => false
    t.datetime "createdate",                   :null => false
    t.string   "createuser",    :limit => 50,  :null => false
    t.decimal  "agreementid"
  end

  create_table "copystatus", :primary_key => "copystatusid", :force => true do |t|
    t.decimal  "copydetailsid",                    :null => false
    t.integer  "status_lu_id", :limit => nil,  :null => false
    t.string   "note",             :limit => 2000
    t.datetime "datedetermined"
    t.datetime "auditdate",                        :null => false
    t.string   "audituser",        :limit => 50,   :null => false
    t.datetime "createdate",                       :null => false
    t.string   "createuser",       :limit => 50,   :null => false
  end

  create_table "copystatus_lu", :primary_key => "copystatus_lu_id", :force => true do |t|
    t.string "status", :limit => 15
  end

  create_table "note", :primary_key => "noteid", :force => true do |t|
    t.decimal  "partyid",                      :null => false
    t.integer  "status_lu_id", :limit => nil,  :null => false
    t.string   "note",         :limit => 4000
    t.datetime "auditdate",                    :null => false
    t.string   "audituser",    :limit => 50,   :null => false
    t.datetime "createdate",                   :null => false
    t.string   "createuser",   :limit => 50,   :null => false
  end

  create_table "party", :primary_key => "partyid", :force => true do |t|
    t.string   "pepoid",        :limit => 50
    t.integer  "status_lu_id",  :limit => nil, :null => false
    t.datetime "auditdate",                    :null => false
    t.string   "audituser",     :limit => 50,  :null => false
    t.datetime "createdate",                   :null => false
    t.string   "createuser",    :limit => 50,  :null => false
    t.string   "image",         :limit => 250
    t.string   "surname",       :limit => 250
    t.string   "forename",      :limit => 250
    t.string   "birthdate",     :limit => 250
    t.string   "deathdate",     :limit => 250
    t.string   "familyname",    :limit => 250
    t.string   "corporatename", :limit => 250
    t.string   "authorityid",   :limit => 50
  end

  create_table "partyagreement", :primary_key => "partyagreementid", :force => true do |t|
    t.integer  "status_lu_id", :limit => nil, :null => false
    t.decimal  "partyid",                     :null => false
    t.decimal  "agreementid",                 :null => false
    t.datetime "auditdate",                   :null => false
    t.string   "audituser",    :limit => 50,  :null => false
    t.datetime "createdate",                  :null => false
    t.string   "createuser",   :limit => 50,  :null => false
  end

  create_table "permission", :primary_key => "permissionid", :force => true do |t|
    t.decimal  "originalpermissionid"
    t.integer  "permissiontype_lu_id",    :limit => nil,  :null => false
    t.integer  "permissionpolicy_lu_id",  :limit => nil,  :null => false
    t.integer  "permissionpurpose_lu_id", :limit => nil
    t.integer  "policy_lu_id",            :limit => nil
    t.integer  "status_lu_id",            :limit => nil,  :null => false
    t.string   "permissionholder",        :limit => 50
    t.string   "details",                 :limit => 4000
    t.string   "note",                    :limit => 4000
    t.datetime "triggerdate"
    t.string   "timeoperator",            :limit => 10
    t.decimal  "timeyears"
    t.string   "eventoperator",           :limit => 10
    t.string   "event",                   :limit => 50
    t.decimal  "agreementid"
    t.datetime "auditdate",                               :null => false
    t.string   "audituser",               :limit => 50,   :null => false
    t.datetime "createdate",                              :null => false
    t.string   "createuser",              :limit => 50,   :null => false
    t.string   "rule",                    :limit => 50,   :null => true
  end

  create_table "permissionpolicy_lu", :primary_key => "permissionpolicy_lu_id", :force => true do |t|
    t.string "code",  :limit => 50
    t.string "label", :limit => 50
  end

  create_table "permissionpurpose_lu", :primary_key => "permissionpurpose_lu_id", :force => true do |t|
    t.string "code",  :limit => 50
    t.string "label", :limit => 50
  end

  create_table "permissiontype_lu", :primary_key => "permissiontype_lu_id", :force => true do |t|
    t.string "code",  :limit => 50
    t.string "label", :limit => 50
  end

  create_table "policy", :primary_key => "policyid", :force => true do |t|
    t.decimal  "originalpolicyid"
    t.integer  "policytype_lu_id",     :limit => nil,  :null => false
    t.integer  "policystatus_lu_id",   :limit => nil,  :null => false
    t.integer  "policy_lu_id",         :limit => nil,  :null => false
    t.string   "permissionholderpi",   :limit => 50
    t.string   "permissionholdertype", :limit => 50
    t.datetime "startdate",                            :null => false
    t.datetime "enddate"
    t.string   "details",              :limit => 4000
    t.string   "note",                 :limit => 4000
    t.string   "booleancondition",     :limit => 5
    t.decimal  "copydetailsid"
    t.decimal  "partyid"
    t.datetime "auditdate",                            :null => false
    t.string   "audituser",            :limit => 50,   :null => false
    t.datetime "createdate",                           :null => false
    t.string   "createuser",           :limit => 50,   :null => false
    t.decimal  "agreementid"
  end

  create_table "policy_lu", :primary_key => "policy_lu_id", :force => true do |t|
    t.string "policycode", :limit => 20, :null => false
    t.string "shortdesc",                :null => false
    t.string "longdesc",                 :null => false
  end

  create_table "policystatus_lu", :primary_key => "policystatus_lu_id", :force => true do |t|
    t.string "policystatus", :limit => 20
  end

  create_table "policytype_lu", :primary_key => "policytype_lu_id", :force => true do |t|
    t.string "policytype", :limit => 20
    t.string "label",      :limit => 50
  end

  create_table "privacy_lu", :primary_key => "privacy_lu_id", :force => true do |t|
    t.string "code",  :limit => 50
    t.string "label", :limit => 50
  end

  create_table "related_role", :id => false, :force => true do |t|
    t.decimal "related_roleid", :null => false
    t.decimal "roleid",         :null => false
  end

  create_table "relationship", :primary_key => "relationshipid", :force => true do |t|
    t.integer  "relationship_lu_id", :limit => nil, :null => false
    t.integer  "status_lu_id",       :limit => nil, :null => false
    t.decimal  "delegator",                         :null => false
    t.decimal  "delegatee",                         :null => false
    t.datetime "auditdate",                         :null => false
    t.string   "audituser",          :limit => 50,  :null => false
    t.datetime "createdate",                        :null => false
    t.string   "createuser",         :limit => 50,  :null => false
  end

  create_table "relationship_lu", :primary_key => "relationship_lu_id", :force => true do |t|
    t.string "code",  :limit => 20
    t.string "label", :limit => 50
  end

  create_table "role", :primary_key => "roleid", :force => true do |t|
    t.integer  "role_lu_id",   :limit => nil, :null => false
    t.integer  "status_lu_id", :limit => nil, :null => false
    t.decimal  "partyid",                     :null => false
    t.datetime "auditdate",                   :null => false
    t.string   "audituser",    :limit => 50,  :null => false
    t.datetime "createdate",                  :null => false
    t.string   "createuser",   :limit => 50,  :null => false
  end

  create_table "role_lu", :primary_key => "role_lu_id", :force => true do |t|
    t.string "code",  :limit => 20
    t.string "label", :limit => 20
  end

  create_table "roletype_lu", :primary_key => "roletype_lu_id", :force => true do |t|
    t.string "roletype", :limit => 20
  end

  create_table "status_lu", :primary_key => "status_lu_id", :force => true do |t|
    t.string "code", :limit => 20
  end

  create_table "trimrecord", :primary_key => "trimrecordid", :force => true do |t|
    t.integer  "status_lu_id", :limit => nil,  :null => false
    t.string   "trimrefnumber",    :limit => 256,  :null => false
    t.string   "description",      :limit => 2000
    t.datetime "trimdate"
    t.decimal  "policyid"
    t.decimal  "originalpolicyid"
    t.decimal  "copydetailsid"
    t.datetime "auditdate",                        :null => false
    t.string   "audituser",        :limit => 50,   :null => false
    t.datetime "createdate",                       :null => false
    t.string   "createuser",       :limit => 50,   :null => false
    t.decimal  "partyid"
    t.decimal  "agreementid"
  end

  create_table "trimstatus_lu", :primary_key => "trimstatus_lu_id", :force => true do |t|
    t.string "trimstatus", :limit => 20
  end

end
