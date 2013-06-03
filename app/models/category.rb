# encoding: UTF-8

class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  belongs_to :parent, :class_name => 'Category', :foreign_key => 'parent_id'

  attr_accessible :description, :name, :slug, :parent, :logo, :parent_id

  scope :roots,      where("parent_id IS NULL")
  scope :dentals,    joins("JOIN categories AS cat2 ON categories.parent_id = cat2.id").where(cat2: {slug: 'dental-units'})
  scope :visuals,    joins("JOIN categories AS cat2 ON categories.parent_id = cat2.id").where(cat2: {slug: 'visual-systems'})
  scope :components, joins("JOIN categories AS cat2 ON categories.parent_id = cat2.id").where(cat2: {slug: 'components'})
  scope :spares,     joins("JOIN categories AS cat2 ON categories.parent_id = cat2.id").where(cat2: {slug: 'spare-parts'})

  def self.get_info(slug)
    category = Category.find_by_slug(slug)
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
