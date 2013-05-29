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
    column :slogan
    column :description do |brand|
      brand.description[0..60]
    end
    column :details do |brand|
      brand.details[0..100].html_safe
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

  form(:html => { :multipart => true }) do |f|
    f.inputs "Описание бренда" do
      f.input :slug, :hint => "Генерируется автоматически", :required => false
      f.input :name, :required => true
      f.input :country, as: :string, :required => true
      f.input :logo
      f.input :image
      f.input :flag
      f.input :slogan
      f.input :description, :required => true
      f.input :details
      f.input :created_at, :wrapper_html => { :class => 'inline-list' }
      f.input :updated_at, :wrapper_html => { :class => 'inline-list' }

      f.actions
    end
  end
end