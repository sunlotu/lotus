Rails.application.routes.draw do

  root to: 'dashboard#index'
  devise_for :users, controllers: { confirmations: 'confirmations' }

  get 'dashboard', to: 'dashboard#index'

  resource :setting, only: [:show, :update] do
    member do
      get 'profile'
      get 'password'
    end
  end

  resources :posts, only: [:index, :create, :destroy]

  namespace :admin do
    resources :account
    resources :roles, except: [:new, :show]
    resources :posts, only: [:index, :create, :destroy]
  end

  namespace :api, defaults: { format: :json } do
    namespace :posts do
      get 'download'
    end
  end

  mount RuCaptcha::Engine => '/captcha'
  mount ActionCable.server => '/cable'
end
