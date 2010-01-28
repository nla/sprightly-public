# Represents the mapping of answers to rule creation for the Manuscripts form.
# This needs to be read against: http://ourweb.nla.gov.au/apps/wiki/display/RMP/Data+Mapping
class Manuscripts < Form

  def process_question(agreementid, qid, params, user)
      super(agreementid, qid, params, user)
      case qid
        when "8" then
          case params[:q8]
          when "a" then
            save_permission(PermissionRules::Rule.r4)
            save_permission(PermissionRules::Rule.r10)
            save_permission(PermissionRules::Rule.r15)
            save_permission(PermissionRules::Rule.r40)
          when "b" then
            # do nothing
          else
            @error = true
          end
        when "9" then          
          case params[:q9]
          when "a" then
            save_permission(PermissionRules::Rule.r4)
            save_permission(PermissionRules::Rule.r10)
          when "b" then
            # do nothing
          else
            @error = true
          end
        when "10" then
          case params[:q10]
          when "a" then save_permission(PermissionRules::Rule.r4)
          when "b" then save_permission(PermissionRules::Rule.r5)
          when "c" then save_permission(PermissionRules::Rule.r8)
          when "d" then save_permission(PermissionRules::Rule.r9)
          else
            @error = true
          end
        when "12" then
          case params[:q12]
          when "a" then save_permission(PermissionRules::Rule.r15)
          when "b" then save_permission(PermissionRules::Rule.r16)
          when "c" then save_permission(PermissionRules::Rule.r19)
          else
            @error = true
          end
        when "13" then
          case params[:q13]
          when "a" then save_permission(PermissionRules::Rule.r21)
          when "b" then save_permission(PermissionRules::Rule.r22)
          when "c" then save_permission(PermissionRules::Rule.r25)
          when "d" then save_permission(PermissionRules::Rule.r26)
          else
            @error = true
          end
        when "14" then
          case params[:q14]
          when "a" then save_permission(PermissionRules::Rule.r27)
          when "b" then save_permission(PermissionRules::Rule.r28)
          when "c" then save_permission(PermissionRules::Rule.r30)
          when "d" then
            save_permission(PermissionRules::Rule.r31) if params.key?("q14_d_a")
            save_permission(PermissionRules::Rule.r49) if not params.key?("q14_d_a")
            save_permission(PermissionRules::Rule.r32) if params.key?("q14_d_b")
            save_permission(PermissionRules::Rule.r50) if not params.key?("q14_d_b")
            save_permission(PermissionRules::Rule.r33) if params.key?("q14_d_c")
            save_permission(PermissionRules::Rule.r51) if not params.key?("q14_d_c")
          when "e" then save_permission(PermissionRules::Rule.r39)
          else
            @error = true
          end
        when "15" then
          case params[:q15]
          when "a" then save_permission(PermissionRules::Rule.r41)
          when "b" then save_permission(PermissionRules::Rule.r45)
          else
            @error = true
          end
        when "16" then
          case params[:q16]
          when "a" then
            # Update Agreement.note
            agreement = Agreement.find(@agreementid)
            if agreement.note.blank? then
              agreement.note = PermissionRules::Rule.r47
            else
              agreement.note += "\n\n"
              agreement.note += PermissionRules::Rule.r47
            end
            agreement.auditdate = Date.today
            agreement.audituser = @user
            if agreement.save then
              @message = "Agreement Note added. See Agreement Details."
            else
              @error = true
            end
          when "b" then
            # Update Agreement.note
            agreement = Agreement.find(@agreementid)
            if agreement.note.blank? then
              agreement.note = PermissionRules::Rule.r48
            else
              agreement.note += "\n\n"
              agreement.note += PermissionRules::Rule.r48
            end
            agreement.auditdate = Date.today
            agreement.audituser = @user
            if agreement.save then
              @message = "Agreement Note added. See Agreement Details."
            else
              @error = true
            end
          else
            @error = true
          end
      end
  end

end