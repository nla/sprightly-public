require 'net/http'
require 'uri'

include Net

# A User as represented in the UMS.

class User

  # The :group is either an administrator or updater or nil
  # If the group is nil the user can only view the details
  attr_accessor :id, :session_nonce, :group

  ADMINISTRATOR = "rms:administrator"
  UPDATER = "rms:updater"

  # Create a new user and validate the user/password against the UMS.
  #def initialize(id, password)
  #  auth_url = SERVICE_UMS + 'authenticateNLAId/' + id.strip.downcase + '/' + password.gsub(/#/,'%23') # hash needs explicit encoding
  #  response = HTTP.get_response(URI.parse(auth_url))
  #  case response
  #    when HTTPSuccess then
  #      @id = id.strip.downcase
  #      @session_nonce = Util::XmlUtil.get_attribute_text(Document.new(response.body), "//authentication/@sessionNonce")
  #      @group = get_group
  #      true
  #    else
  #      false
  #  end
  #end

  # Valid Users
  # admin - 123 = administrator
  # kangaroo - 123 = updater
  # emu - 123 = user
  def initialize(id, password)

    if id == 'admin' && password == '123'
        @id = id
        @session_nonce = '123'
        @group = ADMINISTRATOR
    elsif id == 'kangaroo' && password == '123'
        @id = id
        @session_nonce = '123'
        @group = UPDATER
    elsif id == 'emu' && password == '123'
        @id = id
        @session_nonce = '123'
        @group = 'user'
    else
      false
    end
    true
  end

  # Determines if the user has been authenticated.
  # All authenticated users will have a session_nonce
  # from the UMS.
  def authenticate?
    if @session_nonce.nil?
      return false
    else
      return true
    end
  end

  # Is the current user an administrator?
  def administrator?
    return true if @group.eql?(ADMINISTRATOR)
    false
  end

  # Is the current user an updater?
  def updater?
    return true if @group.eql?(ADMINISTRATOR) || @group.eql?(UPDATER)
    false
  end

  private

  # Determines which group the user belongs
  # Currently there are 3 types of users:
  # 1- rms:administrator
  # 2- rms:updater
  # 3- No group. This means only view access.
  def get_group
    return ADMINISTRATOR if is_member_of_group?(ADMINISTRATOR)
    return UPDATER if is_member_of_group?(UPDATER)
    return nil
  end

  def is_member_of_group?(group)
    query_url = SERVICE_UMS + 'userCapability?userid=user:' + @id + '&sessionNonce=' + @session_nonce + "&isMemberOfGroup=" + group
    response = HTTP.get_response(URI.parse(query_url))
    case response
    when HTTPSuccess then
      XPath.each(Document.new(response.body), "//yes" ) { return true }
      return false
    else
      false
    end
  end

end