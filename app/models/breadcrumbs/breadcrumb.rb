# encoding: utf-8

class Breadcrumb
  include ActionView::Helpers
  include Rails.application.routes.url_helpers
  include ::UrlHelper

  attr_reader :breadcrumbs

  def initialize(params)
    @breadcrumbs = []
    @params = params
  end

  def make_from(item)
    return [] unless item
    crumb = Crumb.new(item, params)
    url, cons = get_info(crumb, item)
    @breadcrumbs << link_to(crumb.name, url)
    make_from cons
  end

  def format
    add_root
    @breadcrumbs.reverse!
    deactivate_current_page
  end

  def join(separator)
    @breadcrumbs.join(separator.html_safe)
  end


  private

  attr_reader :params

  def get_info(crumb, item)
    case
    when crumb.page? && !crumb.home?
      [params[:page], nil]

    when crumb.product?
      item.brand.category = item.category
      [product_url(item), item.brand]

    when crumb.brand?
      category = params[:category] || item.category
      [brand_url(item, category), category]

    when crumb.subcategory?
      [subcategory_url(item), item.parent,]

    when crumb.category?
      ["/#{params[:category]}", nil]
    end
  end

  def add_root
    @breadcrumbs << link_to('Главная', root_path)
  end

  def deactivate_current_page
    @breadcrumbs.last.sub! /<a[^>]+>/, '<span class="last">'
    @breadcrumbs.last.sub! /<\/a>/, '</span>'
  end
end

