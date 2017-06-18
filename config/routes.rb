Rails.application.routes.draw do
  resources :hosts
  devise_for :users
  scope "/users" do
    resources :users
  end

  get 'admin/index'  

  get 'users/new'
  get 'home/index'
  
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
