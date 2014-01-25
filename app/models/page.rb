class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  include Statusable
  status published: "опубликовано", draft: "черновик"

  attr_accessible :content, :intro, :slug, :title, :status
  # attr_accessor :path
  attr_reader   :keywords, :description

  validates_presence_of   :title, :slug
  validates_uniqueness_of :title, :slug
  validates_length_of     :title, :minimum => 3

  def self.get_page(slug)
    page = published.find_by_slug(slug)
    page.add_seo
    page
  end

  def self.make_from(item = nil)
    data = data_from item
    page = new(data)
    page.add_seo
    page
  end

  def self.data_from(item)
    title = item.title  || ''
    intro = item.intro  || ''
    {title: title, intro: intro}
  end
  private_class_method :data_from


  def add_seo
    @keywords = %{
      стоматологические установки,Fedesa,Forest,автоклав,медицинское оборудование,
      визиограф,радиовизиограф,стоматологическое кресло,рентген,томограф
    }.gsub /\n */, ''
    @description = %{
      Продажа стоматологического оборудования: стоматологические установки
      Forest, Fedesa, рентгены, системы визуализации. Комплектующие и запчасти.
      Техническое обслуживание, ремонт, обучение, консультации.
    }.gsub /\n */, ''
  end

  def should_generate_new_friendly_id?
    new_record?
  end
end
