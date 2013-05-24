class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  belongs_to :brand
  belongs_to :category
  attr_accessible :description, :design, :features, :name, :options, :price,
                  :slogan, :slug, :type, :brand_id, :category_id, :image,
                  :remove_image, :image_cache

  mount_uploader :image, ProductImageUploader
end
