Rails.application.routes.draw do

  # This line mounts Spree's routes at the root of your application.
  # This means, any requests to URLs such as /products, will go to Spree::ProductsController.
  # If you would like to change where this engine is mounted, simply change the :at option to something different.
  #
  # We ask that you don't use the :as option here, as Spree relies on it being the default of "spree"
  mount Spree::Core::Engine, at: '/'
          # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

Spree::Core::Engine.add_routes do
  get '/pages/*id' => 'pages#show', as: :page, format: false

  resources :users, only: [:edit, :update] do
    put :confirm_location, on: :collection
    get :change_location, on: :collection
    put :reset_location, on: :collection
    put :follow_service, on: :collection
    put :unfollow_service, on: :collection
    get :edit_location, on: :collection
    get :services, on: :collection
    post :set_location, on: :collection
    get :show_map, on: :collection
    post :set_address, on: :collection
    resources :user_feedbacks, only: :create
    put :paying_for_subscription, on: :collection
    get :pay_for_subscription, on: :collection
    get :my_services, on: :collection
  end

  resources :contact_requests, only: [:new, :create]

  resources :products, only: [] do
    get :available_time_for_day, on: :member

    resources :follow_services, only: [:create, :destroy]
  end

  resources :notification_requests, only: [:create]

  namespace :admin, path: Spree.admin_path do
    resources :subscribe_requests, except: [:edit, :destroy] do
      put :change_state, on: :member
    end

    resources :user_feedbacks, only: [:index, :show] do
      put :change_state, on: :member
    end

    resources :line_items, only: [] do
      put :change_state, on: :member
    end

    resources :contact_requests, only: [:index, :show]
  end

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV["SIDEKIQ_USERNAME"] && password == ENV["SIDEKIQ_PASSWORD"]
  end unless Rails.env.development?

  mount Sidekiq::Web => '/sidekiq'
end
