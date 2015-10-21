Rails.application.routes.draw do
  devise_for :users, skip: :registrations, controllers: {
    sessions: 'user/sessions',
    passwords: 'user/passwords'
  }

  devise_scope :user do
    post "users/password/verify_code" => "user/passwords#verify_code"
  end

  namespace :api do
    resources :users, except: [:new, :edit] do
      member do
        get :following, :followers
      end
    end
    resources :dashboard, only: [:show, :index]
    scope :search, :controller => 'search' do
      get :most_liked
      get :most_viewed
      get :by_text
    end
    resources :feeds, except: [:new, :edit]
    resources :comments, except: [:new, :edit, :index]
    resources :likes, except: [:new, :edit, :show, :update, :index]
    resources :views, only: [:create, :index]
    resources :active_relationships, only: [:create, :destroy]
    resources :posts, except: [:new, :edit] do
      member do
        get :comments, :likes
      end
    end
    resources :post_types, except: [:new, :edit, :show]
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
