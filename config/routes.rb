Rails.application.routes.draw do
  get 'teams/index'

  get 'teams/new'

  get 'teams/edit'

  get 'teams/show'

  get 'players/new'

  get 'session/new'

  get 'users/new'

  root             'static_pages#home'
  get 'help'    => 'static_pages#help'
  get 'about'   => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'standings' => 'static_pages#standings'
  get 'bet-standings', to: 'static_pages#bets_standings', as: 'bet_standings'
  
  get 'signup'  => 'users#new'
  get 'players_new'  => 'players#new'
  get 'teams_new'  => 'teams#new'
  
  get '/users/:id/edit_admin_role', to: 'users#edit_admin_role', as: 'edit_admin_role_user'
  
  get '/players/:player_id/predictions/new', to: 'predictions#new', as: 'add_prediction_to_player'
  
  get '/players/:player_id/predictions', to: 'players#predictions', as: 'player_predictions'
  get '/players/:player_id/bets', to: 'players#bets', as: 'player_bets'
  
  get 'teams/standings', to: 'teams#standings', as: 'teams_standings'
  
  
  post 'teams/update_standings_ajax', to: 'teams#update_standings_ajax'
  post 'update_all_standings', to: 'static_pages#update_all_standings_ajax'

  
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  resources :users
  resources :players
  resources :teams
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
  resources :predictions

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

 

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
