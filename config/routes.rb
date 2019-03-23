Rails.application.routes.draw do
  get 'answers/result'
  root 'static_pages#index'
  resources :users do
    get '/apply_trade', to: 'relations#apply'
    post '/apply_trade', to: 'relations#create'
    get '/questions/new', to: 'questions#new'
    post '/questions/trade', to: 'questions#create'
    get '/questions/trade', to: 'questions#trade'
    get '/questions/:id', to: 'questions#show'
    post '/questions/:id', to: 'questions#enable'
    resources :questions
  end
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :answers, only: [:create]
  post '/apply_trade', to: 'relations#create'
end
