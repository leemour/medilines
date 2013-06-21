# encoding: UTF-8
class MainController < ApplicationController

  before_filter :category_init,       :only => [:category, :subcategory]
  before_filter :category_brand_init, :only => [:category_brand]

  def category
    @subcategories = Category.find_children(@category)
    if @subcategories.empty?
      @brands = Brand.find_all_in_category(@category)
      render "/categories/category_with_brands"
    else
      render "/categories/category_with_categories"
    end
  end

  def subcategory
    if @category.products.count > 1
      @brands = Brand.find_all_in_category(@category)
      render "/categories/category_with_brands"
    else
      @products = @category.products.includes(:brand)
      render "/categories/category_with_products"
    end
  end

  def category_brand
    @products = Product.with_brand_in_category(@brand, @category)
    render '/brand'
  end

  def product
    @product = Product.including_brand(params[:product])
    @page    = Page.get_info(@product)
    render '/product'
  end


  private
  # Get category depending on url
  def get_category
    category = params[:subcategory] || params[:category]
    @category = Category.find_by_slug!(category)
  end

  def category_init
    get_category
    @page     = Page.get_info(@category)
  end

  # Initialize vars before brand actions
  def category_brand_init
    get_category
    @brand    = Brand.find_by_slug!(params[:brand])
    @page     = Page.get_info(@brand)
  end
end
