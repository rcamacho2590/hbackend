class Api::DashboardController < ApplicationController
respond_to :json

  def show
    @user = User.find(params[:id])
    render :json => @user
  end

end
