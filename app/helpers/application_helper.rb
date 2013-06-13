module ApplicationHelper
  # Generating page title if title exists
  def page_title(page)
    if page.title
      page.title + ' - '
    else
      ''
    end
  end

  # Defining root category for link_to url_for
  def root_cat(cat)
    cat.split('-')[0]
  end

  # Defining active menu class
  def is_active?(slug)
    slug.gsub!(/\//, '')
    "active" if params[:page] == slug || params[:category] == slug
  end
end
