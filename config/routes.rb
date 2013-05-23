MediMongo::Application.routes.draw do
  resources :products
  
  root :to => 'application#home'
  get '/contacts'       => 'application#contacts', as: :contacts
  
  get '/dental-units'   => 'application#category', as: :dentals,    product_type: :dentals
  get '/visual-systems' => 'application#category', as: :visuals,    product_type: :visuals
  get '/components'     => 'application#category', as: :components, product_type: :components
  get '/spare-parts'    => 'application#category', as: :spares,     product_type: :spares
  
  get '/dental-units/:brand'   => 'application#brand', as: :dental_brand,    product_type: :dentals
  get '/visual-systems/:brand' => 'application#brand', as: :visual_brand,    product_type: :visuals
  get '/components/:brand'     => 'application#brand', as: :component_brand, product_type: :components
  get '/spare-parts/:brand'    => 'application#brand', as: :spare_brand,     product_type: :spares
  
  get '/dental-units/:brand/:product'   => 'application#product', as: :dental_product,    product_type: :dentals
  get '/visual-systems/:brand/:product' => 'application#product', as: :visual_product,    product_type: :visuals
  get '/components/:brand/:product'     => 'application#product', as: :component_product, product_type: :components
  get '/spare-parts/:brand/:product'    => 'application#product', as: :spare_product,     product_type: :spares
  
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
end
