require 'test_helper'
require "forms/form"
require "forms/public"

class PublicFormTest < ActiveSupport::TestCase
  
  ###########################################
  # Q3
  #
  # Test Q3 a)
  def test_q3_a
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q3_a] = 'checked'
    params[:q3_a_inclusions] = 'UNIT_TESTING_EXHIBITION'

    form_processor = Public.new
    form_processor.process_question(test_agreement.agreementid.to_i, '3', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r34", permissions.first.rule, "Wrong rule created"
    
    assert_match 'UNIT_TESTING_EXHIBITION', permissions.first.note, "Permission Note missing information"
  end

  # Test Q3 b)
  def test_q3_b
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q3_b] = 'checked'
    params[:q3_b_inclusions] = 'UNIT_TESTING_PUBLICATION'
    
    form_processor = Public.new
    form_processor.process_question(test_agreement.agreementid.to_i, '3', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r35", permissions.first.rule, "Wrong rule created"
    
    assert_match 'UNIT_TESTING_PUBLICATION', permissions.first.note, "Permission Note missing information"
  end

  # Test Q3 c)
  def test_q3_c
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q3_c] = 'checked'
    params[:q3_c_inclusions] = 'UNIT_TESTING_PUBLICATION'
    
    form_processor = Public.new
    form_processor.process_question(test_agreement.agreementid.to_i, '3', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r36", permissions.first.rule, "Wrong rule created"

    assert_match 'UNIT_TESTING_PUBLICATION', permissions.first.note, "Permission Note missing information"
  end

  # Test Q3 d)
  def test_q3_d
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q3_d] = 'checked'
    
    form_processor = Public.new
    form_processor.process_question(test_agreement.agreementid.to_i, '3', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r33", permissions.first.rule, "Wrong rule created"
  end

  # Test Q3 e)
  def test_q3_e
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q3_e] = 'checked'
    
    form_processor = Public.new
    form_processor.process_question(test_agreement.agreementid.to_i, '3', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r37", permissions.first.rule, "Wrong rule created"
  end

  # Test Q3 f)
  def test_q3_f
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q3_f] = 'checked'
    
    form_processor = Public.new
    form_processor.process_question(test_agreement.agreementid.to_i, '3', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r38", permissions.first.rule, "Wrong rule created"
  end
end

