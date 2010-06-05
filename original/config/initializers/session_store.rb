# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_flingr_session',
  :secret      => '4ec4a4b51c1ce4bb3349c51c6ac98768b06bee1cad4baa8e023a8a856cd9a11b0d269d59a298c39ea42de937f0ac0652dbfb815a79c5f49d504f9b61a4b8ec55'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
