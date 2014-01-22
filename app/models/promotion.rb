class Promotion < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  include Statusable
  status published: "опубликовано", draft: "черновик"

  attr_accessible :content, :slug, :title, :status

  validates_presence_of :title, :slug
  validates_uniqueness_of :title, :slug
  validates_length_of :title, :minimum => 3

  default_scope published

  def should_generate_new_friendly_id?
    new_record?
  end
end
