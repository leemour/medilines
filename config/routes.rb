Medilines::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  #resources :categories
  #resources :brands
  #resources :products
  
  root :to              => 'application#page',
                            :page => 'home'
  get '/contacts'       => 'application#contacts',
      as: :contacts,        :page => 'contacts'
  get '/promotions'     => 'application#page',
      as: :promotions,      :page => 'promotions'

  post '/contacts'      => 'application#send_mail',
      as: :send_mail
  get '/contacts/mail-sent' => 'application#page',
                            :page => 'mail-sent'

  scope '/dental-units', :category => 'dental-units' do
    root :to                           => 'application#category',
        as: :dentals
    get ':brand'                       => 'application#category_brand',
        as: :dental_category_brand
    get ':brand/:product'              => 'application#product',
        as: :dental_category_brand_product
  end

  scope '/visual-systems', :category => 'visual-systems' do
    root :to                           => 'application#category',
        as: :visuals
    get ':subcategory'                 => 'application#subcategory',
        as: :visual_category
    get ':subcategory/:brand'          => 'application#subcategory_brand',
        as: :visual_category_brand
    get ':subcategory/:brand/:product' => 'application#product',
        as: :visual_category_brand_product
  end

  scope '/components', :category => 'components' do
    root :to                           => 'application#category',
         as: :components
    get ':subcategory'                 => 'application#subcategory',
        as: :components_category
    get ':subcategory/:brand'          => 'application#subcategory_brand',
        as: :components_category_brand
    get ':subcategory/:brand/:product' => 'application#product',
        as: :components_category_brand_product
  end

  #scope '/spare-parts', :category => 'spare-parts' do
  #  root :to                              => 'application#category',
  #       as: :spares
  #  get ':subcategory'                 => 'application#subcategory',
  #      as: :spare_category
  #  get ':subcategory/:brand'          => 'application#brand',
  #      as: :spare_category_product
  #  get ':subcategory/:brand/:product' => 'application#product',
  #      as: :spare_category_brand_product
  #end



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
