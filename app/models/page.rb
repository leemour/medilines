# encoding: utf-8

class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  attr_accessible :content, :intro, :slug, :title

  validates_presence_of :title, :slug
  validates_uniqueness_of :title, :slug
  validates_length_of :title, :minimum => 3

  attr_accessor :path
  attr_reader   :title, :intro, :keywords, :description

  def self.get_page(slug)
    page = Page.find_by_slug(slug)
    page.add_seo
    page
  end

  def self.make_from(item = nil)
    page = Page.new
    page.add_info_from item if item
    page.add_seo
    page
  end

  def should_generate_new_friendly_id?
    new_record?
  end

  def add_info_from(item)
    avoid_undefined_method_error item
    @title = item.name         || item.title    || ''
    @intro = item.description  || item.features || ''
  end

  def add_seo
    @keywords = %{
      стоматологические установки,Fedesa,Forest,автоклав,медицинское оборудование,
      визиограф,радиовизиограф,стоматологическое кресло,рентген,томограф
    }
    @description = %{
      Продажа стоматологического оборудования: стоматологические установки
      Forest, Fedesa, рентгены, системы визуализации. Комплектующие и запчасти.
      Техническое обслуживание, ремонт, обучение, консультации.
    }
  end

  private

  def avoid_undefined_method_error(item)
    class << item
      def method_missing(meth)
        return nil if %w{name title description features}.include? meth.to_s
        super
      end
    end
  end
end
