class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  belongs_to :brand
  belongs_to :category
  attr_accessible :description1, :description2, :features, :name, :price,
                  :slogan, :slug, :brand_id, :category_id, :image,
                  :remove_image, :image_cache

  #scope :dentals,    joins(:category).where(categories: {slug: 'dental-units'})
  #scope :visuals,    joins(:category).where(categories: {slug: 'visual-systems'})
  #scope :components, joins(:category).where(categories: {slug: 'components'})
  #scope :spares,     joins(:category).where(categories: {slug: 'spare-parts'})
  scope :join_categories_included, joins(:category)
        .joins("LEFT OUTER JOIN categories AS cat2 ON categories.parent_id = cat2.id")
  scope :dentals,    join_categories_included.where("categories.slug = 'dental-units'
                                                    OR cat2.slug = 'dental-units'")
  scope :visuals,    join_categories_included.where("categories.slug = 'visual-systems'
                                                    OR cat2.slug = 'visual-systems'")
  scope :components, join_categories_included.where("categories.slug = 'components'
                                                    OR cat2.slug = 'components'")
  scope :spares,     join_categories_included.where("categories.slug = 'spare-parts'
                                                    OR cat2.slug = 'spare-parts'")

  scope :recent, proc { |n| order("created_at desc").limit(n) }

  mount_uploader :image, ProductImageUploader
end
