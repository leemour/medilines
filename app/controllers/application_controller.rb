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

  def promotion
    @page = Page.promotion

    render '/contacts'
  end
  
  def category
    @category = Category.find_by_slug(params[:product_type])
    @page = Page.get_info(@category)

    @categories = Category.find_children(@category)
    if not @categories.empty?
      render "/categories/category_with_categories"
    elsif @category.products.count > 1
      @brands = Brand.find_all_in_category(@category)
      render "/categories/category_with_brands"
    else
      @products = @category.products
      render "/categories/category_with_products"
    end
  end
  
  def brand
    @products = Product.joins(:brand).where(:brands => {:slug => params[:brand]}).
      joins(:category).where(categories: {slug: params[:product_type]})

    render '/brand'
  end
  
  def product
    @product = Product.where(type: params[:product_type], brand: params[:brand],
                             title: params[:product])
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
