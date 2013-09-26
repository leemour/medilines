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

  def short_text(text, length)
    text = strip_tags text
    if text.length > length
      "#{text[0, length]} &hellip;".html_safe
    else
      text
    end
  end

  def fancybox
    translation = {
      error:    '<p class="fancybox-error">Невозможно подгрузить контент.<br/>Пожалуйста, попробуйте позже.</p>',
      closeBtn: '<a title="Закрыть" class="fancybox-item fancybox-close" href="javascript:;"></a>',
      next:     '<a title="Следующий" class="fancybox-nav fancybox-next" href="javascript:;"><span></span></a>',
      prev:     '<a title="Предыдущий" class="fancybox-nav fancybox-prev" href="javascript:;"><span></span></a>'
    }.to_json
    %|$(function(){
      $(".fancybox").fancybox({
        tpl: #{translation}
      });
    });|
  end

  # def product_img_link(product, show_size, n=nil, link_size=:large)
  #   img = image_tag product.img(n, show_size)
  #   url = product.img(n, link_size)

  #   link_to img, url, class: 'fancybox', :'data-fancybox-group' => product.name
  # end

  def img_link(photo, show_size, link_size)
    img = image_tag photo.url(show_size)
    url = photo.url(link_size)
    link_to img, url, class: 'fancybox', :'data-fancybox-group' => photo.model.name
  end

  # Breadcrumbs for all resources
  def get_breadcrumbs
    current = @product || @brand || @category || @page
    # BreadcrumbsMaker.build current, params
    make_breadcrumbs current
  end

  # Я знаю, что это ужасный код. И ты это знаешь. Прости меня, если сможешь.
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
        return []
    end
    name = defined?(item.name) ? item.name : item.title
    output << link_to(name, url)
    make_breadcrumbs(cons, output)
  end
end
