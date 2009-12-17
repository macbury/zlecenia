# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
#ActionController::Base.session = {
#  :key         => '_zlecenia_session',
#  :secret      => 'e8436e79916da430665fa5a858d4deba425e4b363597ceaed0bfe5249652a03ce04f40edaa4df162670b3b97ea70511e4c5a2a865bcd05f17e08a3c32290f32f'
#}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store
