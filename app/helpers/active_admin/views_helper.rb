module ActiveAdmin::ViewsHelper #camelized file name

  def img_with_url(form, n = nil)
    if form.object.img(n)
      image = form.template.image_tag(form.object.img n)
      html  = content_tag :span, form.object.img(n), class: 'img-url'
      html += link_to image, form.object.img(n)
      html
    end
  end

  def parent_category(cat)
    if cat.parent
      parent = cat.parent_id.to_s + ' (' +
          (link_to cat.parent.name, admin_category_path(cat.parent)) +
      ')'
      parent.html_safe
    end
  end

end