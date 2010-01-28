require 'test_helper'
require "forms/form"
require "forms/pictures"

class PicturesFormTest < ActiveSupport::TestCase
  
  ###########################################
  # Q12
  #
  # Test Q12 a)
  def test_q12_a
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q12] = 'a'
    
    form_processor = Pictures.new
    form_processor.process_question(test_agreement.agreementid.to_i, '12', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r43", permissions.first.rule, "Wrong rule created"
  end

  # Test Q12 b)
  def test_q12_b
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q12] = 'b'
    
    form_processor = Pictures.new
    form_processor.process_question(test_agreement.agreementid.to_i, '12', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r46", permissions.first.rule, "Wrong rule created"
  end
end

