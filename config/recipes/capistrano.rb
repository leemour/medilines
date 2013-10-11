namespace :config do
  desc "Copy uploads to remote server"
  task :up do
    run    "mkdir -p #{shared_path}/uploads"
    upload "public/uploads", "#{shared_path}/uploads"
  end
  task :down do
    run    "mkdir -p #{shared_path}/uploads"
    upload "public/uploads", "#{shared_path}/uploads"
  end
  task :down_to do
    run    "mkdir -p #{shared_path}/uploads"
    upload "public/uploads", "#{shared_path}/uploads"
  end
end

# namespace :assets do
#   task :sync do
#     assets_path = "#{user}@#{domain}:#{shared_path}"
#     system "rsync -vr --exclude='.DS_Store' public/assets #{assets_path}"
#   end
# end

namespace :uploads do
  desc "Upload uploads to SHARED_PATH/uploads"
  task :up do
    run    "mkdir -p #{shared_path}/uploads"
    upload "public/uploads", "#{shared_path}/uploads"
  end
  desc "Download uploads to default public/uploads"
  task :down do
    download "#{shared_path}/uploads", "public/uploads"
  end
  desc "Download uploads to custom local folder"
  task :down_to do
    download "#{shared_path}/uploads", ENV['to']
  end
  desc "Synchronize uploads to remote"
  task :sync do
    uploads_path = "#{user}@#{domain}:#{shared_path}/uploads"
    system "rsync -vru --exclude='.DS_Store' public/uploads #{uploads_path}"
  end
end

namespace :rake do
  set :dbz, %w[create migrate reset rollback seed setup]
  set :assetz, %w[precompile clean]
  set :tmpz, %w[cache:clear clear create pids:clear sessions:clear sockets:clear]

  task :cd_current do
    run "cd #{current_path}"
  end

  desc "Invoke rake task"
  # run like: cap staging rake:invoke task=a_certain_task
  task :invoke do
    rake.cd_current
    run "bundle exec rake #{ENV['task']} RAILS_ENV=#{rails_env}"
  end

  # DB
  namespace :db do
    dbz.each do |command|
      desc "Rake db:#{command}"
      task command, roles: :app, except: {no_release: true} do
        rake.cd_current
        run "bundle exec rake db:#{ENV['task']} RAILS_ENV=#{rails_env}"
      end
    end
  end
  # Assets
  namespace :assets do
    assetz.each do |command|
      desc "Rake assets:#{command}"
      task command, roles: :app, except: {no_release: true} do
        rake.cd_current
        run "bundle exec rake assets:#{ENV['task']} RAILS_ENV=#{rails_env}"
      end
    end
  end
  # Tmp
  namespace :tmp do
    tmpz.each do |command|
      desc "Rake tmp:#{command}"
      task command, roles: :app, except: {no_release: true} do
        rake.cd_current
        run "bundle exec rake tmp:#{ENV['task']} RAILS_ENV=#{rails_env}"
      end
    end
  end

  # Rake exec custom tasks
  # set :rake_cmd, (ENV['task'] || rake_cmd)

  # task :rake_exec do
  # if rake_cmd
  #     rake.cd_current
  #     run "bundle exec rake #{rake_cmd} RAILS_ENV=#{rails_env}"
  #   end
  # end
  # # Using database sessions?
  # task :clear_sessions do
  #   set :rake_cmd, "db:sessions:clear"
  #   rake_exec
  # end

  # # Clear file-based fragment and/or page cache
  # task :clear_cache do
  #   # I usually make a custom Rake task for this
  #   set :rake_cmd, "tmp:cache:clear"
  #   rake_exec
  # end
end