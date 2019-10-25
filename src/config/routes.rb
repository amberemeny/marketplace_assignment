Rails.application.routes.draw do
  resources :addresses
  devise_for :users
  root 'pages#index'
  # devise_for :users, controllers: {
  #       sessions: 'users/sessions'
  #     }
end
