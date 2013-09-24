class BreadcrumbsMaker
  def self.build(current, params, separator="&#160;>&#160;")
    breadcrumbs = Breadcrumb.new params
    breadcrumbs.make_from current
    breadcrumbs.format
    breadcrumbs.join(separator)
    breadcrumbs.breadcrumbs
  end
end