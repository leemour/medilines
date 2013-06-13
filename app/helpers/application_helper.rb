# encoding: UTF-8

module ApplicationHelper
  # Generating page title if title exists
  def page_title(page)
    if page.title
      page.title + ' - '
    else
      ''
    end
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

  def product_url(product)
    if product.category.slug == params[:category]
      category = 'category'
    else
      category = product.category
    end
    url_for([root_cat(params[:category]), category, product.brand, product])
  end

  def brand_url(brand, category)
    category = 'category' if category.slug == params[:category]
    url_for([root_cat(params[:category]), category, brand])
  end

  def subcategory_url(cat)
    url_for([root_cat(params[:category]), cat])
  end

  # Breadcrumbs for all resources
  def get_breadcrumbs
    crumbs = @product || @brand || @category || @page
    make_breadcrumbs(crumbs)
  end

  def make_breadcrumbs(item = nil, output = [])
    unless item
      output << link_to('Главная', root_path)
      output.first.sub! /<a[^>]+>/, '<span class="last">'
      output.first.sub! /<\/a>/, '</span>'
      output[1..-1].each { |link| link.concat("&#160;>&#160;".html_safe) }
      return output.reverse
    end

    if params[:page]
      unless params[:page] == 'home'
        output << link_to(item.title, params[:page])
        make_breadcrumbs(nil, output)
      end

    elsif params[:product] && params[:product] == item.slug
      output << link_to(item.name, product_url(item))
      item.brand.category = item.category
      make_breadcrumbs(item.brand, output)

    elsif params[:brand] && params[:brand] == item.slug
      category = @category || item.category
      output << link_to(item.name, brand_url(item, category))
      make_breadcrumbs(category, output)

    elsif params[:subcategory] && params[:subcategory] == item.slug
      output << link_to(item.name, subcategory_url(item))
      make_breadcrumbs(item.parent, output)

    elsif params[:category] && params[:category] == item.slug
      output << link_to(item.name, '/' + params[:category])
      make_breadcrumbs(nil, output)

    end
  end
end
