require 'test_helper'
require "forms/form"
require "forms/manuscripts"

class ManuscriptsFormTest < ActiveSupport::TestCase
 

  ###########################################
  # Q10
  #
  # Test Q10 a
  def test_q10_a
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q10] = 'a'
    

    form_processor = Manuscripts.new
    form_processor.process_question(test_agreement.agreementid, "10", params, "UNIT_TESTING")
    
    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"


    #Check Permissions match rules
    assert_equal "r4", permissions.first.rule, "R4 rule not created"
  end

  # Test Q10 b
  def test_q10_b
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new 
    params[:q10] = 'b'
    params[:q10_b_exceptions] = 'UNIT_TESTING_EXCEPTION'
    params[:q10_b_eventdate] = '12-08-2009'
    params[:q10_b_eventtext] = 'UNIT_TESTING_EVENT_TEXT'
    
    
    form_processor = Manuscripts.new
    form_processor.process_question(test_agreement.agreementid.to_i, '10', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"

    #Check Permissions match rules
    assert_equal "r5", permissions.first.rule, "Wrong rule created"
    
    assert_match 'UNIT_TESTING_EXCEPTION', permissions.first.note, "Permission Note missing information"
    assert_equal '12-08-2009', format_date_for_display(permissions.first.triggerdate), "Incorrect trigger date"
    assert_equal 'UNIT_TESTING_EVENT_TEXT', permissions.first.event, "Incorrect event text"
    assert_equal 'Until', permissions.first.eventoperator, 'Incorrect event operator'
  end

  # Test Q10 c
  def test_q10_c
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new 
    params[:q10] = 'c'
    params[:q10_c_eventdate] = '12-08-2009'
    params[:q10_c_eventtext] = 'UNIT_TESTING_EVENT_TEXT'
    
    form_processor = Manuscripts.new
    form_processor.process_question(test_agreement.agreementid.to_i, '10', params, 'UNIT_TESTING')

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

  # Test Q10 d
  def test_q10_d
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new 
    params[:q10] = 'd'
    params[:q10_d_eventdate] = '12-08-2009'
    params[:q10_d_eventtext] = 'UNIT_TESTING_EVENT_TEXT'
    
    form_processor = Manuscripts.new
    form_processor.process_question(test_agreement.agreementid.to_i, '10', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r9", permissions.first.rule, "Wrong rule created"

    assert_equal '12-08-2009', format_date_for_display(permissions.first.triggerdate), "Incorrect trigger date"
    assert_equal 'UNIT_TESTING_EVENT_TEXT', permissions.first.event, "Incorrect event text"
    assert_equal 'Until', permissions.first.eventoperator, 'Incorrect event operator'
  end

end

