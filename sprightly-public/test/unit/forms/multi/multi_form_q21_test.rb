require 'test_helper'
require "forms/form"
require "forms/multi"

class MultiFormTest < ActiveSupport::TestCase

  ###########################################
  # Q21
  #
  # Test Q21 a)
  def test_q21_a
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q21] = 'a'
    
    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '21', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r15", permissions.first.rule, "Wrong rule created"
  end

  # Test Q21 b)
  def test_q21_b
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q21] = 'b'
      params[:q21_b_exceptions] = 'UNIT_TESTING_EXCEPTION'
      params[:q21_b_eventdate] = '12-08-2009'
      params[:q21_b_eventtext] = 'UNIT_TESTING_EVENT_TEXT'
    
    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '21', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r16", permissions.first.rule, "Wrong rule created"

    assert_match 'UNIT_TESTING_EXCEPTION', permissions.first.note, "Permission Note missing information"
    assert_equal '12-08-2009', format_date_for_display(permissions.first.triggerdate), "Incorrect trigger date"
    assert_equal 'UNIT_TESTING_EVENT_TEXT', permissions.first.event, "Incorrect event text"
    assert_equal 'Until', permissions.first.eventoperator, 'Incorrect event operator'
  end

  # Test Q21 c
  def test_q21_c
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q21] = 'c'
      params[:q21_c_inclusions] = 'UNIT_TESTING_INCLUSION'
      params[:q21_c_eventdate] = '12-08-2009'
      params[:q21_c_eventtext] = 'UNIT_TESTING_EVENT_TEXT'
    
    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '21', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r17", permissions.first.rule, "Wrong rule created"

    assert_match 'UNIT_TESTING_INCLUSION', permissions.first.note, "Permission Note missing information"
    assert_equal '12-08-2009', format_date_for_display(permissions.first.triggerdate), "Incorrect trigger date"
    assert_equal 'UNIT_TESTING_EVENT_TEXT', permissions.first.event, "Incorrect event text"
    assert_equal 'Until', permissions.first.eventoperator, 'Incorrect event operator'
  end

  # Test Q21 d
  def test_q21_d
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q21] = 'd'
      params[:q21_d_eventdate] = '12-08-2009'
      params[:q21_d_eventtext] = 'UNIT_TESTING_EVENT_TEXT'
    
    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '21', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    #Check Permissions match rules
    assert_equal "r19", permissions.first.rule, "Wrong rule created"
  end

end

