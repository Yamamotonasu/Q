Rails.application.routes.draw do
  get 'answers/result'
  root 'static_pages#index'
  resources :users do
    get '/questions/apply', to: 'questions#apply'
    get '/questions/new', to: 'questions#new'
    post '/questions/trade', to: 'questions#create'
    get '/questions/trade', to: 'questions#trade'
    resources :questions
    post '/ajax/trade', to: 'answers#create'
  end
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :answers, only: [:create]
end
