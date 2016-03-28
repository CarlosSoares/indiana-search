Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: 'dashboard#index'

  resources :searches, only: [:index]

  resources :projects do
    get 'search/:search', to: 'projects#search', on: :member
    resources :consumers
    resources :searches, only: [:index]
  end

  namespace :api do
    namespace :v1 do
      scope ':table_name' do
        get 'search/:field/:query', to: 'search#index'
        resources :index, only: [:create, :update, :destroy]
      end
    end
  end
end
