Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # "As a guest user, I want to search a product type"
  get "/products" => "products#index"

  # "As a guest user, I want to select multiple stores"
  get "/preferences" => "pages#preferences"

  # "As a guest user, I want to update the stores I selected"
  patch "/preferences" => "pages#update_preferences"

  # "As a guest user, I want to view the items in my list"
  get "/list_items" => "list_items#index"
end
