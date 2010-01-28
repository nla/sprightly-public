require 'test_helper'
require "forms/form"
require "forms/multi"

class MultiFormTest < ActiveSupport::TestCase

  ###########################################
  # Q20
  #
  # Test Q20 a)
  def test_q20_a
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q20] = 'a'
    
    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '20', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r10", permissions.first.rule, "Wrong rule created"
  end

  # Test Q20 b)
  def test_q20_b
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q20] = 'b'
    
    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '20', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r14", permissions.first.rule, "Wrong rule created"
  end

end

