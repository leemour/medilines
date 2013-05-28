class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  belongs_to :brand
  belongs_to :category
  attr_accessible :description, :design, :features, :name, :options, :price,
                  :slogan, :slug, :type, :brand_id, :category_id, :image,
                  :remove_image, :image_cache

  scope :dentals, joins(:category).where(categories: {slug: 'dental-units'})
  scope :visuals, joins(:category).where(categories: {slug: 'visual_systems'})
  scope :components, joins(:category).where(categories: {slug: 'components'})
  scope :spares, joins(:category).where(categories: {slug: 'spare-parts'})

  scope :recent, proc { |n| order("created_at desc").limit(n) }

  mount_uploader :image, ProductImageUploader
end
