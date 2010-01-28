# Super class with common mehtods for each form to rule mapping
class Form

  attr_accessor :display_question, :qid, :permission_count, :error, :agreementid, :answers, :user, :message

  # @param Agreementid The AGREEMENT.agreementid
  # @param qid The question that has been answered i.e. 9
  # @param params The params hash submitted from the form
  # @param user The userid creating who answered the question
  def process_question(agreementid, qid, params, user)
    @agreementid = agreementid
    @qid = qid
    @answers = params
    @user = user
    @permission_count = 0
    @error = false
    @message = nil
  end

  # Saves the permission
  # Returns true if successful otherwise false
  #
  # @param permission A PERMISSION model object
  # 
  #def save_permission(agreementid, permission, exceptions, event_date, event_text, event_operator, user)
  def save_permission(permission)
    option = "q" + @qid
    key = "q" + @qid + "_" + @answers.fetch(option) + "_" # i.e. q8_c_
    
    permission.agreementid = @agreementid
    permission.note = @answers.fetch(key + "exceptions") if @answers.key?(key + "exceptions")
    permission.note = @answers.fetch(key + "inclusions") if @answers.key?(key + "inclusions")
    permission.triggerdate = @answers.fetch(key + "eventdate") if @answers.key?(key + "eventdate")
    permission.event = @answers.fetch(key + "eventtext") if @answers.key?(key + "eventtext")
    permission.eventoperator = "Until" if @answers.key?(key + "eventtext") || @answers.key?(key + "eventdate")
    permission.status_lu_id = StatusLu.active
    permission.createdate = Date.today
    permission.createuser = @user
    permission.auditdate = Date.today
    permission.audituser = @user

    if permission.save
      permission.originalpermissionid = permission.permissionid
      permission.save
      @permission_count = @permission_count + 1
      return true
    else
      @error = true
    end

    return false
  end
end