# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.medilines.ru"

SitemapGenerator::Sitemap.create do
  extend UrlHelper
  extend ApplicationHelper
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
  add contacts_path,   :priority => 0.6, :changefreq => 'yearly'
  add promotions_path, :priority => 0.6, :changefreq => 'weekly'
  add '/docs/MediLines_Catalog_2013.pdf', :priority => 0.6,
      :changefreq => 'yearly'

  Category.find_each do |cat|
    next if cat.slug == 'spare-parts'
    add sitemap_category_url(cat), :priority => 0.6,
        :changefreq => 'monthly'
  end

  Brand.joins(:categories).uniq.each do |brand|
    brand.categories.uniq.each do |cat|
      add sitemap_brand_url(brand, cat), :priority => 0.6,
          :changefreq => 'monthly'
    end
  end

  Product.includes(:category, :brand).find_each do |product|
    add sitemap_product_url(product), :priority => 0.6,
        :changefreq => 'monthly'
  end
end
