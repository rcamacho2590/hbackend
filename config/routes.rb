Rails.application.routes.draw do
  devise_for :users, skip: :registrations, controllers: {
    sessions: 'user/sessions',
    passwords: 'user/passwords'
  }

  devise_scope :user do
    post "users/password/verify_code" => "user/passwords#verify_code"
  end

  namespace :api do
    resources :users, except: [:new, :edit]
    resources :feeds, except: [:new, :edit]
    resources :comments, except: [:new, :edit]
    resources :likes, except: [:new, :edit]
    resources :active_relationships, except: [:new, :edit]
    resources :posts, except: [:new, :edit]
    resources :post_types, except: [:new, :edit]
  end
end
