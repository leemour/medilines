# encoding: UTF-8

module ApplicationHelper
  # require 'breadcrumbs'
  # Generating page title if title exists
  def page_title(page)
    appname = 'Медилайн Сервис'
    page.title ? "#{page.title} - #{appname}" :  appname
  end

  # Defining active menu class
  def is_active?(slug)
    slug.gsub!(/\//, '')
    "active" if params[:page] == slug || params[:category] == slug
  end

  # Defining root category for link_to url_for
  def root_cat(cat)
    cat.split('-')[0]
  end

  def short_text(text, length)
    text = strip_tags text
    if text.length > length
      "#{text[0, length]} &hellip;".html_safe
    else
      text
    end
  end

  def product_img_link(product, n, size)
    link_to image_tag(product.img(n, size)),
      product.img(n, :large), class: 'fancybox', rel: 'group'
  end

  # Breadcrumbs for all resources
  def get_breadcrumbs
    current = @product || @brand || @category || @page
    # BreadcrumbsMaker.build current, params
    make_breadcrumbs current
  end

  def make_breadcrumbs(item = nil, output = [])
    unless item
      output << link_to('Главная', root_path)
      output.first.sub! /<a[^>]+>/, '<span class="last">'
      output.first.sub! /<\/a>/, '</span>'
      output[1..-1].each { |link| link.concat("&#160;>&#160;".html_safe) }
      return output.reverse
    end
    url, cons = case
      when params[:page] && params[:page] != 'home'
        [params[:page], nil]

      when params[:product] && params[:product] == item.slug
        item.brand.category = item.category
        [product_url(item), item.brand]

      when params[:brand] && params[:brand] == item.slug
        category = @category || item.category
        [brand_url(item, category), category]

      when params[:subcategory] && params[:subcategory] == item.slug
        [subcategory_url(item), item.parent]

      when params[:category] && params[:category] == item.slug
        ["/#{params[:category]}", nil]
      else
        return
    end
    name = defined?(item.name) ? item.name : item.title
    output << link_to(name, url)
    make_breadcrumbs(cons, output)
  end
end
