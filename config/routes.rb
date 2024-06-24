Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    scope module: :v1, constraints: ApiVersionConstraint.new(version: 1) do
      resources :brands, only: [:index, :create] do
        resources :models, on: :member, only: [:index, :create]
      end
      resources :models, only: [:index, :update]
    end
  end
end
