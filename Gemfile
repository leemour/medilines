ruby '2.0.0'
source 'https://rubygems.org'

gem 'rails', '3.2.13'

gem 'haml', '>= 3.1.6'
# gem 'bootstrap-sass', '>= 2.0.4.0'
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
gem 'capistrano'

group :production do
  gem 'sqlite3'
  gem 'pg'
  gem 'newrelic_rpm'
end

group :development do
  gem 'irbtools'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem "quiet_assets"
end

group :development, :test do
  gem 'sqlite3'
  gem 'haml-rails', '>= 0.3.4'
  # gem 'debugger'
  gem 'byebug'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'railroady'

  gem 'guard-livereload'
  gem 'rack-livereload'
end

group :test do
  gem 'rspec-rails'
  gem 'spork-rails'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'guard-cucumber'
  #gem 'simplecov'
  gem 'capybara'
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels'
  gem 'factory_girl_rails'
  #system-dependent notifications (uncomment for a team)
  gem 'rb-inotify', :require => false
  #gem 'rb-fsevent', :require => false
  #gem 'rb-fchange', :require => false
end

group :assets do
  # gem 'turbo-sprockets-rails3'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  # gem 'compass'
  # gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end



# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'