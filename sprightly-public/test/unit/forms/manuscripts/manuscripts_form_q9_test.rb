require 'test_helper'
require "forms/form"
require "forms/manuscripts"

class ManuscriptsFormTest < ActiveSupport::TestCase
  
  ###########################################
  # Q9
  #
  # Test Q9 a)
  def test_q9_a
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q9] = 'a'
    
    form_processor = Manuscripts.new
    form_processor.process_question(test_agreement.agreementid.to_i, '9', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 2, form_processor.permission_count, "Incorrect permission count on form processor"
    assert_equal 2, permissions.length, "Incorrect number of permissions created"

    #Check Permissions match rules
    assert_equal 1, permissions.select{|p| p.rule=="r4"}.length, "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r10"}.length, "Incorrect rule created"
  end

  # Test Q9 b)
  def test_q9_b
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q9] = 'b'
    
    form_processor = Manuscripts.new
    form_processor.process_question(test_agreement.agreementid.to_i, '9', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 0,form_processor.permission_count, "Incorrect permission count on form processor"
    assert_equal 0, permissions.length, "Incorrect number of permissions created"
  end

# Test Q9 empty
  def test_q9_empty
    test_agreement = create_test_agreement
    # Check wrong value
    params = HashWithIndifferentAccess.new
      params[:q9] = 'UNIT_TESTING'
    
    form_processor = Manuscripts.new
    form_processor.process_question(test_agreement.agreementid.to_i, '9', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 0,form_processor.permission_count, "Incorrect permission count on form processor"
    assert_equal 0, permissions.length, "Incorrect number of permissions created"

    assert form_processor.error

    # Check nil value
    params = HashWithIndifferentAccess.new
    form_processor.process_question(test_agreement.agreementid.to_i, '9', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 0,form_processor.permission_count, "Incorrect permission count on form processor"
    assert_equal 0, permissions.length, "Incorrect number of permissions created"

    assert form_processor.error
  end

end

