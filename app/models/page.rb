# encoding: utf-8

class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  attr_accessible :content, :intro, :slug, :title
  attr_accessor :path
  attr_reader   :keywords, :description

  validates_presence_of :title, :slug
  validates_uniqueness_of :title, :slug
  validates_length_of :title, :minimum => 3


  def self.get_page(slug)
    page = Page.find_by_slug(slug)
    page.add_seo
    page
  end

  def self.make_from(item = nil)
    data = Page.get_info_from item
    page = Page.new(data)
    page.add_seo
    page
  end

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

  private
  # attr_writer :title, :intro, :keywords, :description

  def self.get_info_from(item)
    Page.avoid_undefined_method_error_from item
    title = item.title  || item.name      || ''
    intro = item.intro  || item.features  || item.description || ''
    {title: title, intro: intro}
  end

  def self.avoid_undefined_method_error_from(item)
    class << item
      def method_missing(meth)
        if %w{title name intro features description}.include? meth.to_s
          return nil unless has_attribute? meth
        end
        super
      end
    end
  end
end
