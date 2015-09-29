Rails.application.routes.draw do
  devise_for :users, skip: :registrations, controllers: {
    sessions: 'user/sessions'
  }

  namespace :api do
    resources :users, except: [:new, :edit]
  end
end
