Rails.application.routes.draw do
  resources :users
  resources :widgets
  resources :sessions do
    get 'forgot_password', on: :collection
    post 'reset_password', on: :collection
  end
  resources :registrations
  root to: 'widgets#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
