require 'test_helper'
require "forms/form"
require "forms/oral"

class OralHistoryFormTest < ActiveSupport::TestCase

  ###########################################
  # Q9
  #
  # Test Q9 a)
  def test_q9_a
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q9] = 'a'
    
    form_processor = Oral.new
    form_processor.process_question(test_agreement.agreementid.to_i, '9', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r40", permissions.first.rule, "Wrong rule created"
  end

  # Test Q9 b)
  def test_q9_b
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q9] = 'b'
    
    form_processor = Oral.new
    form_processor.process_question(test_agreement.agreementid.to_i, '9', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r43", permissions.first.rule, "Wrong rule created"
  end

  # Test Q9 c)
  def test_q9_c
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q9] = 'c'
      params[:q9_c_eventdate] = '12-08-2009'
      params[:q9_c_eventtext] = 'UNIT_TESTING_EVENT_TEXT'
    
    form_processor = Oral.new
    form_processor.process_question(test_agreement.agreementid.to_i, '9', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r44", permissions.first.rule, "Wrong rule created"

    assert_equal '12-08-2009', format_date_for_display(permissions.first.triggerdate), "Incorrect trigger date"
    assert_equal 'UNIT_TESTING_EVENT_TEXT', permissions.first.event, "Incorrect event text"
    assert_equal 'Until', permissions.first.eventoperator, 'Incorrect event operator'
  end

end

