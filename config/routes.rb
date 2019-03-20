Rails.application.routes.draw do
  get 'answers/result'
  root 'static_pages#index'
  # post '/ajax_1', to: 'answers#create'
  resources :users do
    get '/questions/new', to: 'questions#new'
    post '/questions/trade', to: 'questions#create'
    get '/questions/trade', to: 'questions#trade'
    # post 'answer/result', to: 'answers#create'
    resources :questions
    post '/ajax/trade', to: 'answers#create'
  end
  # get 'questions/trade', to: 'questions#trade'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :answers, only: [:create]
end
