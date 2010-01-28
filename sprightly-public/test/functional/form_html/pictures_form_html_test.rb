require 'test_helper'
require 'assert_xpath'

class WizardControllerTest < ActionController::TestCase
  include AssertXPath

  def test_pictures_form_q10
    setup_session_for_editor
    test_agreement = create_pictures_agreement

    get :question, :id => test_agreement.agreementid, :qid=>"10", :ajax=>true

    assert_hidden_input("qid", "10")
    assert_radio_input("q10_a", "a")
    assert_radio_input("q10_b", "b")
  end

  def test_pictures_form_q11
    setup_session_for_editor
    test_agreement = create_pictures_agreement

    get :question, :id => test_agreement.agreementid, :qid=>"11", :ajax=>true

    assert_hidden_input("qid", "11")

    assert_radio_input("q11_a", "a")

    assert_radio_input("q11_b", "b")
    assert_checkbox("q11_b_a", "a")
    assert_checkbox("q11_b_b", "b")
    assert_checkbox("q11_b_c", "c")

    assert_radio_input("q11_c", "c")
  end

   def test_pictures_form_q12
    setup_session_for_editor
    test_agreement = create_pictures_agreement

    get :question, :id => test_agreement.agreementid, :qid=>"12", :ajax=>true

    assert_hidden_input("qid", "12")
    assert_radio_input("q12_a", "a")
    assert_radio_input("q12_b", "b")
  end

end
