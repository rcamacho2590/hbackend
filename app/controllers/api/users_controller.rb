class Api::UsersController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:index, :create]
  before_filter :find_user, only: [:show, :update, :destroy]
  respond_to :json

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def create
    user = User.new(user_params)
    if user.save
      render :json => user.as_json(:authentication_token=>user.authentication_token, :email=>user.email), :status=>201
      return
    else
      warden.custom_failure!
      render :json => user.errors, :status=>422
    end
  end

  def update
    @user.update_attributes(user_params)
    render json: @user
  end

  def destroy
    @user.destroy
    render json: @user
  end

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :username,
      :full_name,
      :email,
      :password)
  end
end
