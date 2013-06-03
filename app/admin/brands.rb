# encoding: UTF-8

ActiveAdmin.register Brand do
  menu :priority => 3

  index do
    selectable_column
    column :slug
    column :name, :sortable => :name do |brand|
      link_to brand.name, admin_brand_path(brand)
    end
    column :country
    column :description do |brand|
      brand.description[0..60]
    end
    column :flag do |brand|
      image_tag(brand.flag_url.to_s) if brand.flag?
    end
    column :logo do |brand|
      image_tag(brand.logo_url(:thumb).to_s) if brand.logo?
    end
    column :image do |brand|
      image_tag(brand.image_url(:thumb).to_s) if brand.image?
    end

    default_actions
  end

  filter :name, :label => "Названию"
  filter :slug, :label => "Ссылке"
  filter :country, :label => "Стране"
  filter :created_at
  filter :updated_at


  show :title => :name do |brand|
    panel "Бренд #{brand.name}" do
      attributes_table_for brand do
        row :id
        row :slug
        row :name
        row :country
        row :flag do
          image_tag(brand.flag.url) if brand.flag.url
        end
        row :image do
          image_tag(brand.image.url) if brand.image.url
        end
        row :logo do
          image_tag(brand.logo.url) if brand.logo.url
        end
        row :slogan
        row :description
        row :details do
          brand.details.html_safe
        end
        row :created_at
        row :updated_at
      end
    end

    active_admin_comments
  end
  

  form(:html => { :multipart => true }) do |f|
    f.inputs "Описание бренда #{f.object.name if f.object.name}" do
      f.input :slug, :hint => "Генерируется автоматически", :required => false
      f.input :name, :required => true
      f.input :country, as: :string, :required => true
      f.input :flag, :hint => img_with_url(f, :flag)
      f.input :flag_cache, :as => :hidden
      f.input :image, :hint => img_with_url(f, :image)
      f.input :image_cache, :as => :hidden
      f.input :logo, :hint => img_with_url(f, :logo)
      f.input :logo_cache, :as => :hidden
      f.input :slogan
      f.input :description, :required => true
      f.input :details, :as =>:ckeditor
      f.input :created_at, :wrapper_html => { :class => 'inline-list' }
      f.input :updated_at, :wrapper_html => { :class => 'inline-list' }

      f.actions
    end
  end
end