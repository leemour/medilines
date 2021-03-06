ActiveAdmin.register Page do
  menu :priority => 5

  index do
    selectable_column
    column :slug
    column :title, :sortable => :title do |page|
      link_to page.title, admin_page_path(page)
    end
    column :intro do |page|
      page.intro[0..150].html_safe if page.intro
    end
    column :content do |page|
      page.content[0..150].html_safe if page.content
    end

    default_actions
  end

  filter :title, :label => "Названию"
  filter :slug, :label => "Ссылке"
  filter :created_at, :label => "Cоздана"
  filter :updated_at, :label => "Изменена"

  show :title => :title do |page|
    panel "Страница #{page.title}" do
      attributes_table_for page do
        row :id
        row :slug
        row :title
        row :status do
          page.status_ru
        end
        row :intro do
          page.intro.html_safe if page.intro
        end
        row :content do
          page.content.html_safe if page.content
        end
        row :created_at
        row :updated_at
      end
    end

    active_admin_comments
  end

  form do |f|
    f.inputs "Описание страницы #{f.object.title if f.object.title}" do
      f.input :slug
      f.input :title, :required => true
      f.input :status, :as => :select, :collection =>
        f.object.class.statuses.map { |name, translation| [translation, name] }

      f.input :intro,   :as =>:ckeditor
      f.input :content, :as =>:ckeditor
      f.input :created_at, :wrapper_html => { :class => 'inline-list' }
      f.input :updated_at, :wrapper_html => { :class => 'inline-list' }
    end
    f.actions
  end
end
