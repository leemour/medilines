Medilines::Application.routes.draw do
  #default_url_options :only_path => true

  mount Ckeditor::Engine => '/ckeditor'

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root :to              => 'page#page',
                            :page => 'home'
  get '/promotions'     => 'page#promotions',
      as: :promotions,      :page => 'promotions'
  get '/contacts'       => 'page#contacts',
      as: :contacts,        :page => 'contacts'
  post '/contacts'      => 'page#send_mail',
      as: :send_mail
  get '/contacts/mail-sent' => 'page#page',
                            :page => 'mail-sent'

  scope '/dental-units', :category => 'dental-units' do
    root :to                           => 'main#category',
        as: :dentals
    get ':brand'                       => 'main#category_brand',
        as: :dental_category_brand
    get ':brand/:product'              => 'main#product',
        as: :dental_category_brand_product
  end

  scope '/visual-systems', :category => 'visual-systems' do
    root :to                           => 'main#category',
        as: :visuals
    get ':subcategory'                 => 'main#subcategory',
        as: :visual_category
    get ':subcategory/:brand'          => 'main#category_brand',
        as: :visual_category_brand
    get ':subcategory/:brand/:product' => 'main#product',
        as: :visual_category_brand_product
  end

  scope '/components', :category => 'components' do
    root :to                           => 'main#category',
         as: :components
    get ':subcategory'                 => 'main#subcategory',
        as: :components_category
    get ':subcategory/:brand'          => 'main#category_brand',
        as: :components_category_brand
    get ':subcategory/:brand/:product' => 'main#product',
        as: :components_category_brand_product
  end

  #scope '/spare-parts', :category => 'spare-parts' do
  #  root :to                              => 'main#category',
  #       as: :spares
  #  get ':subcategory'                 => 'main#subcategory',
  #      as: :spare_category
  #  get ':subcategory/:brand'          => 'main#brand',
  #      as: :spare_category_product
  #  get ':subcategory/:brand/:product' => 'main#product',
  #      as: :spare_category_brand_product
  #end

  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'errors#error_404'
  end
end
