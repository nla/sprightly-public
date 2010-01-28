# Represents the mapping of answers to rule creation for the Public Programs form.
# This needs to be read against: http://ourweb.nla.gov.au/apps/wiki/display/RMP/Data+Mapping
class Public < Form
  
  def process_question(agreementid, qid, params, user)
    super(agreementid, qid, params, user)

    # This is a special case to the other forms.
    # Each form only allows either a or b or c etc.
    # This form allows for a AND b AND c tec.

    if params.key?("q3_a")
      @answers[:q3] = 'a'
      save_permission(PermissionRules::Rule.r34)
    end

    if params.key?("q3_b")
      @answers[:q3] = 'b'
      save_permission(PermissionRules::Rule.r35)
    end

    if params.key?("q3_c")
      @answers[:q3] = 'c'
      save_permission(PermissionRules::Rule.r36)
    end
    
    if params.key?("q3_d")
      @answers[:q3] = 'd'
      save_permission(PermissionRules::Rule.r33)
    end
    
    if params.key?("q3_e")
      @answers[:q3] = 'e'
      save_permission(PermissionRules::Rule.r37)
    end
    
    if params.key?("q3_f")
      @answers[:q3] = 'f'
      save_permission(PermissionRules::Rule.r38)
    end
  end

end