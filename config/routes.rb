Rails.application.routes.draw do
  # get 'questions/new'
  # get 'questions/create'
  # get 'questions/trade'
  # get 'sessions/new'
  root 'static_pages#index'

  resources :users do
    get 'questions/trade', to: 'questions#trade'
    post 'questions/trade', to: 'questions#create'
    resources :questions
  end
  # get 'questions/trade', to: 'questions#trade'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
