# encoding: UTF-8

class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  belongs_to :brand
  belongs_to :category
  attr_accessible :description1, :description2, :features, :name, :price,
                  :slogan, :slug, :brand_id, :category_id,
                  :image, :remove_image, :image_cache,
                  :photo1, :remove_photo1, :photo1_cache,
                  :photo2, :remove_photo2, :photo2_cache,
                  :photo3, :remove_photo3, :photo3_cache,
                  :photo4, :remove_photo4, :photo4_cache,
                  :photo5, :remove_photo5, :photo5_cache

  attr_accessor :photo1, :photo2, :photo3, :photo4, :photo5

  validates_presence_of :name, :slug, :brand_id, :category_id
  validates_presence_of :image, :message => "Добавьте фотографию товара"
  validates_uniqueness_of :name, :slug
  validates_length_of :name, :minimum => 3

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

  mount_uploader :image,  ProductMainImageUploader
  mount_uploader :photo1, ProductImageUploader
  mount_uploader :photo2, ProductImageUploader
  mount_uploader :photo3, ProductImageUploader
  mount_uploader :photo4, ProductImageUploader
  mount_uploader :photo5, ProductImageUploader

  def dental?
    category.slug == 'dental-units'
  end

  def img(n = nil, size = :small)
    n ? send("photo#{n}_url", size) : image_url(size)
  end

  def photos
    a = 1.upto(5).map {|n| send("photo#{n}")}
  end

  def chair_text
    description1.split(text_separator)[0] || ''
  end

  def controls_text
    description1.split(text_separator)[1] || ''
  end

  def assistant_text
    description2.split(text_separator)[0] || ''
  end

  def lamp_text
    description2.split(text_separator)[1] || ''
  end

  def self.including_brand(slug)
    Product.includes(:brand).find_by_slug!(slug)
  end

  def self.with_brand_in_category(brand, category)
    Product.joins(:brand).where(:brands => {:slug => brand.slug}).
        joins(:category).where(categories: {slug: category.slug})
  end

  private

  def text_separator
    "<p>&nbsp;</p>"
  end
end
