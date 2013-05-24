class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  has_and_belongs_to_many :brands
  attr_accessible :description, :name, :slug

  def should_generate_new_friendly_id?
    new_record?
  end
end
