Rails.application.routes.draw do
  resources :charges

  devise_for :users
  root to: 'store#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
