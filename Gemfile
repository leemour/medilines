ruby '2.1.0'
source 'https://rubygems.org'

gem 'rails', '3.2.16'

gem 'sqlite3'

gem 'haml'
gem 'jquery-rails'
gem 'fancybox2-rails'
gem 'friendly_id'
gem 'russian'
gem 'carrierwave'
gem 'mini_magick'

gem 'activeadmin'
gem 'meta_search'
gem 'ckeditor'
gem 'negative_captcha'
gem 'sitemap_generator'

gem 'unicorn'
gem 'capistrano', '~> 2.15'

group :production do
  gem 'newrelic_rpm'
end

group :development do
  gem 'irbtools'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem "quiet_assets"
end

group :development, :test do
  gem 'spring'
  gem "spring-commands-rspec"
  gem 'haml-rails'
  gem 'byebug'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'railroady'

  gem 'guard-livereload'
  gem 'rack-livereload'
end

group :test do
  # gem 'spork-rails'
  gem 'guard-rspec'
  # gem 'guard-spork'
  # gem 'guard-cucumber'
  #gem 'simplecov'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels'
  gem 'factory_girl_rails'
  gem 'ffaker'
  #system-dependent notifications (uncomment for a team)
  gem 'rb-inotify', :require => false
  #gem 'rb-fsevent', :require => false
  #gem 'rb-fchange', :require => false
end

group :assets do
  gem 'turbo-sprockets-rails3'
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end