class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  belongs_to :brand
  delegate :category, :to => :brand, :allow_nil => true
  attr_accessible :description, :design, :features, :name, :options, :price,
                  :slogan, :slug, :type, :brand_id, :image, :remove_image, :image_cache

  mount_uploader :image, ProductImageUploader
end
