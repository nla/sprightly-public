ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

class ActiveSupport::TestCase
  # Transactional fixtures accelerate your tests by wrapping each test method
  # in a transaction that's rolled back on completion.  This ensures that the
  # test database remains unchanged so your fixtures don't have to be reloaded
  # between every test method.  Fewer database queries means faster tests.
  #
  # Read Mike Clark's excellent walkthrough at
  #   http://clarkware.com/cgi/blosxom/2005/10/24#Rails10FastTesting
  #
  # Every Active Record database supports transactions except MyISAM tables
  # in MySQL.  Turn off transactional fixtures in this case; however, if you
  # don't care one way or the other, switching from MyISAM to InnoDB tables
  # is recommended.
  #
  # The only drawback to using transactional fixtures is when you actually 
  # need to test transactions.  Since your test is bracketed by a transaction,
  # any transactions started in your code will be automatically rolled back.
  self.use_transactional_fixtures = true

  # Instantiated fixtures are slow, but give you @david where otherwise you
  # would need people(:david).  If you don't want to migrate your existing
  # test cases which use the @david style and don't mind the speed hit (each
  # instantiated fixtures translates to a database query per test method),
  # then set this back to true.
  self.use_instantiated_fixtures  = false

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...

    def create_test_agreement(formtype = "multi")
      agreement = Agreement.new
      agreement.note = 'UNIT_ TESTING'
      agreement.formtype = formtype;
      agreement.audituser = 'UNIT_TESTING'
      agreement.auditdate = Date.today
      agreement.createdate = Date.today
      agreement.createuser = 'UNIT_TESTING'
      agreement.agreementdate = Date.today
      agreement.status_lu_id = StatusLu.draft
      agreement.save
      agreement
    end

    def create_manuscripts_agreement
      create_test_agreement("manuscripts")
    end

    def create_maps_agreement
      create_test_agreement("maps")
    end

    def create_oral_agreement
      create_test_agreement("oral")
    end

    def create_pictures_agreement
      create_test_agreement("pictures")
    end

    def create_public_agreement
      create_test_agreement("public")
    end

    def create_test_party
      party = Party.new
      party.corporatename = "UNIT_TESTING"
      party.audituser = 'UNIT_TESTING'
      party.auditdate = Date.today
      party.createdate = Date.today
      party.createuser = 'UNIT_TESTING'
      party.status_lu_id = StatusLu.active
      party.save
      party
    end

    def setup_session_for_editor
      session[:user] = User.new("unittest","unittest")
      session[:user].group = "rms:updater"
    end

    def format_date_for_display(date)

      if date.nil?
        return ""
      end

      year = date.to_s.slice(0..3)
      month = date.to_s.slice(5..6)
      day = date.to_s.slice(8..9)
      return day + "-" + month + "-" + year
    end


    #
    # XPATH Form Helper Methods
    #

    def assert_hidden_input(id, value)
      assert_tag_id '//input', id do | input |
        assert_equal value, input[:value]
        assert_equal "hidden", input[:type]
      end
    end

    def assert_text_input(id)
      assert_tag_id '//input', id do | input |
        assert_equal "text", input[:type]
      end
    end

    def assert_radio_input(id, value)
      assert_tag_id '//input', id do | input |
        assert_equal value, input[:value]
        assert_equal "radio", input[:type]
      end
    end

    def assert_textarea(id, value = nil)
       assert_tag_id '//textarea', id do | textarea |
        assert_equal value, textarea.text
      end
    end

    def assert_date_field(id)
      assert_tag_id '//input', id do | input |
        assert_match("datepicker", input[:class])
        assert_equal "text", input[:type]
      end
    end

    def assert_checkbox(id, value)
      assert_tag_id '//input', id do | input |
        assert_equal value, input[:value]
        assert_equal "checkbox", input[:type]
      end
    end

    def assert_dropdown_list(id)
      assert_tag_id '//select', id
    end
end
