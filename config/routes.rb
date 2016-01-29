Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'users/registrations'}
  root to: 'projects#index'

  resources :projects do
    resources :consumers
  end
  resources :searches, only: [:index]

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
