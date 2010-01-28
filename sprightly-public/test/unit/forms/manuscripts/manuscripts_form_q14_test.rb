require 'test_helper'
require "forms/form"
require "forms/manuscripts"

class ManuscriptsFormTest < ActiveSupport::TestCase
  
  ###########################################
  # Q14
  #
  # Test Q14 a)
  def test_q14_a
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q14] = 'a'
    
    form_processor = Manuscripts.new
    form_processor.process_question(test_agreement.agreementid.to_i, '14', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r27", permissions.first.rule, "Wrong rule created"
  end

  # Test Q14 b)
  def test_q14_b
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q14] = 'b'
    params[:q14_b_exceptions] = 'UNIT_TESTING_EXCEPTION'
    params[:q14_b_eventdate] = '12-08-2009'
    params[:q14_b_eventtext] = 'UNIT_TESTING_EVENT_TEXT'
    
    form_processor = Manuscripts.new
    form_processor.process_question(test_agreement.agreementid.to_i, '14', params, 'UNIT_TESTING')

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

  # Test Q14 c
  def test_q14_c
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q14] = 'c'
    params[:q14_c_eventdate] = '12-08-2009'
    params[:q14_c_eventtext] = 'UNIT_TESTING_EVENT_TEXT'
    
    form_processor = Manuscripts.new
    form_processor.process_question(test_agreement.agreementid.to_i, '14', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    #Check Permissions match rules
    assert_equal "r30", permissions.first.rule, "Wrong rule created"

    assert_equal '12-08-2009', format_date_for_display(permissions.first.triggerdate), "Incorrect trigger date"
    assert_equal 'UNIT_TESTING_EVENT_TEXT', permissions.first.event, "Incorrect event text"
    assert_equal 'Until', permissions.first.eventoperator, 'Incorrect event operator'
  end

  # Test Q14 d) -> a
  def test_q14_d_a
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q14] = 'd'
    params[:q14_d_a] = "true"
    
    form_processor = Manuscripts.new
    form_processor.process_question(test_agreement.agreementid.to_i, '14', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 3, permissions.length, "Number of permissions created is incorrect"
    assert_equal 3, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules    
    assert_equal 1, permissions.select{|p| p.rule=="r31"}.length, "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r50"}.length, "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r51"}.length, "Incorrect rule created"
  end

  # Test Q14 d) -> b
  def test_q14_d_b
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q14] = 'd'
    params[:q14_d_b] = "true"
    
    form_processor = Manuscripts.new
    form_processor.process_question(test_agreement.agreementid.to_i, '14', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 3, permissions.length, "Number of permissions created is incorrect"
    assert_equal 3, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal 1, permissions.select{|p| p.rule=="r32"}.length, "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r49"}.length, "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r51"}.length, "Incorrect rule created"
  end

  # Test Q14 d) -> c
  def test_q14_d_c
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q14] = 'd'
    params[:q14_d_c] = "true"
    
    form_processor = Manuscripts.new
    form_processor.process_question(test_agreement.agreementid.to_i, '14', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 3, permissions.length, "Number of permissions created is incorrect"
    assert_equal 3, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal 1, permissions.select{|p| p.rule=="r33"}.length, "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r49"}.length, "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r50"}.length, "Incorrect rule created"
  end

  # Test Q14 d) all
  def test_q14_d_all
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q14] = 'd'
    params[:q14_d_a] = "true"
    params[:q14_d_b] = "true"
    params[:q14_d_c] = "true"

    form_processor = Manuscripts.new
    form_processor.process_question(test_agreement.agreementid.to_i, '14', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 3, permissions.length, "Incorrect number of permissions created"
    assert_equal 3, form_processor.permission_count, "Incorrect count of permissions on form processor"

    #Check Permissions match rules
    assert_equal 1, permissions.select{|p| p.rule=="r31"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r32"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r33"}.length,  "Incorrect rule created"
  end

  # Test Q14 d) none
  def test_q14_d_none
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q14] = 'd'

    form_processor = Manuscripts.new
    form_processor.process_question(test_agreement.agreementid.to_i, '14', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 3, permissions.length, "Incorrect number of permissions created"
    assert_equal 3, form_processor.permission_count, "Incorrect count of permissions on form processor"

    #Check Permissions match rules
    assert_equal 1, permissions.select{|p| p.rule=="r49"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r50"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r51"}.length,  "Incorrect rule created"
  end

  # Test Q14 d) -> a b
  def test_q14_d_ab
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q14] = 'd'
    params[:q14_d_a] = "true"
    params[:q14_d_b] = "true"

    form_processor = Manuscripts.new
    form_processor.process_question(test_agreement.agreementid.to_i, '14', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 3, permissions.length, "Incorrect number of permissions created"
    assert_equal 3, form_processor.permission_count, "Incorrect count of permissions on form processor"

    #Check Permissions match rules
    assert_equal 1, permissions.select{|p| p.rule=="r31"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r32"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r51"}.length,  "Incorrect rule created"
  end

  # Test Q14 d) -> a c
  def test_q14_d_ac
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q14] = 'd'
    params[:q14_d_a] = "true"
    params[:q14_d_c] = "true"

    form_processor = Manuscripts.new
    form_processor.process_question(test_agreement.agreementid.to_i, '14', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 3, permissions.length, "Incorrect number of permissions created"
    assert_equal 3, form_processor.permission_count, "Incorrect count of permissions on form processor"

    #Check Permissions match rules
    assert_equal 1, permissions.select{|p| p.rule=="r31"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r33"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r50"}.length,  "Incorrect rule created"
  end

  # Test Q14 d) -> b c
  def test_q14_d_bc
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q14] = 'd'
    params[:q14_d_b] = "true"
    params[:q14_d_c] = "true"

    form_processor = Manuscripts.new
    form_processor.process_question(test_agreement.agreementid.to_i, '14', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 3, permissions.length, "Incorrect number of permissions created"
    assert_equal 3, form_processor.permission_count, "Incorrect count of permissions on form processor"

    #Check Permissions match rules
    assert_equal 1, permissions.select{|p| p.rule=="r32"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r33"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r49"}.length,  "Incorrect rule created"
  end

  def test_q14_e
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q14] = 'e'
    
    form_processor = Manuscripts.new
    form_processor.process_question(test_agreement.agreementid.to_i, '14', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r39", permissions.first.rule, "Wrong rule created"
  end

end

