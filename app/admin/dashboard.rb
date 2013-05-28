# encoding: UTF-8
ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      span :class => "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    panel "Недавно добавленные товары" do
      table_for Product.recent(5).map do
        column 'Название', :name do |product|
          link_to(product.name, admin_product_path(product))
        end
        column 'Добавлен', :created_at
      end
      strong { link_to "View All Products", admin_products_path }
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
end
