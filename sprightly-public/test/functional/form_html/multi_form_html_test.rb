require 'test_helper'
require 'assert_xpath'

class WizardControllerTest < ActionController::TestCase
  include AssertXPath

  def test_multi_form_q17
    setup_session_for_editor
    test_agreement = create_test_agreement

    get :question, :id => test_agreement.agreementid, :qid=>"17", :ajax=>true

    assert_hidden_input("qid", "17")

    assert_radio_input("q17_a", "a")
    assert_radio_input("q17_b", "b")
  end

  def test_multi_form_q18
    setup_session_for_editor
    test_agreement = create_test_agreement

    get :question, :id => test_agreement.agreementid, :qid=>"18", :ajax=>true

    assert_hidden_input("qid", "18")
    assert_radio_input("q18_a", "a")
    assert_radio_input("q18_b", "b")
  end

  def test_multi_form_q19
    setup_session_for_editor
    test_agreement = create_test_agreement

    get :question, :id => test_agreement.agreementid, :qid=>"19", :ajax=>true

    assert_hidden_input("qid", "19")

    assert_radio_input("q19_a", "a")
    assert_textarea("q19_a_exceptions")
    assert_date_field("q19_a_eventdate")
    assert_textarea("q19_a_eventtext")

    assert_radio_input("q19_b", "b")
    assert_textarea("q19_b_inclusions")
    assert_date_field("q19_b_eventdate")
    assert_textarea("q19_b_eventtext")

    assert_radio_input("q19_c", "c")
    assert_date_field("q19_c_eventdate")
    assert_textarea("q19_c_eventtext")
  end

  def test_multi_form_q20
    setup_session_for_editor
    test_agreement = create_test_agreement

    get :question, :id => test_agreement.agreementid, :qid=>"20", :ajax=>true

    assert_hidden_input("qid", "20")
    
    assert_radio_input("q20_a", "a")

    assert_radio_input("q20_b", "b")
  end

def test_manuscripts_form_q21
    setup_session_for_editor
    test_agreement = create_test_agreement

    get :question, :id => test_agreement.agreementid, :qid=>"21", :ajax=>true

    assert_hidden_input("qid", "21")

    assert_radio_input("q21_a", "a")

    assert_radio_input("q21_b", "b")
    assert_textarea("q21_b_exceptions")
    assert_date_field("q21_b_eventdate")
    assert_textarea("q21_b_eventtext")

    assert_radio_input("q21_c", "c")
    assert_textarea("q21_c_inclusions")
    assert_date_field("q21_c_eventdate")
    assert_textarea("q21_c_eventtext")

    assert_radio_input("q21_d", "d")
    assert_date_field("q21_d_eventdate")
    assert_textarea("q21_d_eventtext")
  end

  def test_manuscripts_form_q22
    setup_session_for_editor
    test_agreement = create_test_agreement

    get :question, :id => test_agreement.agreementid, :qid=>"22", :ajax=>true

    assert_hidden_input("qid", "22")

    assert_radio_input("q22_a", "a")

    assert_radio_input("q22_b", "b")
    assert_textarea("q22_b_exceptions")
    assert_date_field("q22_b_eventdate")
    assert_textarea("q22_b_eventtext")

    assert_radio_input("q22_c", "c")
    assert_date_field("q22_c_eventdate")
    assert_textarea("q22_c_eventtext")

    assert_radio_input("q22_d", "d")
    assert_textarea("q22_d_inclusions")
    assert_date_field("q22_d_eventdate")
    assert_textarea("q22_d_eventtext")

    assert_radio_input("q22_e", "e")
  end

  def test_manuscripts_form_q23
    setup_session_for_editor
    test_agreement = create_test_agreement

    get :question, :id => test_agreement.agreementid, :qid=>"23", :ajax=>true

    assert_hidden_input("qid", "23")

    assert_radio_input("q23_a", "a")

    assert_radio_input("q23_b", "b")
    assert_textarea("q23_b_exceptions")
    assert_date_field("q23_b_eventdate")
    assert_textarea("q23_b_eventtext")

    assert_radio_input("q23_c", "c")
    assert_textarea("q23_c_inclusions")
    assert_date_field("q23_c_eventdate")
    assert_textarea("q23_c_eventtext")

    assert_radio_input("q23_d", "d")
    assert_date_field("q23_d_eventdate")
    assert_textarea("q23_d_eventtext")

    assert_radio_input("q23_e", "e")
    assert_checkbox("q23_e_a", "a")
    assert_checkbox("q23_e_b", "b")
    assert_checkbox("q23_e_c", "c")

    assert_radio_input("q23_f", "f")
  end

  def test_manuscripts_form_q24
    setup_session_for_editor
    test_agreement = create_test_agreement

    get :question, :id => test_agreement.agreementid, :qid=>"24", :ajax=>true

    assert_hidden_input("qid", "24")

    assert_radio_input("q24_a", "a")
    assert_textarea("q24_a_exceptions")
    assert_date_field("q24_a_eventdate")
    assert_textarea("q24_a_eventtext")

    assert_radio_input("q24_b", "b")
    assert_textarea("q24_b_inclusions")
    assert_date_field("q24_b_eventdate")
    assert_textarea("q24_b_eventtext")

    assert_radio_input("q24_c", "c")
    assert_date_field("q24_c_eventdate")
    assert_textarea("q24_c_eventtext")

    assert_radio_input("q24_d", "d")
  end

end
