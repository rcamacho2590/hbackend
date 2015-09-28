Rails.application.routes.draw do
  devise_for :users, skip: :registrations

  namespace :api do
    resources :users, except: [:new, :edit]
  end
end
