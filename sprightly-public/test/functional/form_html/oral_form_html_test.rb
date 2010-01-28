require 'test_helper'
require 'assert_xpath'

class WizardControllerTest < ActionController::TestCase
  include AssertXPath

  def test_oral_form_q5
    setup_session_for_editor
    test_agreement = create_oral_agreement

    get :question, :id => test_agreement.agreementid, :qid=>"5", :ajax=>true

    assert_hidden_input("qid", "5")
    assert_radio_input("q5_a", "a")
    assert_radio_input("q5_b", "b")
  end

  def test_oral_form_q6
    setup_session_for_editor
    test_agreement = create_oral_agreement

    get :question, :id => test_agreement.agreementid, :qid=>"6", :ajax=>true

    assert_hidden_input("qid", "6")
    
    assert_radio_input("q6_a", "a")
    
    assert_radio_input("q6_b", "b")

    assert_radio_input("q6_c", "c")
    assert_date_field("q6_c_eventdate")
    assert_textarea("q6_c_eventtext")
  end

  def test_oral_form_q7
    setup_session_for_editor
    test_agreement = create_oral_agreement

    get :question, :id => test_agreement.agreementid, :qid=>"7", :ajax=>true

    assert_hidden_input("qid", "7")
    
    assert_radio_input("q7_a", "a")
    
    assert_radio_input("q7_b", "b")

    assert_radio_input("q7_c", "c")
    assert_date_field("q7_c_eventdate")
    assert_textarea("q7_c_eventtext")
  end

  def test_oral_form_q8
    setup_session_for_editor
    test_agreement = create_oral_agreement

    get :question, :id => test_agreement.agreementid, :qid=>"8", :ajax=>true

    assert_hidden_input("qid", "8")

    assert_radio_input("q8_a", "a")

    assert_radio_input("q8_b", "b")
    assert_date_field("q8_b_eventdate")
    assert_textarea("q8_b_eventtext")
  end

  def test_oral_form_q9
    setup_session_for_editor
    test_agreement = create_oral_agreement

    get :question, :id => test_agreement.agreementid, :qid=>"9", :ajax=>true

    assert_hidden_input("qid", "9")

    assert_radio_input("q9_a", "a")

    assert_radio_input("q9_b", "b")

    assert_radio_input("q9_c", "c")
    assert_date_field("q9_c_eventdate")
    assert_textarea("q9_c_eventtext")
  end

end
