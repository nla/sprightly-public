# Re-indexes the authority component of the rightsholder search
# Usage: rake RAILS_ENV="development" sprightly:reindex_authority_search

namespace :sprightly do
  desc "Re-index Voyager Authorities"

  task :reindex_authority_search => :environment do
    Util::AuthorityUtil.reindex_rightsholders_search
  end

end