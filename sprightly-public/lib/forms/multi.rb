# Represents the mapping of answers to rule creation for the Multi form.
# This needs to be read against: http://ourweb.nla.gov.au/apps/wiki/display/RMP/Data+Mapping
class Multi < Form

  def process_question(agreementid, qid, params, user)
      super(agreementid, qid, params, user)
      case qid
        when "17" then
          case params[:q17]
            when "a" then
              save_permission(PermissionRules::Rule.r4)
              save_permission(PermissionRules::Rule.r10)
              save_permission(PermissionRules::Rule.r15)
              save_permission(PermissionRules::Rule.r40)
            when "b" then
              #do nothing
          else
            @error = true
          end
        when "18" then
          case params[:q18]
          when "a" then
            save_permission(PermissionRules::Rule.r4)
            save_permission(PermissionRules::Rule.r10)
          when "b" then
            #do nothing
          else
            @error = true
          end
        when "19" then
          case params[:q19]
          when "a" then save_permission(PermissionRules::Rule.r5)
          when "b" then save_permission(PermissionRules::Rule.r6)
          when "c" then save_permission(PermissionRules::Rule.r8)
          else
            @error = true
          end
        when "20" then
          case params[:q20]
          when "a" then save_permission(PermissionRules::Rule.r10)
          when "b" then save_permission(PermissionRules::Rule.r14)
          else
            @error = true
          end
        when "21" then
          case params[:q21]
          when "a" then save_permission(PermissionRules::Rule.r15)
          when "b" then save_permission(PermissionRules::Rule.r16)
          when "c" then save_permission(PermissionRules::Rule.r17)
          when "d" then save_permission(PermissionRules::Rule.r19)
          else
            @error = true
          end
        when "22" then
          case params[:q22]
          when "a" then save_permission(PermissionRules::Rule.r21)
          when "b" then save_permission(PermissionRules::Rule.r22)
          when "c" then save_permission(PermissionRules::Rule.r25)
          when "d" then save_permission(PermissionRules::Rule.r23)
          when "e" then save_permission(PermissionRules::Rule.r26)
          else
            @error = true
          end
        when "23" then
          case params[:q23]
          when "a" then save_permission(PermissionRules::Rule.r27)
          when "b" then save_permission(PermissionRules::Rule.r28)
          when "c" then save_permission(PermissionRules::Rule.r29)
          when "d" then save_permission(PermissionRules::Rule.r30)
          when "e" then
            save_permission(PermissionRules::Rule.r31) if params.key?("q23_e_a")
            save_permission(PermissionRules::Rule.r49) if not params.key?("q23_e_a")
            save_permission(PermissionRules::Rule.r32) if params.key?("q23_e_b")
            save_permission(PermissionRules::Rule.r50) if not params.key?("q23_e_b")
            save_permission(PermissionRules::Rule.r33) if params.key?("q23_e_c")
            save_permission(PermissionRules::Rule.r51) if not params.key?("q23_e_c")
          when "f" then save_permission(PermissionRules::Rule.r39)
          else
            @error = true
          end
        when "24" then
          case params[:q24]
          when "a" then save_permission(PermissionRules::Rule.r41)
          when "b" then save_permission(PermissionRules::Rule.r42)
          when "c" then save_permission(PermissionRules::Rule.r45)
          when "d" then save_permission(PermissionRules::Rule.r46)
          else
            @error = true
          end
      end
  end

end