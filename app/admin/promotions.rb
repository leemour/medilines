ActiveAdmin.register Promotion do
  menu :priority => 6

  index do
    selectable_column
    column :slug
    column :title, :sortable => :title do |promo|
      link_to promo.title, admin_promotion_path(promo)
    end
    column :content do |promo|
      promo.content[0..150].html_safe if promo.content
    end

    default_actions
  end

  show :title => :title do |promo|
    panel "Акция #{promo.title}" do
      attributes_table_for promo do
        row :id
        row :slug
        row :title
        row :content do
          promo.content.html_safe if promo.content
        end
        row :created_at
        row :updated_at
      end
    end

    active_admin_comments
  end

  form do |f|
    f.inputs "Описание акции #{f.object.title if f.object.title}" do
      f.input :slug
      f.input :title, :required => true
      f.input :content, :as =>:ckeditor
      f.input :created_at, :wrapper_html => { :class => 'inline-list' }
      f.input :updated_at, :wrapper_html => { :class => 'inline-list' }
    end
    f.actions
  end
end
