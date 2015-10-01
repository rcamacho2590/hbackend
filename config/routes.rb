Rails.application.routes.draw do
  devise_for :users, skip: :registrations, controllers: {
    sessions: 'user/sessions',
    passwords: 'user/passwords'
  }

  namespace :api do
    resources :users, except: [:new, :edit]
  end
end
