require 'test_helper'
require 'assert_xpath'

class WizardControllerTest < ActionController::TestCase
  include AssertXPath

  def test_pictures_form_q3
    setup_session_for_editor
    test_agreement = create_public_agreement

    get :question, :id => test_agreement.agreementid, :qid=>"3", :ajax=>true

    assert_hidden_input("qid", "3")

    assert_checkbox("q3_a", "a")
    assert_text_input("q3_a_inclusions")
    assert_checkbox("q3_b", "b")
    assert_text_input("q3_b_inclusions")
    assert_checkbox("q3_c", "c")
    assert_text_input("q3_c_inclusions")
    assert_checkbox("q3_d", "d")
    assert_checkbox("q3_e", "e")

  end
end
