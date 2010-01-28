# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.2' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|

  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  #config.gem "activerecord-oracle_enhanced-adapter" # Commented out as this throws an error on startup. But still works !?!
  config.gem "markaby"
  config.gem "marc"
  #config.gem "assert2"
  #config.gem "assert_xpath"

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]
  config.frameworks -= [ :action_mailer ]
  
  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'Canberra'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de

  # Interface Defaults
  SEARCH_RESULT_MAX_PAGE_DISPLAY = 20

  SPRIGHTLY_BLOG_RSS='http://blogs.nla.gov.au/labs/feed'
  SPRIGHTLY_BLOG_HTML='http://blogs.nla.gov.au/labs'
  SPRIGHTLY_WIKI='http://code.nla.gov.au/redmine/wiki/rms-go'

  NLA_CATALOGUE_RECORD_URL='http://catalogue.nla.gov.au/Record/'

  SPRIGHTLY_VERSION = "Version 2.0"

  SPRIGHTLY_GLOSSARY = YAML::load(File.open("#{RAILS_ROOT}/config/glossary.yml"))

end
