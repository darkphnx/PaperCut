Rails.application.routes.draw do
  resources :events do
    resources :submissions do
      post :shortlist, to: 'shortlist#create'
      delete :shortlist, to: 'shortlist#destroy'
    end

    get 'vote/:voting_token', to: 'voting#index', as: 'vote'
    post 'vote/:voting_token', to: 'voting#create'
  end

  get 'register', to: 'registration#new'
  post 'register', to: 'registration#create'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  root 'pages#home'
end
