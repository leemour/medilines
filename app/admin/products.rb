# encoding: utf-8
ActiveAdmin.register Product do
  menu :priority => 2

  scope "Стоматолог. кресла", :dentals
  scope "Визуализация",       :visuals
  scope "Компоненты",         :components
  scope "Запчасти",           :spares
  scope "Все",                :all

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
    column :description1 do |product|
      product.description1[0..60].html_safe
    end
    column :price do |product|
      number_to_currency product.price, :unit => "р", :precision => 0
    end

    default_actions
  end

  filter :category, :as => :select, :collection => proc { Category.all }
  filter :brand, :as => :select, :collection => proc { Brand.all }
  filter :name, :label => "Названию"
  filter :slug, :label => "Ссылке"
  filter :created_at
  filter :updated_at


  show :title => :name do |product|
    panel "Товар #{product.name}" do
      attributes_table_for product do
        row :id
        row :slug
        row :name
        row :brand
        row :category
        row :image do
          img_link(product.image, :large, :full) if product.image
        end
        row :price
        row :slogan
        row :features do
          product.features.html_safe
        end
        row :description1 do
          product.description1.html_safe if product.description1
        end
        row :description2 do
          product.description2.html_safe if product.description2
        end
        product.photos.each.with_index(1) do |photo, i|
          row :"photo#{i}" do
            img_link(photo, :medium, :large) if photo
          end
        end
        row :created_at
        row :updated_at
        render partial: 'fancybox'
      end
    end

    active_admin_comments
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs "Описание товара #{f.object.name if f.object.name}" do
      f.input :slug, :hint => "Генерируется автоматически", :required => false
      f.input :name, :required => true
      f.input :brand
      f.input :category
      f.input :image, :hint => img_with_url(f.object.image, :large), :as => 'uploader',
              :removable => true
      f.input :slogan
      f.input :features,     :as =>:ckeditor
      f.input :description1, :as =>:ckeditor
      f.input :description2, :as => :ckeditor,
              :input_html => { :ckeditor => { :height => 200 }}

      f.object.photos.each.with_index(1) do |photo, i|
        f.input :"photo#{i}", :hint => img_with_url(photo, :medium),
                :as => :uploader, :removable => true
      end
      f.input :created_at, :wrapper_html => { :class => 'inline-list' }
      f.input :updated_at, :wrapper_html => { :class => 'inline-list' }

      f.actions
    end
    f.inputs do
      f.template.render partial: 'fancybox'
    end
  end
end
