class Api::UsersController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:index, :create]
  before_filter :find_user, only: [:show, :update, :destroy, :following , :followers]
  respond_to :json

  def index
    @users = User.all
    render json: @users
  end

  def show
    @posts = @user.post
    @following = @user.following.count
    @followers = @user.followers.count
    render :status => 200,
           :json => { :success => true,
                      :user => UserSerializer.new(@user).serializable_hash,
                      :posts => @posts,
                      :following => @following,
                      :followers => @followers
                    }
  end

  def create
    user = User.new(user_params)
    if user.save
      render :status => 200,
             :json => { :success => true,
                        :info => "User Created",
                        :user => UserSerializer.new(user).serializable_hash
             }
      return
    else
      warden.custom_failure!
      render :status => 442,
             :json => { :success => false,
                        :info => user.errors
             }
    end
  end

  def update
    @user.update_attributes(user_params)
    render :status => 200,
           :json => { :success => true,
                      :info => "User Updated",
                      :user => UserSerializer.new(@user).serializable_hash
                    }
  end

  def destroy
    @user.destroy
    render :status => 200,
           :json => { :success => true,
                      :info => "User Deleted",
                      :user => UserSerializer.new(@user).serializable_hash
                    }
  end

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :username,
      :full_name,
      :email,
      :password,
      :encrypted_password,
      :reset_password_sent_at,
      :reset_password_code,
      :avatar)
  end

  def following
    @users = @user.following
    render :status => 200,
           :json => { :success => true,
                      :following => @users
                    }
  end

  def followers
    @users = @user.followers
    render :status => 200,
           :json => { :success => true,
                      :followers => @users
                    }
  end

end
