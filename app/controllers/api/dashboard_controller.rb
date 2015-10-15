class Api::DashboardController < ApplicationController
respond_to :json

  def index
    @posts = paginate Post.all.order("created_at DESC"), per_page: 5
    render json: @posts.to_json(
                           :include => [
                             :user, :comment => { :only => [:id, :description, :created_at], :include => [:user]}
                           ])
  end

  def show
    @user = User.find(params[:id])
    @posts = paginate Post.following(@user.following), per_page: 5
    render json: @posts.to_json(
                           :include => [
                             :user, :comment => { :only => [:id, :description, :created_at], :include => [:user]}
                           ])
  end

end
