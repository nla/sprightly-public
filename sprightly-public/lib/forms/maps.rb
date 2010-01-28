# Represents the mapping of answers to rule creation for the Manuscripts form.
# This needs to be read against: http://ourweb.nla.gov.au/apps/wiki/display/RMP/Data+Mapping
class Maps < Form

  def process_question(agreementid, qid, params, user)
      super(agreementid, qid, params, user)
      case qid
        when "10" then
          case params[:q10]
          when "a" then
            save_permission(PermissionRules::Rule.r4)
            save_permission(PermissionRules::Rule.r10)
            save_permission(PermissionRules::Rule.r15)
            save_permission(PermissionRules::Rule.r40)
          when "b" then 
            save_permission(PermissionRules::Rule.r4)
            save_permission(PermissionRules::Rule.r10)
            save_permission(PermissionRules::Rule.r15)
            save_permission(PermissionRules::Rule.r21)
          else
            @error = true
          end
        when "11" then
          case params[:q11]
          when "a" then save_permission(PermissionRules::Rule.r27)
          when "b" then
            save_permission(PermissionRules::Rule.r31) if params.key?("q11_b_a")
            save_permission(PermissionRules::Rule.r49) if not params.key?("q11_b_a")
            save_permission(PermissionRules::Rule.r32) if params.key?("q11_b_b")
            save_permission(PermissionRules::Rule.r50) if not params.key?("q11_b_b")
            save_permission(PermissionRules::Rule.r33) if params.key?("q11_b_c")
            save_permission(PermissionRules::Rule.r51) if not params.key?("q11_b_c")
          when "c" then save_permission(PermissionRules::Rule.r39)
          else
            @error = true
          end
        when "12" then
          case params[:q12]
          when "a" then save_permission(PermissionRules::Rule.r43)
          when "b" then save_permission(PermissionRules::Rule.r46)
          else
            @error = true
          end
      end
  end

end