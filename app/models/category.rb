class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  has_and_belongs_to_many :brands
  attr_accessible :description, :name, :slug
end
