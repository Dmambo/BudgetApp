Rails.application.routes.draw do
  get 'splash/splash'
  root to: 'splash#splash'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :categories, only: [:index, :new, :create] do 
    resources :expenses, only: [:index, :new, :create]
  end

end
