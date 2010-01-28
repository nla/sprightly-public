require 'test_helper'
require 'assert_xpath'

class WizardControllerTest < ActionController::TestCase
  include AssertXPath

  def test_manuscripts_form_q8
    setup_session_for_editor
    test_agreement = create_manuscripts_agreement

    get :question, :id => test_agreement.agreementid, :qid=>"8", :ajax=>true

    assert_hidden_input("qid", "8")
    assert_radio_input("q8_a", "a")
    assert_radio_input("q8_b", "b")
  end

  def test_manuscripts_form_q9
    setup_session_for_editor
    test_agreement = create_manuscripts_agreement

    get :question, :id => test_agreement.agreementid, :qid=>"9", :ajax=>true

    assert_hidden_input("qid", "9")
    assert_radio_input("q9_a", "a")
    assert_radio_input("q9_b", "b")
  end

  def test_manuscripts_form_q10
    setup_session_for_editor
    test_agreement = create_manuscripts_agreement

    get :question, :id => test_agreement.agreementid, :qid=>"10", :ajax=>true

    assert_hidden_input("qid", "10")
    assert_radio_input("q10_a", "a")
    
    assert_radio_input("q10_b", "b")
    assert_textarea("q10_b_exceptions")
    assert_date_field("q10_b_eventdate")
    assert_textarea("q10_b_eventtext")

    assert_radio_input("q10_c", "c")
    assert_date_field("q10_c_eventdate")
    assert_textarea("q10_c_eventtext")

    assert_radio_input("q10_d", "d")
    assert_date_field("q10_d_eventdate")
    assert_textarea("q10_d_eventtext")
  end

  def test_manuscripts_form_q12
    setup_session_for_editor
    test_agreement = create_manuscripts_agreement

    get :question, :id => test_agreement.agreementid, :qid=>"12", :ajax=>true

    assert_hidden_input("qid", "12")
    
    assert_radio_input("q12_a", "a")
    
    assert_radio_input("q12_b", "b")
    assert_textarea("q12_b_exceptions")
    assert_date_field("q12_b_eventdate")
    assert_textarea("q12_b_eventtext")

    assert_radio_input("q12_c", "c")
    assert_date_field("q12_c_eventdate")
    assert_textarea("q12_c_eventtext")  
  end

  def test_manuscripts_form_q13
    setup_session_for_editor
    test_agreement = create_manuscripts_agreement

    get :question, :id => test_agreement.agreementid, :qid=>"13", :ajax=>true

    assert_hidden_input("qid", "13")

    assert_radio_input("q13_a", "a")

    assert_radio_input("q13_b", "b")
    assert_textarea("q13_b_exceptions")
    assert_date_field("q13_b_eventdate")
    assert_textarea("q13_b_eventtext")

    assert_radio_input("q13_c", "c")
    assert_date_field("q13_c_eventdate")
    assert_textarea("q13_c_eventtext")

    assert_radio_input("q13_d", "d")
  end

  def test_manuscripts_form_q14
    setup_session_for_editor
    test_agreement = create_manuscripts_agreement

    get :question, :id => test_agreement.agreementid, :qid=>"14", :ajax=>true

    assert_hidden_input("qid", "14")

    assert_radio_input("q14_a", "a")

    assert_radio_input("q14_b", "b")
    assert_textarea("q14_b_exceptions")
    assert_date_field("q14_b_eventdate")
    assert_textarea("q14_b_eventtext")

    assert_radio_input("q14_c", "c")
    assert_date_field("q14_c_eventdate")
    assert_textarea("q14_c_eventtext")

    assert_radio_input("q14_d", "d")
    assert_checkbox("q14_d_a", "a")
    assert_checkbox("q14_d_b", "b")
    assert_checkbox("q14_d_c", "c")

    assert_radio_input("q14_e", "e")
  end

  def test_manuscripts_form_q15
    setup_session_for_editor
    test_agreement = create_manuscripts_agreement

    get :question, :id => test_agreement.agreementid, :qid=>"15", :ajax=>true

    assert_hidden_input("qid", "15")

    assert_radio_input("q15_a", "a")
    assert_textarea("q15_a_exceptions")
    assert_date_field("q15_a_eventdate")
    assert_textarea("q15_a_eventtext")

    assert_radio_input("q15_b", "b")
    assert_date_field("q15_b_eventdate")
    assert_textarea("q15_b_eventtext")
  end

   def test_manuscripts_form_q16
    setup_session_for_editor
    test_agreement = create_manuscripts_agreement

    get :question, :id => test_agreement.agreementid, :qid=>"16", :ajax=>true

    assert_hidden_input("qid", "16")
    assert_radio_input("q16_a", "a")
    assert_radio_input("q16_b", "b")
  end

end
