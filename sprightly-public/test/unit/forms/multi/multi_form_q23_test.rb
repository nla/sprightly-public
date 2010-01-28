require 'test_helper'
require "forms/form"
require "forms/multi"

class MultiFormTest < ActiveSupport::TestCase

  ###########################################
  # Q23
  #
  # Test Q23 a)
  def test_q23_a
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q23] = 'a'
    
    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '23', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r27", permissions.first.rule, "Wrong rule created"
  end

  # Test Q23 b)
  def test_q23_b
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q23] = 'b'
      params[:q23_b_exceptions] = 'UNIT_TESTING_EXCEPTION'
      params[:q23_b_eventdate] = '12-08-2009'
      params[:q23_b_eventtext] = 'UNIT_TESTING_EVENT_TEXT'
    
    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '23', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r28", permissions.first.rule, "Wrong rule created"

    assert_match 'UNIT_TESTING_EXCEPTION', permissions.first.note, "Permission Note missing information"
    assert_equal '12-08-2009', format_date_for_display(permissions.first.triggerdate), "Incorrect trigger date"
    assert_equal 'UNIT_TESTING_EVENT_TEXT', permissions.first.event, "Incorrect event text"
    assert_equal 'Until', permissions.first.eventoperator, 'Incorrect event operator'
  end

  # Test Q23 c)
  def test_q23_c
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q23] = 'c'
      params[:q23_c_inclusions] = 'UNIT_TESTING_INCLUSION'
      params[:q23_c_eventdate] = '12-08-2009'
      params[:q23_c_eventtext] = 'UNIT_TESTING_EVENT_TEXT'
    
    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '23', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r29", permissions.first.rule, "Wrong rule created"

    assert_match 'UNIT_TESTING_INCLUSION', permissions.first.note, "Permission Note missing information"
    assert_equal '12-08-2009', format_date_for_display(permissions.first.triggerdate), "Incorrect trigger date"
    assert_equal 'UNIT_TESTING_EVENT_TEXT', permissions.first.event, "Incorrect event text"
    assert_equal 'Until', permissions.first.eventoperator, 'Incorrect event operator'
  end

  # Test Q23 d)
  def test_q23_d
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q23] = 'd'
      params[:q23_d_eventdate] = '12-08-2009'
      params[:q23_d_eventtext] = 'UNIT_TESTING_EVENT_TEXT'
    
    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '23', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r30", permissions.first.rule, "Wrong rule created"

    assert_equal '12-08-2009', format_date_for_display(permissions.first.triggerdate), "Incorrect trigger date"
    assert_equal 'UNIT_TESTING_EVENT_TEXT', permissions.first.event, "Incorrect event text"
    assert_equal 'Until', permissions.first.eventoperator, 'Incorrect event operator'
  end

    # Test Q23 e) -> a
  def test_q23_e_a
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q23] = 'e'
    params[:q23_e_a] = "true"
    
    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '23', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 3, permissions.length, "Number of permissions created is incorrect"
    assert_equal 3, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules    
    assert_equal 1, permissions.select{|p| p.rule=="r31"}.length, "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r50"}.length, "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r51"}.length, "Incorrect rule created"
  end

  # Test Q23 e) -> b
  def test_q23_e_b
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q23] = 'e'
    params[:q23_e_b] = "true"
    
    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '23', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 3, permissions.length, "Number of permissions created is incorrect"
    assert_equal 3, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal 1, permissions.select{|p| p.rule=="r32"}.length, "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r49"}.length, "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r51"}.length, "Incorrect rule created"
  end

  # Test Q23 e) -> c
  def test_q23_e_c
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q23] = 'e'
    params[:q23_e_c] = "true"
    
    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '23', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 3, permissions.length, "Number of permissions created is incorrect"
    assert_equal 3, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal 1, permissions.select{|p| p.rule=="r33"}.length, "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r49"}.length, "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r50"}.length, "Incorrect rule created"
  end

  # Test q23 e) all
  def test_q23_e_all
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q23] = 'e'
    params[:q23_e_a] = "true"
    params[:q23_e_b] = "true"
    params[:q23_e_c] = "true"

    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '23', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 3, permissions.length, "Incorrect number of permissions created"
    assert_equal 3, form_processor.permission_count, "Incorrect count of permissions on form processor"

    #Check Permissions match rules
    assert_equal 1, permissions.select{|p| p.rule=="r31"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r32"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r33"}.length,  "Incorrect rule created"
  end

  # Test q23 e) none
  def test_q23_e_none
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q23] = 'e'

    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '23', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 3, permissions.length, "Incorrect number of permissions created"
    assert_equal 3, form_processor.permission_count, "Incorrect count of permissions on form processor"

    #Check Permissions match rules
    assert_equal 1, permissions.select{|p| p.rule=="r49"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r50"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r51"}.length,  "Incorrect rule created"
  end

  # Test Q23 e) -> a b
  def test_q23_e_ab
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q23] = 'e'
    params[:q23_e_a] = "true"
    params[:q23_e_b] = "true"

    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '23', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 3, permissions.length, "Incorrect number of permissions created"
    assert_equal 3, form_processor.permission_count, "Incorrect count of permissions on form processor"

    #Check Permissions match rules
    assert_equal 1, permissions.select{|p| p.rule=="r31"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r32"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r51"}.length,  "Incorrect rule created"
  end

  # Test q23 e) -> a c
  def test_q23_e_ac
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q23] = 'e'
    params[:q23_e_a] = "true"
    params[:q23_e_c] = "true"

    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '23', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 3, permissions.length, "Incorrect number of permissions created"
    assert_equal 3, form_processor.permission_count, "Incorrect count of permissions on form processor"

    #Check Permissions match rules
    assert_equal 1, permissions.select{|p| p.rule=="r31"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r33"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r50"}.length,  "Incorrect rule created"
  end

  # Test Q23 e) -> b c
  def test_q23_e_bc
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q23] = 'e'
    params[:q23_e_b] = "true"
    params[:q23_e_c] = "true"

    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '23', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 3, permissions.length, "Incorrect number of permissions created"
    assert_equal 3, form_processor.permission_count, "Incorrect count of permissions on form processor"

    #Check Permissions match rules
    assert_equal 1, permissions.select{|p| p.rule=="r32"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r33"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r49"}.length,  "Incorrect rule created"
  end


  # Test Q23 f)
  def test_q23_f
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q23] = 'f'
    
    form_processor = Multi.new
    form_processor.process_question(test_agreement.agreementid.to_i, '23', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r39", permissions.first.rule, "Wrong rule created"
  end

end

