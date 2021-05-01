Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'alpha#home'
  get 'about', to: 'alpha#about'
  resources :articles#, only: [:show, :index, :new, :create, :edit, :update]
end
