Rails.application.routes.draw do
  get 'validation_runs/show'
  resources :model_loader
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
