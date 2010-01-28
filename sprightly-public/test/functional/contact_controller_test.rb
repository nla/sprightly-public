require 'test_helper'
require 'assert_xpath'

class ContactControllerTest < ActionController::TestCase
  include AssertXPath

  def test_compiled_form_addr1
    setup_session_for_editor

    test_party = create_test_party

    get :new_compiled, :partyid => test_party.partyid, :ajax=>true

    assert_hidden_input("address1_contact_contacttype_lu_id", ContacttypeLu.postal.to_s)
    assert_checkbox("address1_contact_preferred", "Y")
    assert_dropdown_list("address1_contact_privacy_lu_id")
    assert_text_input("address1_data_addressee")
    assert_text_input("address1_data_line1")
    assert_text_input("address1_data_line2")
    assert_text_input("address1_data_line3")
    assert_text_input("address1_data_suburb")
    assert_dropdown_list("address1_data_state")
    assert_text_input("address1_data_postcode")
  end

  def test_compiled_form_addr2
    setup_session_for_editor

    test_party = create_test_party

    get :new_compiled, :partyid => test_party.partyid, :ajax=>true

    assert_hidden_input("address2_contact_contacttype_lu_id", ContacttypeLu.postal.to_s)
    assert_checkbox("address2_contact_preferred", "Y")
    assert_dropdown_list("address2_contact_privacy_lu_id")
    assert_text_input("address2_data_addressee")
    assert_text_input("address2_data_line1")
    assert_text_input("address2_data_line2")
    assert_text_input("address2_data_line3")
    assert_text_input("address2_data_suburb")
    assert_dropdown_list("address2_data_state")
    assert_text_input("address2_data_postcode")
  end

  def test_compiled_form_bh_phone
    setup_session_for_editor

    test_party = create_test_party

    get :new_compiled, :partyid => test_party.partyid, :ajax=>true

    assert_hidden_input("bh_phone_contact_contacttype_lu_id", ContacttypeLu.bh_phone.to_s)
    assert_checkbox("bh_phone_contact_preferred", "Y")
    assert_dropdown_list("bh_phone_contact_privacy_lu_id")
    assert_text_input("bh_phone_data_bh_phone")
  end

  def test_compiled_form_ah_phone
    setup_session_for_editor

    test_party = create_test_party

    get :new_compiled, :partyid => test_party.partyid, :ajax=>true

    assert_hidden_input("ah_phone_contact_contacttype_lu_id", ContacttypeLu.ah_phone.to_s)
    assert_checkbox("ah_phone_contact_preferred", "Y")
    assert_dropdown_list("ah_phone_contact_privacy_lu_id")
    assert_text_input("ah_phone_data_ah_phone")
  end

  def test_compiled_form_mobile
    setup_session_for_editor

    test_party = create_test_party

    get :new_compiled, :partyid => test_party.partyid, :ajax=>true

    assert_hidden_input("mobile_phone_contact_contacttype_lu_id", ContacttypeLu.mobile.to_s)
    assert_checkbox("mobile_phone_contact_preferred", "Y")
    assert_dropdown_list("mobile_phone_contact_privacy_lu_id")
    assert_text_input("mobile_phone_data_mobile")
  end

  def test_compiled_form_fax
    setup_session_for_editor

    test_party = create_test_party

    get :new_compiled, :partyid => test_party.partyid, :ajax=>true

    assert_hidden_input("fax_contact_contacttype_lu_id", ContacttypeLu.fax.to_s)
    assert_checkbox("fax_contact_preferred", "Y")
    assert_dropdown_list("fax_contact_privacy_lu_id")
    assert_text_input("fax_data_fax")
  end

  def test_compiled_form_email
    setup_session_for_editor

    test_party = create_test_party

    get :new_compiled, :partyid => test_party.partyid, :ajax=>true

    assert_hidden_input("email_contact_contacttype_lu_id", ContacttypeLu.email.to_s)
    assert_checkbox("email_contact_preferred", "Y")
    assert_dropdown_list("email_contact_privacy_lu_id")
    assert_text_input("email_data_email")
  end

end
