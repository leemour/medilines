namespace :cache do
  desc 'Clear cache'
  task :clear => :environment do
    Rails.cache.clear
    CACHE.flush
  end
end