class Brand < ActiveRecord::Base
  has_many :products
  has_and_belongs_to_many :categories
  attr_accessible :country, :description, :flag, :image, :logo, :name, :slogan
end
