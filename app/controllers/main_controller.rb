# encoding: UTF-8
class MainController < ApplicationController
  include UrlHelper

  before_filter :category_init,       :only => [:category, :subcategory]
  before_filter :category_brand_init, :only => [:category_brand]

  def category
    @subcategories = Category.find_children(@category)
    if @subcategories.empty?
      @brands = Brand.find_all_in_category(@category)
      render "/categories/brands"
    else
      render "/categories/index"
    end
  end

  def subcategory
    if @category.products.count > 1
      @brands = Brand.find_all_in_category(@category)
      render "/categories/brands"
    else
      @products = @category.products.includes(:brand)
      render "/products/index"
    end
  end

  def category_brand
    @products = Product.with_brand_in_category(@brand, @category)
    if @products.count > 1
      render '/products/index'
    else
      redirect_to product_url(@products.first), status: 307
    end
  end

  def product
    @product = Product.including_brand(params[:product])
    @page    = Page.make_from @product
    if @product.dental?
      render 'products/dental/show'
    else
      render '/products/show'
    end
  end


  private
  # Get category depending on url
  def get_category
    category = params[:subcategory] || params[:category]
    @category = Category.find_by_slug!(category)
  end

  def category_init
    get_category
    @page     = Page.make_from @category
  end

  # Initialize vars before brand actions
  def category_brand_init
    get_category
    @brand    = Brand.find_by_slug!(params[:brand])
    @page     = Page.make_from @brand
  end
end
