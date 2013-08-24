rails_env = ENV['RAILS_ENV'] || 'production'

worker_processes (rails_env == 'production' ? 4 : 2)
preload_app true
timeout 15

deploy_to       = '/srv/www/medilines'
listen            "#{deploy_to}/shared/unicorn.sock", :backlog => 1024
pid               "#{deploy_to}/shared/pids/unicorn.pid"
working_directory "#{deploy_to}/current"
stdout_path       "#{deploy_to}/current/log/unicorn.log"
stderr_path       "#{deploy_to}/current/log/unicorn_error.log"

GC.respond_to?(:copy_on_write_friendly=) and
  GC.copy_on_write_friendly = true

before_fork do |server, worker|

  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|

  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end