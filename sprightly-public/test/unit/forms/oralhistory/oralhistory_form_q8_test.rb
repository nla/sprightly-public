require 'test_helper'
require "forms/form"
require "forms/oral"

class OralHistoryFormTest < ActiveSupport::TestCase

  ###########################################
  # Q8
  #
  # Test Q8 a)
  def test_q8_a
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q8] = 'a'
    
    form_processor = Oral.new
    form_processor.process_question(test_agreement.agreementid.to_i, '8', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r21", permissions.first.rule, "Wrong rule created"
  end

  # Test Q8 b
  def test_q8_b
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q8] = 'b'
      params[:q8_b_eventdate] = '12-08-2009'
      params[:q8_b_eventtext] = 'UNIT_TESTING_EVENT_TEXT'
    
    form_processor = Oral.new
    form_processor.process_question(test_agreement.agreementid.to_i, '8', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    #Check Permissions match rules
    assert_equal "r24", permissions.first.rule, "Wrong rule created"

    assert_equal '12-08-2009', format_date_for_display(permissions.first.triggerdate), "Incorrect trigger date"
    assert_equal 'UNIT_TESTING_EVENT_TEXT', permissions.first.event, "Incorrect event text"
    assert_equal 'Until', permissions.first.eventoperator, 'Incorrect event operator'
  end

end

