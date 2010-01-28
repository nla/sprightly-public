require 'test_helper'
require "forms/form"
require "forms/oral"

class OralHistoryFormTest < ActiveSupport::TestCase
  
  ###########################################
  # Q5
  #
  # Test Q5 a)
  def test_q5_a
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q5] = 'a'
    
    form_processor = Oral.new
    form_processor.process_question(test_agreement.agreementid.to_i, '5', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 4, permissions.length, "Incorrect number of permissions created"
    assert_equal 4, form_processor.permission_count, "Incorrect permission count on processor "

    #Check Permissions match rules
    assert_equal 1, permissions.select{|p| p.rule=="r4"}.length, "Incorrect rule created"    
    assert_equal 1, permissions.select{|p| p.rule=="r15"}.length, "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r21"}.length, "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r40"}.length, "Incorrect rule created"
  end

  # Test Q5 b)
  def test_q5_b
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q5] = 'b'
    
    form_processor = Oral.new
    form_processor.process_question(test_agreement.agreementid.to_i, '5', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 0, permissions.length, "Incorrect number of permissions created"
    assert_equal 0,form_processor.permission_count, "Incorrect permission count on form processor"
  end

# Test Q5 empty
  def test_q5_empty
    test_agreement = create_test_agreement
    # Check wrong value
    params = HashWithIndifferentAccess.new
      params[:q5] = 'UNIT_TESTING'
    
    form_processor = Oral.new
    form_processor.process_question(test_agreement.agreementid.to_i, '5', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 0, permissions.length, "Incorrect number of permissions created"
    assert_equal 0,form_processor.permission_count, "Incorrect permission count on form processor"

    assert form_processor.error

    # Check nil value
    params = HashWithIndifferentAccess.new
    form_processor.process_question(test_agreement.agreementid.to_i, '5', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 0, permissions.length, "Incorrect number of permissions created"
    assert_equal 0,form_processor.permission_count, "Incorrect permission count on form processor"

    assert form_processor.error
  end

end

