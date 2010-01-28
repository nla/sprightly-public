ActionController::Routing::Routes.draw do |map|
  map.connect 'rightsholders/search', :controller => 'rightsholders', :action => 'search'
  
  map.resources :usersession
  map.resources :works
  map.resources :rightsholders
  map.resources :trim
  map.resources :librarydecision
  map.resources :contact
  map.resources :note
  map.resources :agreement
  map.resources :roles
  map.resources :wizard
  map.resources :admin
  map.resources :report
  map.resources :diagnostics


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
  map.root :controller => "search", :action => 'index'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.

  # Hackerish handling of nla.xxx id's
  # In order to handle id = nla.pic-vn12345.1 The id is split into three:
  # * :id = nla
  # * :format = pic-vn12345
  # * :extra = 1
  # Rails likes to have a . to separate the id and the format. The format is used for printing
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id.:format.:extra'
end
