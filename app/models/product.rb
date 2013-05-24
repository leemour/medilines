class Product < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  belongs_to :brand
  attr_accessible :description, :design, :features, :name, :options, :price, :slogan, :slug, :type
end
