namespace :table_column do
  desc "Add default values to column"
  task :update_all, [:model, :field, :value] => :environment do |t, args|
    if !(args.model && args.field && args.value) ||
      args.model.is_a?(Fixnum) || args.field.is_a?(Fixnum)

      raise StandardError, 'Wrong arguments'
    end
    model = args[:model].constantize
    if model.unscoped.update_all args.field => args.value
      puts 'Successfully updated'
    end
  end

  desc "Add status to Product, Promotion, Page"
  task :add_status => :environment do
    Rake::Task[:update_all].invoke('Product', 'status', 'published')
    Rake::Task[:update_all].invoke('Promotion', 'status', 'published')
    Rake::Task[:update_all].invoke('Page', 'status', 'published')
  end
end