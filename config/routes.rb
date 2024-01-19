Rails.application.routes.draw do
  get 'home/index'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root to: "pages#splash"

  resources :users, only: [:index, :new, :create, :show, :destroy, :edit, :update] do
    resources :expenses, only: [:index, :new, :create, :show, :destroy, :edit, :update, :all]
    resources :categories, only: [:index, :new, :create, :show, :destroy, :edit, :update]
  end

  resources :expenses, only: [:index, :all] do
    collection do
      get :most_recent
      get :most_ancient
    end
  end

  resources :categories, only: [:index, :new, :create, :show, :destroy, :edit, :update]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end