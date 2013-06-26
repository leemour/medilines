module UrlHelper

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

  # Host for url_for in SitemapGenerator
  def default_url_options
    if Rails.env.production?
      { :host => "www.medilines.ru" }
    else
      { :host => "www.medilines.ru" }
    end
  end

  # URL With parameters - Used in Sitemap Generator
  def sitemap_product_url(product)
    if product.category.is_root?
      category = product.category
      subcategory = 'category'
    else
      category = product.category.parent
      subcategory = product.category
    end
    url_for([root_cat(category.slug), subcategory, product.brand, product]).
      sub('http://' + default_url_options[:host], '')
  end

  def sitemap_brand_url(brand, category)
    if category.is_root?
      subcategory = 'category'
    else
      subcategory = category
      category = category.parent
    end
    url_for([root_cat(category.slug), subcategory, brand]).
      sub('http://' + default_url_options[:host], '')
  end

  def sitemap_category_url(category)
    if category.is_root?
      slug = root_cat(category.slug)
      slug.chomp!('s')
      url = url_for(["#{slug}s"])
    else
      subcategory = category
      category = category.parent
      url = url_for([root_cat(category.slug), subcategory])
    end
    url.sub('http://' + default_url_options[:host], '')
  end

end
