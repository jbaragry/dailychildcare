# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_daily_childcare_session',
  :secret      => '53201068044caaa672353fa537b777cbd2e328999d582d658cc179de17c0de2bc51ccaa18c0ef6f5fec2a81f653330b03790b71df4b585ad53b72230301c81d0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
