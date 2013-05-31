# encoding: UTF-8

ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      div :class => "blank_slate" do
        #span I18n.t("active_admin.dashboard_welcome.welcome")
        #small I18n.t("active_admin.dashboard_welcome.call_to_action")
        span "Добро пожаловать в Панель Управления компании МедиЛайн Сервис."
        small "Выберите раздел меню наверху, чтобы просмотреть/изменить данные."
      end
    end

    panel "Недавно добавленные товары", :class => "recent-products" do
      table_for Product.recent(5).map do
        column 'Название', :name do |product|
          link_to(product.name, admin_product_path(product))
        end
        column 'Бренд', :brand
        column 'Категория', :category
        column 'Фото', :image do |product|
          image_tag(product.image.url(:thumb)) if product.image.url(:thumb)
        end
        column 'Добавлен', :created_at
      end
      strong { link_to "Все товары", admin_products_path }
    end



    # Here is an example of a simple dashboard with columns and panels.
    #
    #columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Product.recent(5).map do |product|
    #           li link_to(product.name, admin_product_path(product))
    #         end
    #       end
    #     end
    #   end
    #end
    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content


  sidebar "Помощь", :class => "help" do
    "Нужна помощь? Звоните Славе или пишите на leemour@gmail.com"
  end
end
