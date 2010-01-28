require 'permission_rules/permission_holder'

# Migrates the pictures data upload in 2008 from policies into the new permission structure
class MigratePoliciesToPermissions < ActiveRecord::Migration

  class Policy < ActiveRecord::Base
    set_primary_key "policyid"
    set_sequence_name "SQ_POLICY"
  end

  def self.up
    puts "Copying Follow-on policies and Permission policies to permission table ..."

    # Policytype_lu_id: 2 = follow-on, 3 = permission
    # Policystatus_lu_id: 1 = active
    # Ignoring the base policies, deleted policies
    Policy.find_by_sql("select * from policy where (policytype_lu_id = 2 or policytype_lu_id = 3) and policystatus_lu_id = 1 and partyid is not null").each_with_index do |policy, index|
      
      puts index

      permission = Permission.new
      permission.status_lu_id = StatusLu.active

      # Grab some of the old data
      permission.note = policy.note
      permission.triggerdate = policy.enddate
      permission.agreementid = policy.agreementid
      permission.audituser = policy.audituser
      permission.auditdate = policy.auditdate
      permission.createuser = policy.createuser
      permission.createdate = policy.createdate

      condition = Condition.find(:first, :conditions => {:policyid => policy.policyid})
      if !condition.nil?
        permission.timeoperator = condition.timeoperator
        permission.timeyears = condition.timeyears
        permission.eventoperator = condition.eventoperator
        permission.event = condition.event
      end

      # Policy to permission mapping
      case policy.policy_lu_id.to_i
        #Open
        when 1 then
          if policy.details.match(/^Copyright transferred/)
            save_permission(permission, PermissiontypeLu.publishing, PermissionpolicyLu.open, nil, PermissionHolder.nla, "copyright transferred to the Library")
          elsif policy.details.match(/^Transfer copyright/)
            permission.event = "After copyright owner's death"
            save_permission(permission, PermissiontypeLu.publishing, PermissionpolicyLu.open, nil, PermissionHolder.nla, "copyright transferred to the Library after copyright owner's death")
          elsif policy.details.match(/^NLA permitted to exhibit and loan/)
            save_permission(permission, PermissiontypeLu.exhibition, PermissionpolicyLu.open, nil, PermissionHolder.everyone, "exhibition allowed at the Library and other institutions")
          elsif policy.details.match(/^NLA permitted to reproduce material in NLA/)
            save_permission(permission, PermissiontypeLu.publishing, PermissionpolicyLu.open, PermissionpurposeLu.publications, PermissionHolder.nla, "the Library may use in its own publications")
          elsif policy.details.match(/^NLA permitted to reproduce material for publicity/)
            save_permission(permission, PermissiontypeLu.publishing, PermissionpolicyLu.open, PermissionpurposeLu.publicity, PermissionHolder.nla, "the Library may use for the purpose of publicising the Library")
          elsif policy.details.match(/^NLA permitted to reproduce material for merchandising/)
            save_permission(permission, PermissiontypeLu.publishing, PermissionpolicyLu.open, PermissionpurposeLu.merchandise, PermissionHolder.nla, "the Library may in merchandise issued by the Library")
          elsif policy.details.match(/^NLA permitted to make digital copies/)
            save_permission(permission, PermissiontypeLu.publishing, PermissionpolicyLu.open, PermissionpurposeLu.online, PermissionHolder.nla, "publishing digital copies on websites allowed")
          elsif policy.details.match(/^NLA may make and sell copies/)
            save_permission(permission, PermissiontypeLu.publishing, PermissionpolicyLu.open, nil, PermissionHolder.nla, "the Library may make and sell copies to 3rd parties")
          elsif policy.details.match(/^NLA may authorise/)
            save_permission(permission, PermissiontypeLu.publishing, PermissionpolicyLu.open, PermissionpurposeLu.publicity, PermissionHolder.nla, "publishing and public use by people and organisations other than the Library allowed")              
        end          
        # R4
        when 5 then
          #elsif policy.purpose.match(/^NLA permitted to make working/)
          if policy.details.match(/^Reader access/)
            save_permission(permission, PermissiontypeLu.access, PermissionpolicyLu.open, nil, PermissionHolder.everyone, "access allowed on the Library's premises or while on loan in other libraries")
          elsif policy.details.match(/^NLA permitted to make working/)
            save_permission(permission, PermissiontypeLu.copying, PermissionpolicyLu.open, nil, PermissionHolder.nla, "copying by the Library allowed for preservation purposes (working copies)")
          elsif policy.details.match(/^NLA may permit/)
            save_permission(permission, PermissiontypeLu.copying, PermissionpolicyLu.open, PermissionpurposeLu.online, PermissionHolder.everyone, "copying allowed from websites for research, study or personal use")
          end
        # Uncertain
        when 12 then
          # Do not create a permission
          # Add an agreement note
          agreement = Agreement.find(policy.agreementid)
          if agreement.note.blank?
            agreement.note = "Other conditions apply, see TRIM references."
          else
            agreement.note << " Other conditions apply, see TRIM references."
          end
          agreement.save
        # Partial
        when 13 then
          # Do not create a permission
          # Add an agreement note
          agreement = Agreement.find(policy.agreementid)
          if agreement.note.blank?
            agreement.note = "Conditions apply to some works, see TRIM references."
          else
            agreement.note << " Conditions apply to some works, see TRIM references."
          end
          agreement.save
         
          # Closed
        when 14 then
          if policy.details.match(/^no reader/)
            save_permission(permission, PermissiontypeLu.access, PermissionpolicyLu.closed, nil, PermissionHolder.everyone, "access restricted, closed")
          elsif policy.details.match(/^not permitted to make working/)
            save_permission(permission, PermissiontypeLu.copying, PermissionpolicyLu.closed, nil, PermissionHolder.nla, "copying for preservation purposes (working copies) restricted, closed")
          elsif policy.details.match(/^not permitted to exhibit/)
            save_permission(permission, PermissiontypeLu.exhibition, PermissionpolicyLu.closed, nil, PermissionHolder.everyone, "exhibition restricted, refer all requests to rights holder")
          elsif policy.details.match(/^not permitted to reproduce material in/)
            save_permission(permission, PermissiontypeLu.publishing, PermissionpolicyLu.closed, PermissionpurposeLu.publications, PermissionHolder.nla, "publishing in Library publications restricted, refer all requests to rights holder")
          elsif policy.details.match(/^not permitted to reproduce material for publicity/)
            save_permission(permission, PermissiontypeLu.publishing, PermissionpolicyLu.closed, PermissionpurposeLu.publicity, PermissionHolder.nla, "use for the purpose of publicising the Library restrocted, refer all requests to rights holder")
          elsif policy.details.match(/^not permitted to reproduce material for merchandising/)
            save_permission(permission, PermissiontypeLu.publishing, PermissionpolicyLu.closed, PermissionpurposeLu.merchandise, PermissionHolder.nla, "use in merchandise restricted, refer all requests to rights holder")
          elsif policy.details.match(/^not permitted to make digital copies/)
            save_permission(permission, PermissiontypeLu.publishing, PermissionpolicyLu.closed, PermissionpurposeLu.online, PermissionHolder.nla, "publishing digital copies on websites restricted, closed")
          elsif policy.details.match(/^no access to digital copies/)
            save_permission(permission, PermissiontypeLu.copying, PermissionpolicyLu.closed, PermissionpurposeLu.online, PermissionHolder.everyone, "copying not allowed from websites for research, study or personal use")
          elsif policy.details.match(/^not permitted to make and sell/)
            save_permission(permission, PermissiontypeLu.publishing, PermissionpolicyLu.closed, nil, PermissionHolder.nla, "selling copies to 3rd parties restricted, refer all requests to rights holder")
          elsif policy.details.match(/^not permitted to authorise/)
            save_permission(permission, PermissiontypeLu.publishing, PermissionpolicyLu.closed, nil, PermissionHolder.nla, "all requests to rights holder")
          end
      end

    end
  end

  
  def self.down
    puts "Truncating table permission ..."
    Permission.delete_all
  end

  private

    
    def self.save_permission(permission, permissiontype, permissionpolicy, permissionpurpose, permissionholder, details)
      permission.permissiontype_lu_id = PermissiontypeLu.find_by_code(permissiontype).permissiontype_lu_id
      permission.permissionpolicy_lu_id = PermissionpolicyLu.find_by_code(permissionpolicy).permissionpolicy_lu_id
      permission.permissionpurpose_lu_id = PermissionpurposeLu.find_by_code(permissionpurpose).permissionpurpose_lu_id if !permissionpurpose.nil?
      permission.permissionholder = permissionholder
      permission.details = details

      permission.save

      permission.originalpermissionid = permission.permissionid
      permission.save

      return true
    end


end
