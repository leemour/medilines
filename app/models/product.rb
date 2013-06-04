# encoding: UTF-8

class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  belongs_to :brand
  belongs_to :category
  attr_accessible :description1, :description2, :features, :name, :price,
                  :slogan, :slug, :brand_id, :category_id, :image,
                  :remove_image, :image_cache

  validates_presence_of :name, :slug, :brand_id, :category_id
  validates_presence_of :image, :message => "Добавьте фотографию товара"
  validates_uniqueness_of :name, :slug
  validates_length_of :name, :minimum => 3, :message => "Слишком короткое название"

  scope :recent, proc { |n| order("created_at desc").limit(n) }
  scope :join_categories_included, lambda { |slug|
        joins(:category).
        joins("LEFT OUTER JOIN categories AS cat2 ON categories.parent_id = cat2.id").
        where("categories.slug = ? OR cat2.slug = ?", slug, slug)
  }
  scope :dentals,    join_categories_included('dental-units')
  scope :visuals,    join_categories_included('visual-systems')
  scope :components, join_categories_included('components')
  scope :spares,     join_categories_included('spare-parts')

  mount_uploader :image, ProductImageUploader
end
