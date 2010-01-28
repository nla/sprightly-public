# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_view.debug_rjs                         = true
config.action_controller.perform_caching             = false

# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false

#config.action_controller.relative_url_root = "/rms"

AUTHORITY_FILE_LOCATION = '' # Path to .mrc authority file dump

# Service specific information

# Publicly Available Services
SERVICE_CATALOG_SEARCH = 'http://catalogue.nla.gov.au/Search/Home?view=raw'
SERVICE_NLATHUMB='http://catalogue.nla.gov.au/fcgi-bin/nlathumb.fcgi?mode=thumb&id='
SERVICE_COPYRIGHTSTATUS = 'http://api.nla.gov.au/v1/copyrightstatus'
# https://wiki.nla.gov.au/display/LABS/Copyright+status+service
# http://www-test.nla.gov.au/copyright_status


# Internal Services that have a temporary project
# called sprightly-services
SERVICE_COLLECTION = 'http://localhost:9191/collection?pi=' # Returns MarcXml based on biblographic id's

SERVICE_DCM_SEARCH = 'http://localhost:9191/dcm/select'
SERVICE_DCM_SEARCH_UPDATE = '' # Solr Update URL for dcm search

SERVICE_RIGHTSHOLDER_SEARCH = 'http://localhost:9191/rightsholders/select' # Solr righsholders index
SERVICE_RIGHTSHOLDER_SEARCH_UPDATE = '' # Solr Update URL for rightsholders search

SERVICE_TRIM='http://localhost:9191/trim?id=' # Links to original source documents that have been scanned

SERVICE_VOYAGERDB='http://localhost:9191/voyagerdb/' # Returns a list of bibid's and  list of authority id's
SERVICE_DCMDB='' # Disabled Specific to NLA Digital Collection Manager
SERVICE_UMS='' # replaced by hard-coded users in the model/user.rb