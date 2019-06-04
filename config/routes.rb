Rails.application.routes.draw do
  resources :events do
    resources :submissions do
      get :upload, on: :collection
      post :upload, action: :process_upload, on: :collection
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
