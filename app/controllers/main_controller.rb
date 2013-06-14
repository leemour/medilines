# encoding: UTF-8
class MainController < ApplicationController

  before_filter :category_brand_init, :only => [:category_brand, :subcategory_brand]

  def category
    @category      = Category.find_by_slug!(params[:category])
    @page          = Page.get_info(@category)
    @subcategories = Category.find_children(@category)

    if @subcategories.empty?
      @brands = Brand.find_all_in_category(@category)
      render "/categories/category_with_brands"
    else
      render "/categories/category_with_categories"
    end
  end

  def subcategory
    @category = Category.find_by_slug!(params[:subcategory])
    @page     = Page.get_info(@category)

    if @category.products.count > 1
      @brands = Brand.find_all_in_category(@category)
      render "/categories/category_with_brands"
    else
      @products = @category.products.includes(:brand)
      render "/categories/category_with_products"
    end
  end

  def category_brand
    @category = Category.find_by_slug(params[:category])
    @products = Product.joins(:brand).where(:brands => {:slug => params[:brand]}).
        joins(:category).where(categories: {slug: params[:category]})

    render '/brand'
  end

  def subcategory_brand
    @category = Category.find_by_slug(params[:subcategory])
    @products = Product.joins(:brand).where(:brands => {:slug => params[:brand]}).
        joins(:category).where(categories: {slug: params[:subcategory]})

    render '/brand'
  end

  def product
    @product = Product.includes(:brand).find_by_slug!(params[:product])
    @page = Page.get_info(@product)
    render '/product'
  end


  private
  # Initialize vars before brand actions
  def category_brand_init
    @brand    = Brand.find_by_slug!(params[:brand])
    @page     = Page.get_info(@brand)
  end
end
