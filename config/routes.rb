Rails.application.routes.draw do
  resources :blogs
  # get "organizations", to: "organization#index"
  resources :organizations do 
    resources :memberships
  end
  
  devise_for :users, controllers: {
  registrations: 'users/registrations'
}

  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
   root "home#index"
   get "dashboard", to: "home#dashboard"
   
end
