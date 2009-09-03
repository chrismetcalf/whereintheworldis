# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_whereintheworldis_session',
  :secret      => '187f79d95315ee4994cc029d2ba06487fb57a5a9456988cd936973146685337d55081636b905bcb9cf91a1d69fd350f3c61e53f0f116eaaa4b0a736e4617baad'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
