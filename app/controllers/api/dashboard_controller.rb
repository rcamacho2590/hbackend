class Api::DashboardController < ApplicationController
respond_to :json

  def show
    @user = User.find(params[:id])
    @posts = Post.following @user.following
    render :status => 200,
           :json => { :success => true,
                      :posts => @posts.to_json({:include => [:comment, :like, :user]})
           }
  end

end
