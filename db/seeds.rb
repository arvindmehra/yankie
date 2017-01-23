# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ActiveRecord::Base.transaction do
  if Spree::User.count.zero?
    Spree::Core::Engine.load_seed if defined?(Spree::Core)
    Spree::Auth::Engine.load_seed if defined?(Spree::Auth)
  end

  # custom seed

  service_provider_role = Spree::Role.find_or_create_by! name: 'service_provider'
  pro_service_provider_role = Spree::Role.find_or_create_by! name: 'pro_service_provider'

  user = Spree::User.find_or_create_by! email: 'service_provider@example.com' do |user|
    user.password = '123123123'
  end
  user.role_users.create!(role: service_provider_role, want_to_become_pro: true) if user.role_users.blank?

  user = Spree::User.find_or_create_by! email: 'pro_service_provider@example.com' do |user|
    user.password = '123123123'
  end
  user.role_users.create!(role: pro_service_provider_role, until_date: 100.years.from_now) if user.role_users.blank?

  Spree::Taxonomy.find_or_create_by! name: 'B2B'
  Spree::Taxonomy.find_or_create_by! name: 'B2C'

  # Payment method
  sqid_payment_method = Spree::Gateway::SQID.find_or_create_by(name: 'Sqid Payment Test', description: 'Sqid Payment Test') do |sqid|
    sqid.active = true
    # This is not a gateway, this is a payment method for no reason
    # sqid.environment = 'development'
  end

  # The Spree::Store model does not have any payment methods for now. And for no reason.
  # Spree::Store.first.payment_methods << sqid_payment_method unless Spree::Store.first.payment_methods.ids.include?(sqid_payment_method.id)

  # Static pages
  %w(
    AboutYoyakka ExcitingNews PromotionalEvents Careers Feedback GlobalContacts
    YoyakkasValueProposition MarketDevelopment ServicePerformanceMeasurements
    OurCommitmentToOurCustomers YoyakkaInYourBackyard RatingsAndCustomerFeedback
    Contact Free Legal Logs Apps
  ).each do |name|
    p = Spree::Page.create(
      title: name,
      body: "<div class=\"main wrap-padding\">\r\n  <h2 class=\"text-center\"> #{name} </h2>\r\n</div>\r\n",
      slug: "/#{name.underscore}", foreign_link: "/#{name.underscore}", visible: true
    )
    p.stores << Spree::Store.first
  end
end
