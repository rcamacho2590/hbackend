class Api::SearchController < ApplicationController
  respond_to :json

  def by_text

  end

  def most_liked
    @posts = Post.all.liked
    render json: @posts.to_json(
                           :include => [
                             :user, :comment => { :only => [:id, :description, :created_at], :include => [:user => { :only => [:id, :username, :full_name, :email]} ]}
                           ])
  end

  def most_viewed
    @posts = Post.all.viewed
    render json: @posts.to_json(
                           :include => [
                             :user, :comment => { :only => [:id, :description, :created_at], :include => [:user => { :only => [:id, :username, :full_name, :email]} ]}
                           ])
  end

end
