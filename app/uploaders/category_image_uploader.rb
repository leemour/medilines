class CategoryImageUploader < ImageUploader
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.slug}"
  end

  version :thumb do
    process :resize_to_fill => [50, 50]
  end
  version :small do
    process :resize_to_fill => [135, 110]
  end
  version :large do
    process :resize_to_fill => [330, 245]
  end
end
