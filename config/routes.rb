PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
  
  get '/register', to: 'users#new'
  #creates named route register_path automatically
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  
resources :posts, except: [:destroy] do
    
    member do
      post 'vote'  #/posts/3/vote
    end
    
    collection do
      get 'archives'  #/posts/archives
    end
  
  resources :comments do
      member do
        post 'vote'  
      end
end
  
 end
  resources :categories, only: [:new, :create, :show]
  resources :users, only: [:show, :create, :edit, :update]
  
end

#POST /votes => votes#create

#POST /posts/3/vote => posts#vote
#POST /posts/3/comments/3/vote => comments#vote
