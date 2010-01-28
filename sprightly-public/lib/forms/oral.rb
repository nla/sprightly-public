# Represents the mapping of answers to rule creation for the Oral History form.
# This needs to be read against: http://ourweb.nla.gov.au/apps/wiki/display/RMP/Data+Mapping
class Oral < Form

  def process_question(agreementid, qid, params, user)
      super(agreementid, qid, params, user)
      case qid
        when "5" then
          case params[:q5]
          when "a" then
            save_permission(PermissionRules::Rule.r4)            
            save_permission(PermissionRules::Rule.r15)
            save_permission(PermissionRules::Rule.r21)
            save_permission(PermissionRules::Rule.r40)
          when "b" then
            #do nothing
          else
            @error = true
          end
        when "6" then
          case params[:q6]
          when "a" then save_permission(PermissionRules::Rule.r4)
          when "b" then save_permission(PermissionRules::Rule.r7)
          when "c" then save_permission(PermissionRules::Rule.r8)
          else
            @error = true
          end
        when "7" then
          case params[:q7]
          when "a" then save_permission(PermissionRules::Rule.r15)
          when "b" then save_permission(PermissionRules::Rule.r18)
          when "c" then save_permission(PermissionRules::Rule.r19)
          else
            @error = true
          end
        when "8" then
          case params[:q8]
          when "a" then save_permission(PermissionRules::Rule.r21)
          when "b" then save_permission(PermissionRules::Rule.r24)
          else
            @error = true
          end
        when "9" then
          case params[:q9]
          when "a" then save_permission(PermissionRules::Rule.r40)
          when "b" then save_permission(PermissionRules::Rule.r43)
          when "c" then save_permission(PermissionRules::Rule.r44)
          else
            @error = true
          end
      end
  end

end