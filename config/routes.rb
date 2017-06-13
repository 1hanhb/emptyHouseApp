Rails.application.routes.draw do
  resources :users do
    resources :homes do
      resources :comments
    end
  end

  resources :sessions, only: [:new, :create, :destroy]


  match '/signup',        to: 'users#new',        via: 'get'
  match '/signin',        to: 'sessions#new',     via: 'get'
  match '/signout',       to: 'sessions#destroy', via: 'delete'
  match '/enroom',        to: 'homes#new',       via: 'get'

  match '/homes', to: 'homes#index', via: 'get'
  match '/homes', to: 'homes#create', via: 'post'
  match '/homes/new', to: 'homes#new', via: 'get'

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
