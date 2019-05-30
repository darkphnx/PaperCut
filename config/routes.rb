Rails.application.routes.draw do
  resources :events

  get 'register', to: 'registration#new'
  post 'register', to: 'registration#create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  root 'pages#home'
end
