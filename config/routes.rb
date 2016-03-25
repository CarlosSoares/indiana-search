Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: 'dashboard#index'

  resources :searches, only: [:index]

  resources :projects do
    resources :consumers
    resources :searches, only: [:index]
  end

  namespace :api do
    namespace :v1 do
      scope ':table_name' do
        get 'search/:field/:query', to: 'search#index'
        post '/search', to: 'search#create'
        put '/search/:id', to: 'search#update'
        delete '/search/:id', to: 'search#destroy'
      end
    end
  end
end
