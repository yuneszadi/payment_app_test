Rails.application.routes.draw do
  devise_for :users
  get 'payments/new'

  get 'payments/index'

  get 'microdeposits/new'

  resource :banks


  root to: 'store#index'
  resources :charges
  resources :payments
  resources :microdeposits

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
