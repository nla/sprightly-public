require 'test_helper'
require "forms/form"
require "forms/pictures"

class PicturesFormTest < ActiveSupport::TestCase
  
 
  ###########################################
  # Q11
  #
  # Test Q11 a)
  def test_q11_a
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q11] = 'a'
    
    form_processor = Pictures.new
    form_processor.process_question(test_agreement.agreementid.to_i, '11', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r27", permissions.first.rule, "Wrong rule created"
  end

  # Test Q11 b) -> a
  def test_q11_b_a
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q11] = 'b'
    params[:q11_b_a] = "true"

    form_processor = Maps.new
    form_processor.process_question(test_agreement.agreementid.to_i, '11', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 3, permissions.length, "Number of permissions created is incorrect"
    assert_equal 3, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal 1, permissions.select{|p| p.rule=="r31"}.length, "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r50"}.length, "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r51"}.length, "Incorrect rule created"
  end

  # Test Q11 b) -> b
  def test_q11_b_b
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q11] = 'b'
    params[:q11_b_b] = "true"

    form_processor = Maps.new
    form_processor.process_question(test_agreement.agreementid.to_i, '11', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 3, permissions.length, "Number of permissions created is incorrect"
    assert_equal 3, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal 1, permissions.select{|p| p.rule=="r32"}.length, "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r49"}.length, "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r51"}.length, "Incorrect rule created"
  end

  # Test Q11 b) -> c
  def test_q11_b_c
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q11] = 'b'
    params[:q11_b_c] = "true"

    form_processor = Maps.new
    form_processor.process_question(test_agreement.agreementid.to_i, '11', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 3, permissions.length, "Number of permissions created is incorrect"
    assert_equal 3, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal 1, permissions.select{|p| p.rule=="r33"}.length, "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r49"}.length, "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r50"}.length, "Incorrect rule created"
  end

  # Test Q11 b) all
  def test_q11_b_all
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q11] = 'b'
    params[:q11_b_a] = "true"
    params[:q11_b_b] = "true"
    params[:q11_b_c] = "true"

    form_processor = Maps.new
    form_processor.process_question(test_agreement.agreementid.to_i, '11', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 3, permissions.length, "Incorrect number of permissions created"
    assert_equal 3, form_processor.permission_count, "Incorrect count of permissions on form processor"

    #Check Permissions match rules
    assert_equal 1, permissions.select{|p| p.rule=="r31"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r32"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r33"}.length,  "Incorrect rule created"
  end

  # Test Q11 b) none
  def test_q11_b_none
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q11] = 'b'

    form_processor = Maps.new
    form_processor.process_question(test_agreement.agreementid.to_i, '11', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 3, permissions.length, "Incorrect number of permissions created"
    assert_equal 3, form_processor.permission_count, "Incorrect count of permissions on form processor"

    #Check Permissions match rules
    assert_equal 1, permissions.select{|p| p.rule=="r49"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r50"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r51"}.length,  "Incorrect rule created"
  end

  # Test Q11 b) -> a b
  def test_q11_b_ab
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q11] = 'b'
    params[:q11_b_a] = "true"
    params[:q11_b_b] = "true"

    form_processor = Maps.new
    form_processor.process_question(test_agreement.agreementid.to_i, '11', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 3, permissions.length, "Incorrect number of permissions created"
    assert_equal 3, form_processor.permission_count, "Incorrect count of permissions on form processor"

    #Check Permissions match rules
    assert_equal 1, permissions.select{|p| p.rule=="r31"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r32"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r51"}.length,  "Incorrect rule created"
  end

  # Test Q11 b) -> a c
  def test_q11_b_ac
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q11] = 'b'
    params[:q11_b_a] = "true"
    params[:q11_b_c] = "true"

    form_processor = Maps.new
    form_processor.process_question(test_agreement.agreementid.to_i, '11', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 3, permissions.length, "Incorrect number of permissions created"
    assert_equal 3, form_processor.permission_count, "Incorrect count of permissions on form processor"

    #Check Permissions match rules
    assert_equal 1, permissions.select{|p| p.rule=="r31"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r33"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r50"}.length,  "Incorrect rule created"
  end

  # Test Q11 b) -> b c
  def test_q11_b_bc
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
    params[:q11] = 'b'
    params[:q11_b_b] = "true"
    params[:q11_b_c] = "true"

    form_processor = Maps.new
    form_processor.process_question(test_agreement.agreementid.to_i, '11', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 3, permissions.length, "Incorrect number of permissions created"
    assert_equal 3, form_processor.permission_count, "Incorrect count of permissions on form processor"

    #Check Permissions match rules
    assert_equal 1, permissions.select{|p| p.rule=="r32"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r33"}.length,  "Incorrect rule created"
    assert_equal 1, permissions.select{|p| p.rule=="r49"}.length,  "Incorrect rule created"
  end

  def test_q11_c
    test_agreement = create_test_agreement
    params = HashWithIndifferentAccess.new
      params[:q11] = 'c'
    
    form_processor = Pictures.new
    form_processor.process_question(test_agreement.agreementid.to_i, '11', params, 'UNIT_TESTING')

    permissions = test_agreement.active_permissions

    # Check Permissions created
    assert_equal 1, permissions.length, "Number of permissions created is incorrect"
    assert_equal 1, form_processor.permission_count, "Permission count on processor is incorrect"

    #Check Permissions match rules
    assert_equal "r39", permissions.first.rule, "Wrong rule created"

  end


end

