# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_sprightly-services_session',
  :secret      => '7b234ee3da274b7c4a8bf490dab992ff138a80e3ea03690b605270c0337ea513bbf7a0c875dda97d2dd791b17a178959f135fea56210d55b1a3a18667eb08805'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
