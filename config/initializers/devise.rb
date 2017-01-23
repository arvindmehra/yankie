Devise.secret_key = YoYakka::Application.config.secret_key_base

Rails.application.config.to_prepare do
  Spree::UserSessionsController.layout 'devise'
  Spree::UserRegistrationsController.layout 'devise'
  Spree::UserPasswordsController.layout 'devise'
end

Devise.setup do |config|
  # config.mailer_sender = 'vendochichihuas@hotmail.com'

  # config.mailer = 'Devise::Mailer'

  # require 'devise/orm/active_record'

  config.reconfirmable = true
  # config.confirmable   = true

  # Required so users don't lose their carts when they need to confirm.
  # config.allow_unconfirmed_access_for = 1.days

  # Fixes the bug where Confirmation errors result in a broken page.
  # config.router_name = :spree

  # Add any other devise configurations here, as they will override the defaults provided by spree_auth_devise.
end
