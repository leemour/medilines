class Product < ActiveRecord::Base
  belongs_to :brand
  attr_accessible :description, :design, :features, :name, :options, :price, :slogan, :slug, :type
end
