module ActiveAdmin::ViewsHelper #camelized file name
  def img_with_url(form, name)
    if form.object.send(name).url
      "<span class='img-url'>#{form.object.send(name).url}</span>
      #{form.template.image_tag(form.object.send(name).url)}".html_safe
    end
  end
end