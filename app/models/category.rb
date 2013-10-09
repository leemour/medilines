class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  belongs_to :parent, :class_name => 'Category', :foreign_key => 'parent_id'
  has_many :products
  has_many :brands, :through => :products

  # alias_attribute :title, :name
  # alias_attribute :intro, :description

  attr_accessible :description, :name, :slug, :parent, :logo, :parent_id

  validates_presence_of :name, :slug
  validates_uniqueness_of :name, :slug
  validates_length_of :name, :minimum => 4

  mount_uploader :logo, CategoryImageUploader

  scope :roots,      where("parent_id IS NULL")
  scope :join_parent, lambda { |slug|
    joins("JOIN categories AS cat2 ON categories.parent_id = cat2.id").
    where("cat2.slug = ?", slug)
  }
  scope :dentals,    join_parent('dental-units')
  scope :visuals,    join_parent('visual-systems')
  scope :components, join_parent('components')
  scope :spares,     join_parent('spare-parts')

  def title
    name
  end

  def intro
    description
  end

  def children
    Category.includes(:brands).find_all_by_parent_id id
  end

  def root?
    parent_id.nil?
  end

  def should_generate_new_friendly_id?
    new_record?
  end
end
