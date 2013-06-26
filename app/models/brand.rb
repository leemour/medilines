# encoding: UTF-8

class Brand < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  has_many :products
  has_many :categories, :through => :products
  attr_accessible :country, :description, :details, :flag, :remove_flag,
                  :flag_cache, :image, :remove_image, :image_cache, :logo,
                  :name, :slogan, :slug

  attr_accessor :category

  validates_presence_of :name, :slug
  validates_uniqueness_of :name, :slug
  validates_length_of :name, :minimum => 4, :message => "Слишком короткое название"

  mount_uploader :image, ImageUploader
  mount_uploader :flag,  ImageUploader
  mount_uploader :logo,  LogoUploader

  def remove_image=(val)
    image_will_change! if val
    super
  end

  def should_generate_new_friendly_id?
    new_record?
  end

  def self.find_all_in_category(category)
    #products = Product.includes(:brand).find_all_by_category_id(category.id)
    #products.map { |product| product.brand }.uniq
    brands = Brand.joins(:products).
              where('products.category_id = ?', category.id).uniq
    brands
  end
end
