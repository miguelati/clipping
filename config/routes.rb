Clippping::Application.routes.draw do
	
  resources :categories do
    post 'by_entity', on: :collection
  end
	
  resources :shippings do
		post 'check_source_url', on: :collection
		post 'news_template', on: :collection
		post 'send_mails/:shipping_id', action: 'send_mails', as: 'send_mails', on: :collection
		post 'send_demo/:shipping_id', action: 'send_demo', as: 'send_demo', on: :collection
		get 'new/:entity_id', action: 'new', as: 'new_with_entity', on: :collection
  end
  
  devise_for :users, :path => "auth", :path_names => { :sign_in => 'iniciar_sesion', :sign_out => 'cerrar_sesion', :password => 'secret', :confirmation => 'verificar' }
	
	resources :users
	resources :entities
	resources :receivers

  root :to => "home#index"
	
	
	constraint = lambda { |request| request.env["warden"].authenticate? and request.env['warden'].user.is_admin? }
	constraints constraint do
		require 'sidekiq/web'
	  mount Sidekiq::Web => '/sidekiq'
	end

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
