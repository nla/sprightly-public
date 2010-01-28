# Re-indexes the rightsholders that have been added to the
# RMS Database. These are rightsholdres within the party table.
# 
# Usage: rake RAILS_ENV="development" sprightly:reindex_party_search

namespace :sprightly do
  desc "Re-index rightsholders added to Sprightly"

  task :reindex_party_search => :environment do
    Util::RightsholderSearchUtil.reindex_rightsholders_search
  end

end