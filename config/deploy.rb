require "bundler/capistrano"
load "config/recipes/capistrano"
load "config/env"

set :stages, %w[production staging]
set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :domain, ENV["REMOTE_IP"]
server domain, :app, :web, :db, :primary => true

set :application, "medilines"
set :repository,  "git@bitbucket.org:leemour/#{application}.git"
set :deploy_to, "/srv/www/#{application}"
set :branch, "master"
set :keep_releases, 5
set :scm, "git"
set :deploy_via, :remote_cache

set :user, ENV["REMOTE_USER"]
# set :group, "deployers"
set :use_sudo, false
set :rails_env, "production"
set :ssh_options, { :forward_agent => true, :port => ENV["REMOTE_PORT"] }
default_run_options[:pty] = true


namespace :deploy do
  %w[start stop restart reload upgrade].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      # run "/etc/init.d/unicorn_#{application} #{command}"
      run "service unicorn_#{application} #{command}"
    end
  end

  desc "Setup default folders and files"
  task :setup_config, roles: :app do
    # Server config
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    # App config
    run  "mkdir -p #{shared_path}/config"
    put  File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit the config files in #{shared_path}."
    # Uploads
    run  "mkdir -p #{shared_path}/uploads"
    puts "Now copy uploads files to #{shared_path}."
    # Logs
    run  "mkdir -p #{shared_path}/log"
    puts "Now copy uploads files to #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  desc "Link shared files/folders to current_path"
  task :symlink_config, roles: :app do
    # Config
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/db/production.sqlite3 #{release_path}/db/production.sqlite3"
    run "ln -nfs #{shared_path}/config/env.rb #{release_path}/config/env.rb"
    # Uploads
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse bb/deploy`
      puts "WARNING: HEAD is not the same as bb/deploy"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end