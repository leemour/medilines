module ActiveAdmin::ViewsHelper #camelized file name

  def img_with_url(form, name)
    if form.object.send(name).url
      "<span class='img-url'>#{form.object.send(name).url}</span>
      #{form.template.image_tag(form.object.send(name).url)}".html_safe
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