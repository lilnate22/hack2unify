Af::Application.routes.draw do

  resources :project_memberships

  get "home/index"

  #match "/auth/:provider/callback" => "sessions#create"
  get '/auth/twitter/callback', :to => 'sessions#create', :as => 'callback'
  get '/auth/failure', :to => 'sessions#error', :as => 'failure'
  get '/profile', :to => 'sessions#show', :as => 'show'
  delete '/signout', :to => 'sessions#destroy', :as => 'signout'



  match "/signout" => "sessions#destroy", :as => :signout
  resources :projects do
    member do
      post :vote_up, :vote_down#, :flag
      post :join, :leave
    end
  end
  resources :activities do
    member do
      post :vote_up, :vote_down#, :flag
    end
  end
  resources :actors, :only => [:show, :update]
  resources :incentives do
    member do
      put :claim, :validate
      post :vote_up, :vote_down#, :flag
    end
  end

  get "/phillystartup" => "incentives#index"

  #resources :activities, :only => [:show] #or should this work but specify :controller => "projects/activities" ?

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller activities automatically):
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
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all activities in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
