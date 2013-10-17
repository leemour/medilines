log_formatters = [
  { :match => /successful/,            :color => :green,   :priority => 10 },
  { :match => /executing command/,     :color => :blue,    :priority => 10, :style => :underscore },
  { :match => /^transaction: commit$/, :color => :magenta, :priority => 10, :style => :blink }
]

log_formatter(log_formatters)

# Helpers
def copy_to_local(path)
  time        = Time.now.strftime "%Y-%m-%d_%H-%M"
  backup_path = File.expand_path "~leemour/Backup"
  dir         = "#{backup_path}/#{application}/#{path}/#{time}"
  destination = ENV['to'] || dir
  download "#{shared_path}/#{path}", destination, recursive: true
end

def copy_to_remote(path)
  time = Time.now.strftime "%Y-%m-%d_%H-%M"
  dir  = "#{shared_path}/backup/#{path}/#{time}"
  run  "mkdir -p #{dir}"
  run  "cp -a #{shared_path}/#{path}/* #{dir}"
end

# Data & Settings
namespace :config do
  desc "Upload Config to remote server"
  task :up do
    remote_backup
    upload "config/database.yml #{shared_path}/config/database.yml"
    upload "config/env.rb #{shared_path}/config/env.rb"
  end
  desc "Download Config to backup path"
  task :backup do
    copy_to_local "config"
  end
  desc "Backup Config to remote shared folder"
  task :remote_backup do
    copy_to_remote "config"
  end
end

namespace :database do
  desc "Upload DB to remote server"
  task :up do
    remote_backup
    # Uploading development DB as production!
    upload "db/development.sqlite3 #{shared_path}/db/production.sqlite3"
  end
  desc "Download DB to backup path"
  task :backup do
    copy_to_local "db"
  end
  desc "Backup DB to remote shared folder"
  task :remote_backup do
    copy_to_remote "db"
  end
end

namespace :uploads do
  desc "Upload Uploads to remote shared dir"
  task :up do
    run    "mkdir -p #{shared_path}/uploads"
    upload "public/uploads", "#{shared_path}/uploads", recursive: true
  end
  desc "Download uploads to backup folder"
  task :backup do
    copy_to_local "uploads"
  end
  desc "Backup Uploads to remote shared folder"
  task :remote_backup do
    copy_to_remote "uploads"
  end
  desc "Synchronize uploads to remote"
  task :sync do
    uploads_path = "#{user}@#{domain}:#{shared_path}/uploads"
    system "rsync -vru --exclude='.DS_Store' public/uploads #{uploads_path}"
  end
end


# Rake
namespace :rake do
  desc "Invoke rake task"
  # run like: cap staging rake:invoke task=a_certain_task
  task :invoke do
    rake.cd_current
    run "bundle exec rake #{ENV['task']} RAILS_ENV=#{rails_env}"
  end

  # Predefined tasks
  groups = {
    "db"     => %w[create migrate reset rollback seed setup],
    "assets" => %w[precompile clean],
    "tmp"    => %w[cache:clear clear create pids:clear sessions:clear sockets:clear]
  }
  groups.keys.each do |group|
    namespace group.to_sym do
      groups[group].each do |command|
        desc "Rake #{group}:#{command}"
        task command, roles: :app, except: {no_release: true} do
          run "cd #{current_path}"
          run "bundle exec rake #{group}:#{command} RAILS_ENV=#{rails_env}"
        end
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

# namespace :assets do
#   task :sync do
#     assets_path = "#{user}@#{domain}:#{shared_path}"
#     system "rsync -vr --exclude='.DS_Store' public/assets #{assets_path}"
#   end
# end