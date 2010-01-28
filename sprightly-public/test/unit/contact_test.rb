require 'test_helper'

class ContactTest < ActiveSupport::TestCase

  def test_for_valid_states
    assert Contact.states.size == 8, "Expecting 8 states"

    Contact.states.each do |state|
      assert valid_state?(state[1]), state[1] + " is not a valid state."
    end

  end

  private

  def valid_state?(short)
    return true if short == "ACT" or short == "VIC" or short == "SA" or short == "WA" or short == "NT" or short == "NSW" or short == "QLD" or short == "TAS"
    false
  end


end

