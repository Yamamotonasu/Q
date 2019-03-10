Rails.application.routes.draw do
  root 'static_pages#index'
  get '/signup', to: 'users#new'
  resources :users
  post '/signup', to: 'users#create'
end
