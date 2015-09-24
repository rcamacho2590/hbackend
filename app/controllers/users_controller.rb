class Api::UsersController < ApplicationController
  before_filter :find_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.create(user_params)
    render json: @user
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
      :email)
  end
end
