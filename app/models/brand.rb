class Brand < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  has_many :products
  has_and_belongs_to_many :categories
  attr_accessible :country, :description, :details, :flag, :remove_flag,
                  :flag_cache, :image, :remove_image, :image_cache, :logo,
                  :name, :slogan, :slug

  mount_uploader :image, ImageUploader
  mount_uploader :flag, ImageUploader

  def remove_image=(val)
    image_will_change! if val
    super
  end

  def should_generate_new_friendly_id?
    new_record?
  end

  def self.find_all_in_category(product_type)
    category = Category.find_by_slug(product_type)
    category.brands
  end
end
