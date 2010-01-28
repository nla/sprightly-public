# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rms_session',
  :secret      => 'bb9a09628682001286c760673ad2c023be9ebf4aa669b975ebe8d29fe72aa93ffa586b2b8d86e500d912d420560adf3aa7f119a8fdfceb8ca95a727bb7d4a28f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
