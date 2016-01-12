Rails.application.routes.draw do
  devise_for :users
  root to: "projects#index"

  resources :projects
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  namespace :api do
    namespace :v1 do

      scope ":table_name" do
        resources :indices
      end

    end
  end

end
