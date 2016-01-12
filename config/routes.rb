Rails.application.routes.draw do
  devise_for :users

  resources :projects
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
