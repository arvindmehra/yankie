source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'rails-assets-jquery.fancybox', source: 'https://rails-assets.org'
gem 'jquery-cookie-rails'
# Models extensions
gem 'geocoder'
gem 'validates_timeliness', '~> 4.0'
gem 'wannabe_bool'
gem 'paranoia'
gem 'active_type'
gem 'gibbon'
gem 'spree_static_content', github: 'spree-contrib/spree_static_content', branch: '3-1-stable'

# Views extensions
gem 'haml-rails'
gem 'simple_form'
gem 'cocoon'
gem 'enum_help'
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.37'
gem 'gon', '~> 6.1'
gem 'high_voltage', '~> 3.0.0'

# API
gem 'httparty'

# Background
gem 'celluloid', '~> 0.16.0'
gem 'sidekiq', '~> 4.1', '>= 4.1.1'
gem 'sidetiq', '~> 0.6.3'
gem 'sinatra', require: nil
gem 'sidekiq-failures', '~> 0.4.5'
gem 'sidekiq-status', '~> 0.6.0'

group :production do
  gem 'unicorn'
end

# Spree dependencies
gem 'spree', '~> 3.1.0.rc1'
gem 'spree_auth_devise', '~> 3.1.0.rc1'
gem 'spree_gateway', '~> 3.1.0.rc1'

gem 'dotenv-rails'

group :development, :test do
  gem 'byebug'
  gem 'pry-byebug'
  gem 'better_errors'
  # gem 'did_you_mean'
  gem 'binding_of_caller', '~> 0.7.2'
  gem 'pry-rails', '~> 0.3.3'
end

group :development do
  gem 'quiet_assets', '~> 1.1.0'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  gem 'spring'

  # Deploy
  gem 'capistrano', '~> 3.5'
  gem 'capistrano-rvm'
  gem 'capistrano-rails'
  gem 'capistrano3-unicorn'
  gem 'capistrano-sidekiq'

  gem 'letter_opener'
end
