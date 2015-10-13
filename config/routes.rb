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
    resources :dashboard, only: [:show]
    #resources :feeds, except: [:new, :edit]
    resources :comments, except: [:new, :edit, :show]
    resources :likes, except: [:new, :edit, :show]
    resources :active_relationships, only: [:create, :destroy]
    resources :posts, except: [:new, :edit]
    resources :post_types, except: [:new, :edit]
  end

end
