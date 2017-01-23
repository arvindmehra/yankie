class ChangeDefaultStoreSettings < ActiveRecord::Migration
  def up
    preference_store = Spree::Preferences::Store.instance

    preference_store.delete 'spree/app_configuration/site_name'
    preference_store.delete 'spree/app_configuration/site_url'
    preference_store.delete 'spree/app_configuration/mails_from'
    preference_store.delete 'spree/app_configuration/currency'

    if store = Spree::Store.where(default: true).first
      # we set defaults for the things we now require
      store.name              = preference_store.get 'spree/app_configuration/site_name' do
        'yoyakka'
      end
      store.url               = preference_store.get 'spree/app_configuration/site_url' do
        'yoyakka.com'
      end
      store.mail_from_address = preference_store.get 'spree/app_configuration/mails_from' do
        'support@yoyakka.com'
      end
      store.default_currency  = Spree::Preferences::Store.instance.get 'spree/app_configuration/currency' do
        'AUD'
      end

      store.code              = 'yoyakka'

      store.save!
    end
  end

  def donw
  end
end
