Backchannel::Application.routes.draw do
  match '/whovotedpost' => "users#whovotedpost", :via => :get
  match '/whovotedcomment' => "users#whovotedcomment", :via=> :get
  match '/admin_page'  => "admins#index", :via=> :get
  match '/admin/reports' => "admins#reports" ,:via => :get
  match '/voteforpost/incrementVote' => "posts#incrementVote", :via => :get
  match '/voteforcomment/incrementVote' => "comments#incrementVote", :via => :get
  match "/commentsforpost/new" => "comments#new" ,:via => :get
  match "/users/search" => "users#search"
  match "/posts/search" => "posts#search"
  match "/categories/search" => "categories#search"
  resources :comment_votes

  resources :votes

  match "/posts/new" => "posts#new"
  match "/posts/index" => "posts#index"
  match "/logins/new"   =>"logins#new"
  match "logout" => "logins#logoutUser"
  match "/users/new" => "users#new"
  match "users/show" => "users#show"
  #match ':users(/:logins)'
  #match '/logins' => 'posts#index'  , :via => :post
  resources :posts
  resources :admins
  resources :users
  match 'loginUser' => 'logins#loginUser'  , :via => :post
  resources :logins
  resources :comments
  resources :categories
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
  root :to => 'logins#new'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
