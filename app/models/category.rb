class Category < ActiveRecord::Base
  has_and_belongs_to_many :brands
  attr_accessible :description, :name, :slug
end
