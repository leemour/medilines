# encoding: utf-8

module ActiveAdmin::ViewsHelper #camelized file name

  def img_with_url(photo, show_size=:small)
    image = image_tag(photo.url(show_size))
    html  = content_tag :span, photo.url, class: 'img-url'
    html += link_to image, photo.url, class: 'img-img fancybox',
      :'data-fancybox-group' => photo.model.name
  end

  def parent_category(cat)
    if cat.parent
      parent = cat.parent_id.to_s + ' (' +
          (link_to cat.parent.name, admin_category_path(cat.parent)) +
      ')'
      parent.html_safe
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
end