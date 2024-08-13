Rails.application.routes.draw do
  resources :users
  resources :brands do
    member do
      patch 'activate'
      patch 'deactivate'
    end
  end
  resources :products do
    member do
      patch 'activate'
      patch 'deactivate'
    end
  end

  get '/auth/:provider/callback', to: 'sessions#google_callback'
  get '/auth/google/url', to: 'sessions#google_auth_redirect'


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  post 'messages', to: 'messages#create'

end
