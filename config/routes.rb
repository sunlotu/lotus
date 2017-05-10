Rails.application.routes.draw do

  root to: 'dashboards#index'
  devise_for :users, controllers: { confirmations: 'confirmations' }

  get 'dashboards', to: 'dashboards#index'

  resources :dashboards

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
      get 'statistics'
    end
  end

  mount RuCaptcha::Engine => '/captcha'
  mount ActionCable.server => '/cable'
end
