namespace :image_versions do
  desc "Recreat image versions for all products"
  task :recreate => :environment do
    Product.all.each do |p|
      %w(photo1 photo2 photo3 photo4 photo5).map(&:to_sym).each do |photo|
        if p.read_attribute(photo).present?
          p.send(photo).recreate_versions!
        end
      end
    end
  end
end

namespace :table_column do
  desc "Add default values to column"
  task :update_all, [:model, :field, :value] => :environment do |t, args|
    if !(args.model && args.field && args.value) ||
      args.model.is_a?(Fixnum) || args.field.is_a?(Fixnum)

      raise StandardError, 'Wrong arguments'
    end
    puts args
    puts args.class
    model = args[:model].constantize
    model.update_all args.field => args.value
  end
end