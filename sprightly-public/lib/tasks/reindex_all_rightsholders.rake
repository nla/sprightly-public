# Re-indexes the sprightly-search/rightsholders index.
# This includes both the Voyager Authority file and the rightsholders that
# have been added to the rms database.
#
# Usage: rake RAILS_ENV="development" sprightly:reindex_all_rightsholders

namespace :sprightly do
  desc "Re-index All the rightsholders"

  task :reindex_all_rightsholders => :environment do
    puts "Rightsholders that have been added to Sprightly"
    Util::RightsholderSearchUtil.reindex_rightsholders_search

    puts "Voyager Authority File"
    Util::AuthorityUtil.reindex_rightsholders_search
  end

end