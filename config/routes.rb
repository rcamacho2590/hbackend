Rails.application.routes.draw do
  devise_for :users
  get 'users/new'

  namespace :api do
    resources :users, except: [:new, :edit]
  end
end
