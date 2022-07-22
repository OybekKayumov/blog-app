Rails.application.routes.draw do
  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: { sessions: :sessions },
                       path_names: { sign_in: :login }
    resource :user, only: [:show, :update]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # root "users#index"
  root to: "users#index"

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:create, :destroy]
      resources :likes, only: [:create]
    end   
  end

  post '/users/:user_id/posts', to: 'posts#create', as: 'create_user_post'
  post '/users/:user_id/posts/:id/likes', to: 'likes#create', as: 'create_post_like'
  get '/posts/:post_id/comments/new', to: 'comments#new', as: 'new_post_comment'
  post '/posts/:post_id/comments', to: 'comments#create', as: 'create_post_comment'

  # API Routes
  get '/api/v1/users/:user_id/posts/', to: 'api/v1/posts#index', as: 'api_user_posts'
  get '/api/v1/users/:user_id/posts/:post_id/comments', to: 'api/v1/comments#index', as: 'api_posts_comments'
  post '/api/v1/users/:user_id/posts/:post_id/comments', to: 'api/v1/comments#create', as: 'api_create_posts_comments'  
end
