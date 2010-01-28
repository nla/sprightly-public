require 'test_helper'
require "forms/form"
require "forms/multi"

class MultiFormTest < ActiveSupport::TestCase

 ###########################################
  # Q19
  #
  # Test Q19 a
  def test_q19_a
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q19] = 'a'
      params[:q19_a_exceptions] = 'UNIT_TESTING_EXCEPTION'
      params[:q19_a_eventdate] = '12-08-2009'
      params[:q19_a_eventtext] = 'UNIT_TESTING_EVENT_TEXT'
    
    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '19', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r5", permissions.first.rule, "Incorrect rule created"

    assert_match 'UNIT_TESTING_EXCEPTION', permissions.first.note, "Permission Note missing information"
    assert_equal '12-08-2009', format_date_for_display(permissions.first.triggerdate), "Incorrect trigger date"
    assert_equal 'UNIT_TESTING_EVENT_TEXT', permissions.first.event, "Incorrect event text"
    assert_equal 'Until', permissions.first.eventoperator, 'Incorrect event operator'
  end

  # Test Q19 b
  def test_q19_b
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q19] = 'b'
      params[:q19_b_inclusions] = 'UNIT_TESTING_INCLUSION'
      params[:q19_b_eventdate] = '12-08-2009'
      params[:q19_b_eventtext] = 'UNIT_TESTING_EVENT_TEXT'
    
    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '19', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r6", permissions.first.rule, "Wrong rule created"

    assert_match 'UNIT_TESTING_INCLUSION', permissions.first.note, "Permission Note missing information"
    assert_equal '12-08-2009', format_date_for_display(permissions.first.triggerdate), "Incorrect trigger date"
    assert_equal 'UNIT_TESTING_EVENT_TEXT', permissions.first.event, "Incorrect event text"
    assert_equal 'Until', permissions.first.eventoperator, 'Incorrect event operator'
  end

  # Test Q19 c
  def test_q19_c
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q19] = 'c'
      params[:q19_c_eventdate] = '12-08-2009'
      params[:q19_c_eventtext] = 'UNIT_TESTING_EVENT_TEXT'
    
    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '19', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r8", permissions.first.rule, "Wrong rule created"

    assert_equal '12-08-2009', format_date_for_display(permissions.first.triggerdate), "Incorrect trigger date"
    assert_equal 'UNIT_TESTING_EVENT_TEXT', permissions.first.event, "Incorrect event text"
    assert_equal 'Until', permissions.first.eventoperator, 'Incorrect event operator'
  end

end

