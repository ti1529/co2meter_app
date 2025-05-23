Rails.application.routes.draw do
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
    post "users/guest_admin_sign_in", to: "users/sessions#guest_admin_sign_in"
  end
  post "branches/inquire", to: "branches#inquire", as: :inquire_branches
  get "search", to: "dashboards#index"
  get "dashboards/index"
  resources :co2_emission_factors, only: [ :index, :new, :create, :edit, :update, :destroy ]
  resources :branch_fiscal_year_stats, only: [ :index, :new, :create, :edit, :update, :destroy ]
  resources :branches
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  root "dashboards#index"

  resources :companies
  resources :users, only: [ :index, :show ]
  namespace :admin do
    resources :users
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
