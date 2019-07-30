Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'places#index'
  resources :users, only: [:show]
  resources :places do
    collection do
      get 'search'
    end
  end
  resources :reviews do
    collection do
      get 'search'
    end
  end
end
