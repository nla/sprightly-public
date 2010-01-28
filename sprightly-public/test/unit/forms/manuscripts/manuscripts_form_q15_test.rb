require 'test_helper'
require "forms/form"
require "forms/manuscripts"

class ManuscriptsFormTest < ActiveSupport::TestCase
  
  ###########################################
  # Q15
  #
  # Test Q15 a)
  def test_q15_a
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q15] = 'a'
      params[:q15_a_exceptions] = 'UNIT_TESTING_EXCEPTION'
      params[:q15_a_eventdate] = '12-08-2009'
      params[:q15_a_eventtext] = 'UNIT_TESTING_EVENT_TEXT'
    
    form_processor = Manuscripts.new
    form_processor.process_question(test_agreement.agreementid.to_i, '15', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r41", permissions.first.rule, "Wrong rule created"

    assert_match 'UNIT_TESTING_EXCEPTION', permissions.first.note, "Permission Note missing information"
    assert_equal '12-08-2009', format_date_for_display(permissions.first.triggerdate), "Incorrect trigger date"
    assert_equal 'UNIT_TESTING_EVENT_TEXT', permissions.first.event, "Incorrect event text"
    assert_equal 'Until', permissions.first.eventoperator, 'Incorrect event operator'
  end

  # Test Q15 b)
  def test_q15_b
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q15] = 'b'
      params[:q15_b_eventdate] = '12-08-2009'
      params[:q15_b_eventtext] = 'UNIT_TESTING_EVENT_TEXT'
    
    form_processor = Manuscripts.new
    form_processor.process_question(test_agreement.agreementid.to_i, '15', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r45", permissions.first.rule, "Wrong rule created"

    assert_equal '12-08-2009', format_date_for_display(permissions.first.triggerdate), "Incorrect trigger date"
    assert_equal 'UNIT_TESTING_EVENT_TEXT', permissions.first.event, "Incorrect event text"
    assert_equal 'Until', permissions.first.eventoperator, 'Incorrect event operator'
  end
end

