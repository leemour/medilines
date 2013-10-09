class LogoUploader < ImageUploader
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.slug}"
  end

  version :thumb do
    process :resize_and_pad => [50, 50]
  end
  version :small do
    process :resize_and_pad => [80, 40]
  end
  version :medium do
    process :resize_and_pad => [120, 50]
  end
end
