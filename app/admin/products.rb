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
       image_tag(product.image_url(:thumb).to_s)
    end
    column :type
    column :price
    #column :options
    #column :features
    #column :design
    column :description
    #column :slogan

    default_actions
  end

  filter :category, :as => :select, :collection => proc { Category.all }
  filter :brand, :as => :select, :collection => proc { Brand.all }
  filter :name, :label => "Названию"
  filter :slug, :label => "Ссылке"
  filter :created_at
  filter :updated_at


  #form do |f|
  #  f.inputs "Admin Details" do
  #    f.input :email
  #    f.input :password
  #    f.input :password_confirmation
  #  end
  #  f.actions
  #end
end
