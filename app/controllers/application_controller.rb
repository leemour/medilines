#encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def home
    #raise 'error'
    @page = Page.home

    render '/home'
  end
  
  def contacts
    @page = Page.contacts

    render '/contacts'
  end

  def promotions
    @page = Page.promotions

    render '/promotions'
  end
  
  def category
    @category = Category.find_by_slug!(params[:category])
    @page = Page.get_info(@category)
    @subcategories = Category.find_children(@category)

    if @subcategories.empty?
      @brands = Brand.find_all_in_category(@category)
      render "/categories/category_with_brands"
    else
      render "/categories/category_with_categories"
    end
  end

  def inner_category
    @category = Category.find_by_slug!(params[:inner_category])
    @page = Page.get_info(@category)

    if @category.products.count > 1
      @brands = Brand.find_all_in_category(@category)
      render "/categories/category_with_brands"
    else
      @products = @category.products.includes(:brand)
      render "/categories/category_with_products"
    end
  end
  
  def brand
    @brand = Brand.find_by_slug!(params[:brand])
    @page = Page.get_info(@brand)
    @products = Product.joins(:brand).where(:brands => {:slug => params[:brand]}).
      joins(:category).where(categories: {slug: params[:category]})

    render '/brand'
  end
  
  def product
    @product = Product.includes(:brand).find_by_slug!(params[:product])
    @page = Page.get_info(@product)

    render '/product'
  end

  # Handling Errors
  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: lambda { |exception| render_error 500, exception }
    rescue_from ActionController::RoutingError, ActionController::UnknownController,
                ::AbstractController::ActionNotFound, ActiveRecord::RecordNotFound,
                with: lambda { |exception| render_error 404, exception }
  end

  private
  def render_error(status, exception)
    respond_to do |format|
      format.html { render template: "errors/error_#{status}",
                           layout: 'layouts/application', status: status }
      format.all { render nothing: true, status: status }
    end
  end
end
