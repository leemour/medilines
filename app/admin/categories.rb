# encoding: UTF-8

ActiveAdmin.register Category do
  menu :priority => 4

  index do
    selectable_column
    column :slug
    column :name, :sortable => :name do |cat|
      link_to cat.name, admin_category_path(cat)
    end
    column :description

    default_actions
  end

  filter :name, :label => "Названию"
  filter :slug, :label => "Ссылке"
  filter :created_at, :label => "Cоздана"
  filter :updated_at, :label => "Изменена"

  show :title => :name do |cat|
    panel "Категория #{cat.name}" do
      attributes_table_for cat do
        row :id
        row :slug
        row :name
        row :brands do
          cat.brands.map {|brand| link_to brand.name, admin_brand_path(brand) }.join(', ').html_safe
        end
        row :description
        row :created_at
        row :updated_at
        #row :image do
        #  image_tag(cat.image.url)
        #end
      end
    end

    active_admin_comments
  end

  form do |f|
    f.inputs "Описание категории #{f.object.name if f.object.name}" do
      f.input :slug
      f.input :name
      f.input :brands, :as => :check_boxes, :wrapper_html => { :class => 'inline-list' }
      f.input :description
      f.input :created_at, :wrapper_html => { :class => 'inline-list' }
      f.input :updated_at, :wrapper_html => { :class => 'inline-list' }
    end
    f.actions
  end

  # Has many and belongs to many relationship with brands
  # Adding brand_id and category_id to brands_categories table
  before_save do |category|
    brand_ids = params[:category][:brand_ids][1..-1]
    set_brands = Brand.find(brand_ids) if brand_ids
    set_brands ||= []
    category.brands.destroy_all
    set_brands.each {|brand| category.brands << brand }
  end
end
