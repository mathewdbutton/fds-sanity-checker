Rails.application.routes.draw do
  get 'validation_runs/show'
  resources :model_loader, only: [:create]
  root "model_loader#new"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
