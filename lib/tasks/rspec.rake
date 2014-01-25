# require 'rspec/core/rake_task'

# namespace :spec do
#   desc 'Run all specs in spec directory (exluding request/integration specs)'
#   RSpec::Core::RakeTask.new(:no) do |task|
#     file_list = FileList['spec/**/*_spec.rb']

#     %w(requests integration views).each do |exclude|
#       file_list = file_list.exclude("spec/#{exclude}/**/*_spec.rb")
#     end

#     task.pattern = file_list
#   end
# end