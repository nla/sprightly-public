require 'test_helper'

class CopyrightstatusTest < ActiveSupport::TestCase

  INVALID_BIBID = "1"
  VALID_BIBID = "12345"

  def test_for_invalid_bib_record_id
    copyrightstatus = Copyrightstatus.new
    copyrightstatus.determine(INVALID_BIBID)
    assert copyrightstatus.copyrightStatusReason == "There is no catalogue record", "Expecting a vaid message for an invalid bibid"
  end

  def test_successful_copyrightstatus_retrieval
    copyrightstatus = Copyrightstatus.new
    copyrightstatus.determine(VALID_BIBID)
    assert copyrightstatus.copyrightStatus == "Out of Copyright", "Unable to retrieve record. Either check code or COPYRIGHT service."
  end

end

