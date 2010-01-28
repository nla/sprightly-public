require 'test_helper'
require "forms/form"
require "forms/manuscripts"

class ManuscriptsFormTest < ActiveSupport::TestCase
  
  ###########################################
  # q16
  #
  # Test q16 a)
  def test_q16_a
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q16] = 'a'

    form_processor = Manuscripts.new
    form_processor.process_question(test_agreement.agreementid.to_i, '16', params, 'UNIT_TESTING')

    # Get refreshed agreement
    test_agreement.reload

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 0, form_processor.permission_count, "Incorrect permission count on processor "
    assert_equal 0, permissions.length, "Incorrect number of permissions created"

    #Check Agreement Note is updated
    assert_match PermissionRules::Rule.r47, test_agreement.note, "Agreement note missing information"
  end

  # Test q16 b)
  def test_q16_b
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q16] = 'b'
    
    form_processor = Manuscripts.new
    form_processor.process_question(test_agreement.agreementid.to_i, '16', params, 'UNIT_TESTING')

    # Get refreshed agreement
    test_agreement.reload

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 0, form_processor.permission_count, "Incorrect permission count on form processor"
    assert_equal 0, permissions.length, "Incorrect number of permissions created"

    #Check Agreement Note is updated
    assert_match PermissionRules::Rule.r48, test_agreement.note, "Agreement note missing information"
  end

# Test q16 empty
  def test_q16_empty
    test_agreement = create_test_agreement
    # Check wrong value
    params = HashWithIndifferentAccess.new
      params[:q16] = 'UNIT_TESTING'
    
    form_processor = Manuscripts.new
    form_processor.process_question(test_agreement.agreementid.to_i, '16', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 0,form_processor.permission_count, "Incorrect permission count on form processor"
    assert_equal 0, permissions.length, "Incorrect number of permissions created"

    assert form_processor.error

    # Check nil value
    params = HashWithIndifferentAccess.new
    form_processor.process_question(test_agreement.agreementid.to_i, '16', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 0, permissions.length, "Incorrect number of permissions created"

    assert form_processor.error
  end

end

