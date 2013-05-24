#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :seo
  
  private
  def seo
    @seo = General.seo
  end
  
  public
  
  def home
    @page = General.home
    render '/home'
  end
  
  def contacts
    @page = nil
    render '/contacts'
  end
  
  def category
    @brands = Brand.find_all_in_category(params[:product_type])
    render "/categories/category_#{params[:product_type]}"
  end
  
  def brand
    @products = Product.joins(:brand).where(:brands => {:slug => params[:brand]})\
      .joins(:category).where(categories: {slug: params[:product_type]})
    #@products = Product.joins(:brand).where(:brands => {:slug => params[:brand]})
    #@brands = Brand.joins(:categories).where(categories: {slug: params[:product_type]})
    render '/brand'
  end
  
  def product
    @product = Product.where(type: params[:product_type], brand: params[:brand], title: params[:product])
    render '/product'
  end
end
