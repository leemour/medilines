ruby '1.9.3'
source 'https://rubygems.org'

gem 'rails', '3.2.13'

gem 'haml', '>= 3.1.6'
gem 'bootstrap-sass', '>= 2.0.4.0'
gem 'jquery-rails'
gem 'friendly_id'
gem 'russian'
gem 'carrierwave'
gem 'mini_magick'

gem 'activeadmin'
gem 'meta_search'
gem 'ckeditor'
gem 'negative_captcha'

group :production do
  gem 'pg'
  gem 'unicorn' # server
  gem 'newrelic_rpm'
end

group :development, :test do
  gem 'sqlite3'
  gem 'haml-rails', '>= 0.3.4'
  gem 'debugger'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'railroady'
  
  gem 'rspec-rails'
  gem 'capybara'
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels'
  gem 'factory_girl'
end

group :test do
  #gem 'spork-rails'
  #gem 'simplecov'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'compass'
  #gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end



# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'