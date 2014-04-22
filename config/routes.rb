TrustPaths::Application.routes.draw do
  get 'about', to: 'static#about'
  root 'neighbors#index'
  get 'logout' => 'sessions#destroy', :as => 'logout'
  get 'login'  => 'sessions#new',     :as => 'login'
  get 'signup' => 'users#new',        :as => 'signup'
  resources :users
  resources :neighbors
end
