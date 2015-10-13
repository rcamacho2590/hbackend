class Api::DashboardController < ApplicationController
respond_to :json

  def show
    @user = User.find(params[:id])
    @posts = Post.following @user.following
    render :status => 200,
           :json => { :success => true,
             :json => @posts.to_json(
                            :include => [
                              :user, :comment => { :only => [:id, :description, :created_at], :include => [:user]}
                            ])
           }
  end

end
