Rails.application.routes.draw do
  get 'register', to: 'register#new'
  post 'register', to: 'register#create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  root 'pages#home'
end
