Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # root "users#index"
  root to: "users#index"

  get '/api/users/:user_id/posts/', to: 'api_endpoints#user_posts'
  get '/api/users/:user_id/posts/:post_id/comments', to: 'api_endpoints#user_post_comments'

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
  
end
