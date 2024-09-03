Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"

   root "home#index"
   get "dashboard", to: "home#dashboard"

   resources :organizations, only: [:index] do 
    resources :memberships do
      collection do
        post :invite
      end
    end
  end
  resources :blogs do
    resources :comments
      collection do
        get :my_blogs  
      end
  end
  
  devise_for :users, controllers: {
  registrations: 'users/registrations'
}

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  
   
end
