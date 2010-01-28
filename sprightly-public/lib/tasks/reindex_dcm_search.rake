# Re-indexes the Internal images for the DCM Search.
# 
# Usage: rake RAILS_ENV="development" sprightly:reindex_dcm_search

namespace :sprightly do
  desc "Re-index Internal Images for DCM Search"

  task :reindex_dcm_search => :environment do
    Util::DcmSearchUtil.reindex_dcm_search
  end

end