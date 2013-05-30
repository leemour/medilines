# encoding: UTF-8
ActiveAdmin.register Product do
  scope "Стоматолог. кресла", :dentals
  scope "Визуализация", :visuals
  scope "Компоненты", :components
  scope "Запчасти", :spares

  menu :priority => 2
  #belongs_to :category
  #navigation_menu :product
  #belongs_to :brand

  index do
    selectable_column
    column :slug
    column :name, :sortable => :name do |product|
      link_to product.name, admin_product_path(product)
    end
    column :brand_id, :sortable => :brand_id do |product|
      product.brand.name
    end
    column :category_id, :sortable => :category_id do |product|
       product.category.name
    end
    column :image do |product|
       image_tag(product.image_url(:thumb).to_s) if product.image_url
    end
    column :type
    column :price do |product|
      number_to_currency product.price, :unit => "р", :precision => 0
    end
    #column :options
    #column :features
    #column :design
    #column :description
    #column :slogan

    default_actions
  end

  filter :category, :as => :select, :collection => proc { Category.all }
  filter :brand, :as => :select, :collection => proc { Brand.all }
  filter :name, :label => "Названию"
  filter :slug, :label => "Ссылке"
  filter :created_at
  filter :updated_at


  form(:html => { :multipart => true }) do |f|
    f.inputs "Описание товара #{f.object.name if f.object.name}" do
      f.input :slug, :hint => "Генерируется автоматически", :required => false
      f.input :name, :required => true
      f.input :brand
      f.input :category
      f.input :image, :hint => img_with_url(f, :image)
      f.input :image_cache, :as => :hidden
      f.input :type
      f.input :price
      f.input :slogan
      f.input :options
      f.input :features
      f.input :design
      f.input :description
      f.input :created_at, :wrapper_html => { :class => 'inline-list' }
      f.input :updated_at, :wrapper_html => { :class => 'inline-list' }

      f.actions
    end
  end
end
