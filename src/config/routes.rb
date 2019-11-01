Rails.application.routes.draw do
  resources :orders
  get "myorder", to: 'orders#myorder'
  get "addtoorder/:id", to: 'orders#addtoorder', as: "addtoorder"
  resources :listings
  get "mylistings", to: 'listings#mylistings'
  resources :addresses
  devise_for :users
  root 'pages#index'
  # devise_for :users, controllers: {
  #       sessions: 'users/sessions'
  #     }
end
