class ProductImageUploader < ImageUploader
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.slug}"
  end

  def default_url
    nil
  end

  version :small do
    process :resize_to_fill => [75, 100]
  end
  version :medium do
    process :resize_to_fill => [100, 135]
  end
  version :large do
    process :resize_to_fill => [400, 300]
  end
  version :full do
    process :resize_to_fill => [800, 600]
  end
end
