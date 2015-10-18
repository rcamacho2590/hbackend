class Api::ViewsController < ApplicationController
  respond_to :json

  def index
    @views = View.all
    if @views.nil?
      render  :status => 404,
              :json => { :success => false,
                         :info => "The user has no views registered."
              }
    else
      render :status => 200,
             :json => { :success => true,
                        :views => @views
             }
    end
  end

  def create
    @view = View.new(view_params)
    if @view.save
      render :status => 200,
             :json => { :success => true,
                        :info => "View Created",
                        :view => ViewSerializer.new(@view).serializable_hash
             }
      return
    else
      warden.custom_failure!
      render :status => 442,
             :json => { :success => false,
                        :info => @view.errors
             }
    end
  end

  private

  def view_params
    params.require(:view).permit(
      :user_id,
      :post_id)
  end
end
