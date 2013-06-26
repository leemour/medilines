Product.all.each do |p|
  %w(photo1 photo2 photo3 photo4 photo5).map(&:to_sym).each do |photo|
    if p.read_attribute(photo).present?
      p.send(photo).recreate_versions!
    end
  end
end