# encoding: UTF-8

class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  has_and_belongs_to_many :brands
  attr_accessible :description, :name, :slug

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
end
