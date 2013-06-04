module ApplicationHelper
  def page_title(page)
    if page.title
      page.title + ' - '
    else
      ''
    end
  end
end
