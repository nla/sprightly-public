require 'test_helper'
require "forms/form"
require "forms/multi"

class MultiFormTest < ActiveSupport::TestCase

  ###########################################
  # Q18
  #
  # Test Q18 a)
  def test_q18_a
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q18] = 'a'
    
    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '18', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 2, permissions.length, "Incorrect number of permissions created"
    assert_equal 2, form_processor.permission_count, "Incorrect permission count on form processor"

    #Check Permissions match rules
    assert_equal 1, permissions.select{|p| p.rule=="r4"}.length, "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r10"}.length, "Incorrect rule created"
  end

  # Test Q18 b)
  def test_q18_b
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q18] = 'b'
    
    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '18', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 0, permissions.length, "Incorrect number of permissions created"
    assert_equal 0,form_processor.permission_count, "Incorrect permission count on form processor"
  end

# Test Q18 empty
  def test_q18_empty
    test_agreement = create_test_agreement
    # Check wrong value
    params = HashWithIndifferentAccess.new
      params[:q18] = 'UNIT_TESTING'
    
    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '18', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 0, permissions.length, "Incorrect number of permissions created"
    assert_equal 0,form_processor.permission_count, "Incorrect permission count on form processor"
    assert form_processor.error

    # Check nil value
    params = HashWithIndifferentAccess.new
    form_processor.process_question(test_agreement.agreementid.to_i, '18', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 0, permissions.length, "Incorrect number of permissions created"
    assert_equal 0,form_processor.permission_count, "Incorrect permission count on form processor"

    assert form_processor.error
  end

end

