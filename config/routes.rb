Rails.application.routes.draw do

  root 'account#index'
  devise_for :users
  resources :account, only: [:index]
  resources :roles
  resources :role_ships

  resources :posts, only: [:index, :create, :destroy]

  get 'account', to: 'account#index'

  namespace :api, defaults: { format: :json } do
    namespace :posts do
      get 'download'
    end
  end

  mount RuCaptcha::Engine => '/captcha'
end
