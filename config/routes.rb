Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'user/sessions'
  }

  namespace :api do
    resources :users, except: [:new, :edit]
  end
end
