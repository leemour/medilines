# encoding: UTF-8

class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  belongs_to :parent, :class_name => 'Category', :foreign_key => 'parent_id'

  attr_accessible :description, :name, :slug, :parent, :logo, :parent_id

  validates_presence_of :name, :slug
  validates_uniqueness_of :name, :slug
  validates_length_of :name, :minimum => 4, :message => "Слишком короткое название"

  scope :roots,      where("parent_id IS NULL")
  scope :join_parent, lambda { |slug|
    joins("JOIN categories AS cat2 ON categories.parent_id = cat2.id").
    where("cat2.slug = ?", slug)
  }
  scope :dentals,    join_parent('dental-units')
  scope :visuals,    join_parent('visual-systems')
  scope :components, join_parent('components')
  scope :spares,     join_parent('spare-parts')

  def self.get_info(category)
    struct = Struct.new :header, :intro, :header2, :outro
    @page = struct.new
    @page.header  = category.name
    @page.intro   = category.description
    @page.header2 = 'Мы предлагаем наилучшие товары'
    @page.outro   = 'Вы можете заказать любые приборы визуализации'
    @page
  end

  def should_generate_new_friendly_id?
    new_record?
  end

  mount_uploader :logo, ImageUploader
end
