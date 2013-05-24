class Brand < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name

  has_many :products
  has_and_belongs_to_many :categories
  attr_accessible :country, :description, :flag, :image, :logo, :name, :slogan

  def self.find_all_in_category(product_type)
    category = Category.find_by_slug(product_type)
    category.brands
  end
end
