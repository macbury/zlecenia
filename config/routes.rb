ActionController::Routing::Routes.draw do |map|

	map.with_options :controller => 'offers', :action => 'index' do |offer| 
		offer.connect '/:type/:page', :requirements => { :type => /(programowanie|administrowanie|wyglad)/i, :page => /\d/ }
		offer.seo_offers '/:type.:format', :requirements => { :type => /(programowanie|administrowanie|wyglad)/i }
		offer.connets '/tags/:tags/:page'
		offer.tags '/tags/:tags'
	end
	
	map.resources :offers, :collection => { :suggest_tag => :any, :my => :get } do |offers|
		offers.resources :contacts
	end
	
	map.resources :achievements
  map.resources :user_sessions
  map.resources :users
	
  map.login '/logowanie', :controller => 'user_sessions', :action => 'new'
  map.logout '/wyloguj', :controller => 'user_sessions', :action => 'destroy'
  map.register '/rejestruj', :controller => 'users', :action => 'new'
	map.settings '/ustawienia', :controller => 'users', :action => 'settings'
	map.facebook_profile '/facebook_profile', :controller => 'users', :action => 'profile'
	map.need_account '/need_account', :controller => 'users', :action => 'need_account'
	map.expire_facebook '/expire', :controller => 'users', :action => "expire" 
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.


	map.root :controller => "offers"
	map.seo_offer '/:id', :controller => 'offers', :action => 'show'
  
  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
