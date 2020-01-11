Rails.application.routes.draw do
  # make the posts index the root path
  root 'posts#index'
  get    '/signup',  to: 'users#new'
  get    '/users',  to: 'users#show'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users

  resources :posts, only: [:new, :create, :index]
end
