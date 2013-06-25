# encoding: UTF-8

ActiveAdmin.register Category do
  menu :priority => 4

  scope "Корневые",           :roots
  scope "Стоматолог. уст.",   :dentals
  scope "Визуализация",       :visuals
  scope "Компоненты",         :components
  scope "Запчасти",           :spares
  scope "Все",                :all

  index do
    selectable_column
    column :slug
    column :name, :sortable => :name do |cat|
      link_to cat.name, admin_category_path(cat)
    end
    column :parent_id, :sortabe => :parent_id do |cat|
      link_to cat.parent.name, admin_category_path(cat.parent) if cat.parent
    end
    column :logo do |cat|
      image_tag(cat.logo_url(:thumb))
    end
    column :description

    default_actions
  end

  filter :name, :label => "Названию"
  filter :slug, :label => "Ссылке"
  filter :parent, :as => :select, :label => "Искать по Родительской",
         #:collection => Category.all(:conditions => "parent_id IS NULL OR parent_id = ''")
         :collection => Category.joins("JOIN categories as cat2 ON cat2.parent_id = categories.id").uniq
  filter :created_at, :label => "Cоздана"
  filter :updated_at, :label => "Изменена"

  show :title => :name do |cat|
    panel "Категория #{cat.name}" do
      attributes_table_for cat do
        row :id
        row :slug
        row :name
        row :parent_id do
          parent_category(cat)
        end
        row :logo do
          image_tag(cat.logo_url) if cat.logo.url
        end
        row :description
        row :created_at
        row :updated_at
      end
    end

    active_admin_comments
  end

  form do |f|
    f.inputs "Описание категории #{f.object.name if f.object.name}" do
      f.input :slug
      f.input :name
      if f.object.name
        f.input :parent, :collection => Category.all(:conditions => ["id != ?", f.object.id])
      else
        f.input :parent
      end
      f.input :logo, :hint => img_with_url(f, :logo)
      f.input :logo_cache, :as => :hidden
      f.input :description
      f.input :created_at, :wrapper_html => { :class => 'inline-list' }
      f.input :updated_at, :wrapper_html => { :class => 'inline-list' }
    end
    f.actions
  end

  # Has many and belongs to many relationship with brands
  # Adding brand_id and category_id to brands_categories table
  #before_save do |category|
    #brand_ids = params[:category][:brand_ids][1..-1]
    #set_brands = Brand.find(brand_ids) if brand_ids
    #set_brands ||= []
    #category.brands.destroy_all
    #set_brands.each {|brand| category.brands << brand }
    #category.parent_id = params[:category][:parent_id]
  #end
end
