# All reporting functions
#
# @author pgiles
#

class ReportController < ApplicationController
  before_filter :login_required,  :admin_access_required

  def agreement_reports
    @filter_applied = params[:filter] == "true"

    @filter_start_date = params[:filter_start_date]
    @filter_end_date = params[:filter_end_date]
    @filter_date_type = params[:filter_date_type]
    @filter_date_type = "createdate" if @filter_date_type.blank?

    @number_of_active_agreements = Agreement.number_of_active(@filter_date_type, @filter_start_date, @filter_end_date)
    @number_of_draft_agreements = Agreement.number_of_draft(@filter_date_type, @filter_start_date, @filter_end_date)
    @number_of_archived_agreements = Agreement.number_of_archived(@filter_date_type, @filter_start_date, @filter_end_date)
    @number_of_deleted_agreements = Agreement.number_of_deleted(@filter_date_type, @filter_start_date, @filter_end_date)

    @agreements_by_collection_and_status = Agreement.agreements_by_collection_and_status(@filter_date_type, @filter_start_date, @filter_end_date)
    @agreements_by_user_and_status = Agreement.agreements_by_user_and_status(@filter_date_type, @filter_start_date, @filter_end_date)
  end

end
