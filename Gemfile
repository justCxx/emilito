source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', '~> 5.0.0'

# === Infrastructure ===
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'

gem 'dotenv-rails'
gem 'rollbar'

# === Web architecture ===
gem 'bcrypt'
gem 'colorize', require: false
gem 'doorkeeper'
gem 'dry-auto_inject'
gem 'dry-container'
gem 'dry-matcher', '0.5'
gem 'dry-types'
gem 'dry-validation'
gem 'reform'
gem 'representable'
gem 'responders'
gem 'shrine'
gem 'trailblazer', '~> 2.0'
gem 'trailblazer-cells'
gem 'trailblazer-endpoint', git: 'https://github.com/trailblazer/trailblazer-endpoint.git'
gem 'trailblazer-rails'

# === Frontend ===
gem 'bootstrap', '4.0.0.alpha4'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'sass-rails', '~> 5.0'
gem 'simple_form'
gem 'slim'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.1.0'
end

group :development, :test do
  gem 'awesome_print', require: 'ap'
  gem 'pry-byebug', platform: :mri
end

group :development do
  gem 'listen', '~> 3.0'
  gem 'rubocop'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'chromedriver-helper'
  gem 'codeclimate-test-reporter', require: false
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'faker', require: false
  gem 'poltergeist'
  gem 'rspec'
  gem 'rspec-power_assert'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'shrine-memory'
  gem 'simplecov'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
