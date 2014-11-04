PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
  
  get '/register', to: 'users#new'
  #creates named route register_path automatically
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  
  resources :posts, except: [:destroy] do
      resources :comments
  end
  resources :categories, only: [:new, :create, :show]
  resources :users, only: [:show, :create, :edit, :update]

end
