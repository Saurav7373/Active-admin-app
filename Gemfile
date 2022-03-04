# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.0'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'
# gem 'sprockets-rails', '2.3.3'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Sass to process CSS
gem 'sassc-rails'

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

# Plus integrations with:
gem 'devise'
# gem 'cancancan'
gem 'draper'
gem 'pundit'

# active admin
gem 'activeadmin', git: 'https://github.com/naveed-ahmad/activeadmin.git', branch: 'rails7'
gem 'inherited_resources', git: 'https://github.com/naveed-ahmad/inherited_resources.git', branch: 'rails7'
gem 'ransack', github: 'activerecord-hackery/ransack'

gem 'image_processing', '~> 1.12', '>= 1.12.1'
gem 'shrine', '~> 3.4'

gem 'activeadmin-select2', github: 'mfairburn/activeadmin-select2'
gem 'jquery-rails'
gem 'select2-rails', '~> 4.0', '>= 4.0.13'

gem 'coffee-rails'
gem 'rubocop-rails', require: false
# gem 'ransack', '~> 2.5'

# gem 'active_admin_importable', :git => "git://github.com/krhorst/active_admin_importable.git"

# gem "active_admin_import" , github: "Fivell/active_admin_import"

# gem 'active_admin_csv_import'

# gem 'active_admin_excel_upload', :git => "git://github.com/shivgarg5676/active_admin_excel_upload.git"

# gem 'sidekiq', '~> 6.4'

# gem 'csv-importer'
gem 'sidekiq', '~> 6.4', '>= 6.4.1'
gem 'smarter_csv'

# Used to send emails
gem 'sendgrid-ruby', '~> 6.6', '>= 6.6.1'

gem 'paper_trail'
