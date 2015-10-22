class Api::SearchController < ApplicationController
  respond_to :json

  def by_text
    @posts = paginate Post.all.match_location(params[:search]), per_page: 8
    render :status => 200,
           :json => { :success => true,
                      :users => @posts
                    }
  end

  def by_username
    @users = paginate User.all.match_username(params[:search]), per_page: 8
    render :status => 200,
           :json => { :success => true,
                      :users => @users
                    }
  end

  def most_liked
    @posts = paginate Post.all.liked, per_page: 5
    render json: @posts.to_json(
                           :include => [
                             :user, :comment => { :only => [:id, :description, :created_at], :include => [:user => { :only => [:id, :username, :full_name, :email]} ]}
                           ])
  end

  def most_viewed
    @posts = paginate Post.all.viewed, per_page: 5
    render json: @posts.to_json(
                           :include => [
                             :user, :comment => { :only => [:id, :description, :created_at], :include => [:user => { :only => [:id, :username, :full_name, :email]} ]}
                           ])
  end

end
