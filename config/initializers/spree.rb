# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes
# that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# Note: If a preference is set here it will be stored within the cache & database upon initialization.
#       Just removing an entry from this initializer will not make the preference value go away.
#       Instead you must either set a new value or remove entry, clear cache, and remove database entry.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|
  # Example:
  # Uncomment to stop tracking inventory levels in the application
  # config.track_inventory_levels = false

  config.admin_interface_logo = 'yoyakka_logo.png'
end

Spree.user_class = 'Spree::User'

Spree::Config[:layout] = 'spree_application'

Spree::PermittedAttributes.line_item_attributes.concat [:completion_date, :details]
Spree::PermittedAttributes.product_attributes.concat [:duration]
Spree::PermittedAttributes.user_attributes.concat [:wanted_to_become,:website,:company_description]

Rails.application.config.spree.payment_methods << Spree::Gateway::SQID

# It doen not say error message when user try to login and unconfirmed email
Spree::Auth::Config[:confirmable] = true
