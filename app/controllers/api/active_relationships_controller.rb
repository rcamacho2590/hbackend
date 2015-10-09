class Api::ActiveRelationshipsController < ApplicationController
  respond_to :json

  def create
    @current_user = User.find(params[:user_id])
    @user = User.find(params[:followed_id])
    @current_user.follow(@user)
    if @current_user.errors.empty?
      render :status => 200,
             :json => { :success => true,
                        :info => "User followed",
                        :user => UserSerializer.new(@user).serializable_hash
                      }
    end
  end

  def destroy
    @current_user = User.find(params[:user_id])
    @user = User.find(params[:id])
    @current_user.unfollow(@user)
    if @current_user.errors.empty?
      render :status => 200,
             :json => { :success => true,
                        :info => "User unfollowed",
                        :user => UserSerializer.new(@user).serializable_hash
                      }
    end
  end

end
