# encoding: UTF-8

module NavigationHelper

  def nav_item(name, path, inactive = false)
    NavItem.new(params, name, path, inactive).render
  end

  class NavItem
    include ActionView::Helpers
    # include Rails.application.routes.url_helpers
    include Haml::Helpers

    def initialize(params, name, path, inactive)
      init_haml_helpers
      @params   = params
      @name     = name
      @path     = path
      @inactive = inactive
    end

    def render
      capture_haml do
        haml_tag :li, item_class do
           haml_concat link
        end
      end
    end

    private

    def item_class
      klass = {class: 'active'}   if active?
      klass = {class: 'inactive'} if @inactive
      klass || {}
    end

    def link
      @inactive ? @name : link_to(@name, @path)
    end

    # Class of the current page
    def active?
      slug = @path.gsub /\//, ''
      @params[:page] == slug || @params[:category] == slug
    end
  end
end