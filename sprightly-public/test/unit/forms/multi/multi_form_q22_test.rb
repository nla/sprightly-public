require 'test_helper'
require "forms/form"
require "forms/multi"

class MultiFormTest < ActiveSupport::TestCase

  ###########################################
  # Q22
  #
  # Test Q22 a)
  def test_q22_a
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q22] = 'a'
    
    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '22', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r21", permissions.first.rule, "Wrong rule created"
  end

  # Test Q22 b)
  def test_q22_b
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q22] = 'b'
      params[:q22_b_exceptions] = 'UNIT_TESTING_EXCEPTION'
      params[:q22_b_eventdate] = '12-08-2009'
      params[:q22_b_eventtext] = 'UNIT_TESTING_EVENT_TEXT'
    
    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '22', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r22", permissions.first.rule, "Wrong rule created"

    assert_match 'UNIT_TESTING_EXCEPTION', permissions.first.note, "Permission Note missing information"
    assert_equal '12-08-2009', format_date_for_display(permissions.first.triggerdate), "Incorrect trigger date"
    assert_equal 'UNIT_TESTING_EVENT_TEXT', permissions.first.event, "Incorrect event text"
    assert_equal 'Until', permissions.first.eventoperator, 'Incorrect event operator'
  end

  # Test Q22 c
  def test_q22_c
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q22] = 'c'
      params[:q22_c_eventdate] = '12-08-2009'
      params[:q22_c_eventtext] = 'UNIT_TESTING_EVENT_TEXT'
    
    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '22', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    #Check Permissions match rules
    assert_equal "r25", permissions.first.rule, "Wrong rule created"

    assert_equal '12-08-2009', format_date_for_display(permissions.first.triggerdate), "Incorrect trigger date"
    assert_equal 'UNIT_TESTING_EVENT_TEXT', permissions.first.event, "Incorrect event text"
    assert_equal 'Until', permissions.first.eventoperator, 'Incorrect event operator'
  end

def test_q22_d
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q22] = 'd'
      params[:q22_d_inclusions] = 'UNIT_TESTING_INCLUSION'
      params[:q22_d_eventdate] = '12-08-2009'
      params[:q22_d_eventtext] = 'UNIT_TESTING_EVENT_TEXT'
    
    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '22', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r23", permissions.first.rule, "Wrong rule created"

    assert_match 'UNIT_TESTING_INCLUSION', permissions.first.note, "Permission Note missing information"
    assert_equal '12-08-2009', format_date_for_display(permissions.first.triggerdate), "Incorrect trigger date"
    assert_equal 'UNIT_TESTING_EVENT_TEXT', permissions.first.event, "Incorrect event text"
    assert_equal 'Until', permissions.first.eventoperator, 'Incorrect event operator'
  end

  def test_q22_e
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q22] = 'e'
    
    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '22', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r26", permissions.first.rule, "Wrong rule created"
  end

end

