module ApplicationHelper
  def page_title(page)
    if page.title
      page.title + ' - '
    else
      ''
    end
  end

  def root_cat(cat)
    cat.split('-')[0]
  end
end
