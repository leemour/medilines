# encoding: utf-8

class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  attr_accessible :content, :intro, :slug, :title

  validates_presence_of :title, :slug
  validates_uniqueness_of :title, :slug
  validates_length_of :title, :minimum => 3

  attr_accessor :path

  def self.get_page(slug)
    @page = Page.find_by_slug(slug)
    @page = Page.seo(@page)
    @page
  end

  def self.get_info(item = nil)
    if item
      if item.has_attribute? :name
        title = item.name
      elsif item.has_attribute? :title
        title = item.title
      end

      if item.has_attribute? :description
        intro = item.description
      elsif item.has_attribute? :description1
        intro = item.description1
      end
    end
    title ||= ''
    intro ||= ''
    struct = Struct.new :title, :intro, :content
    @page = struct.new
    @page.title = title
    @page.intro = intro
    @page = Page.seo(@page)
    @page
  end

  def should_generate_new_friendly_id?
    new_record?
  end

  private
  def self.seo(item)
    class << item
      attr_accessor :description, :keywords
    end
    item.keywords = 'стоматологические установки,Fedesa,Forest,автоклав,медицинское
      оборудование,визиограф,радиовизиограф,стоматологическое кресло,рентген,томограф'
    item.description = 'Мы поставляем стоматологическое оборудование:
      стоматологические установки Forest, Fedesa, рентгены, системы визуализации.
      Продаем комплектующие и запчасти. Проводим техническое обслуживание, ремонт,
      обучение, консультации.'
    item
  end

end
