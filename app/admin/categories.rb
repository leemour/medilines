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

  form do |f|
    f.inputs "Описание категории" do
      f.input :slug
      f.input :name
      f.input :description
      f.input :created_at, :wrapper_html => { :class => 'inline-list' }
      f.input :updated_at, :wrapper_html => { :class => 'inline-list' }
    end
    f.actions
  end
end
