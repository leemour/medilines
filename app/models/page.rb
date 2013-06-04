# encoding: utf-8

class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  attr_accessible :content, :intro, :slug, :title

  validates_presence_of :title, :slug
  validates_uniqueness_of :title, :slug
  validates_length_of :title, :minimum => 3, :message => "Слишком короткое название"

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

  def self.home
    struct = Struct.new :title, :intro, :content
    @page = struct.new
    @page.title   = 'Стоматологическое оборудование'
    @page.intro    = '«Медилайн Сервис» является поставщиком различного стоматологического оборудования. У нас вы можете приобрести стоматологические установки от бюджетного до премиум класса. Мы являемся официальными поставщиками стоматологических установок фирмы «Forest».'
    @page.content    = 'У нас вы можете получить полный спектр услуг по монтажу, гарантийного и постгарантийного обслуживания стоматологического оборудования. наши специалисты будут всегда рады вам помочь в выборе стоматологического оборудования. В «Медилайн Сервис» можно купить стоматологическую установку, рентген, лазер, системы визуализации, комплектующие стоматологического кабинета.'
    @page = Page.seo(@page)
    @page
  end

  def self.promotions
    @page = Page.find_by_slug('promotions')
    @page = Page.seo(@page)
    @page
  end

  def self.contacts
    @page = Page.find_by_slug('contacts')
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
    item.keywords = 'стоматологические установки,Fedesa,Forest,автоклав,медицинское оборудование,визиограф,радиовизиограф,стоматологическое кресло,рентген,томограф'
    item.description = 'Мы поставляем стоматологическое оборудование: стоматологические установки Forest, Fedesa, рентгены, системы визуализации. Продаем комплектующие и запчасти. Проводим техническое обслуживание, ремонт, обучение, консультации.'
    item
  end

end
