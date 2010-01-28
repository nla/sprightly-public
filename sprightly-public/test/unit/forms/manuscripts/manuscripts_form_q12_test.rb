require 'test_helper'
require "forms/form"
require "forms/manuscripts"

class ManuscriptsFormTest < ActiveSupport::TestCase
  
  ###########################################
  # Q12
  #
  # Test Q12 a)
  def test_q12_a
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q12] = 'a'
    
    form_processor = Manuscripts.new
    form_processor.process_question(test_agreement.agreementid.to_i, '12', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"

    #Check Permissions match rules
    assert_equal "r15", permissions.first.rule, "Wrong rule created"
  end

  # Test Q12 b)
  def test_q12_b
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q12] = 'b'
    params[:q12_b_exceptions] = 'UNIT_TESTING_EXCEPTION'
    params[:q12_b_eventdate] = '12-08-2009'
    params[:q12_b_eventtext] = 'UNIT_TESTING_EVENT_TEXT'
    
    form_processor = Manuscripts.new
    form_processor.process_question(test_agreement.agreementid.to_i, '12', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    
    #Check Permissions match rules
    assert_equal "r16", permissions.first.rule, "Wrong rule created"

    assert_match 'UNIT_TESTING_EXCEPTION', permissions.first.note, "Permission Note missing information"
    assert_equal '12-08-2009', format_date_for_display(permissions.first.triggerdate), "Incorrect trigger date"
    assert_equal 'UNIT_TESTING_EVENT_TEXT', permissions.first.event, "Incorrect event text"
    assert_equal 'Until', permissions.first.eventoperator, 'Incorrect event operator'
  end

  # Test Q12 c
  def test_q12_c
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q12] = 'c'
    params[:q12_c_eventdate] = '12-08-2009'
    params[:q12_c_eventtext] = 'UNIT_TESTING_EVENT_TEXT'
    
    form_processor = Manuscripts.new
    form_processor.process_question(test_agreement.agreementid.to_i, '12', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r19", permissions.first.rule, "Wrong rule created"

    assert_equal '12-08-2009', format_date_for_display(permissions.first.triggerdate), "Incorrect trigger date"
    assert_equal 'UNIT_TESTING_EVENT_TEXT', permissions.first.event, "Incorrect event text"
    assert_equal 'Until', permissions.first.eventoperator, 'Incorrect event operator'
  end

end

