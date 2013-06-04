Medilines::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  #resources :categories
  #resources :brands
  #resources :products
  
  root :to              => 'application#home'
  get '/contacts'       => 'application#contacts',
      as: :contacts,        :page => :contacts
  get '/promotions'     => 'application#promotions',
      as: :promotions,      :page => :contacts

  get '/dental-units'   => 'application#category',
      as: :dentals,         :category => :'dental-units'
  get '/visual-systems' => 'application#category',
      as: :visuals,         :category => :'visual-systems'
  get '/components'     => 'application#category',
      as: :components,      :category => :components
  get '/spare-parts'    => 'application#category',
      as: :spares,          :category => :spares
  
  get '/dental-units/:brand'             => 'application#brand',
      as: :dental_brand,             :category => :'dental-units'
  get '/visual-systems/:inner_category'        => 'application#category',
      as: :visual_category,          :category => :'visual-systems'
  get '/visual-systems/:inner_category/:product' => 'application#product',
      as: :visual_category_brand,    :category => :'visual-systems'
  get '/components/:inner_category/'           => 'application#category',
      as: :component_category,       :category => :components
  get '/components/:inner_category/:brand'     => 'application#product',
      as: :component_category_brand, :category => :components
  get '/spare-parts/:brand'              => 'application#brand',
      as: :spare_brand,              :category => :spares
  
  get '/dental-units/:brand/:product'   => 'application#product',
      as: :dental_product,    :category => :'dental-units'
  get '/visual-systems/:category/:brand/:product' => 'application#product',
      as: :visual_product,    :category => :'visual-systems'
  get '/visual-systems/:brand/:product' => 'application#product',
      as: :visual_product,    :category => :'visual-systems'
  get '/components/:brand/:product'     => 'application#product',
      as: :component_product, :category => :components
  get '/components/:brand/:category/:product'     => 'application#product',
      as: :component_product, :category => :components
  get '/spare-parts/:brand/:product'    => 'application#product',
      as: :spare_product,     :category => :spares

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'

  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'errors#error_404'
  end
end
