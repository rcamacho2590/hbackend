class Api::LikesController < ApplicationController
  before_filter :find_like, only: [:show, :update, :destroy]
  respond_to :json

  def index
    @likes = Like.all
    if @likes.nil?
      render  :status => 404,
              :json => { :success => false,
                         :info => "The user has no likes registered."
              }
    else
      if @likes.errors.empty?
        render :status => 200,
               :json => { :success => true,
                          :likes => @likes
               }
      else
        render :status => 442,
               :json => { :success => false,
                          :info => @like.errors
               }
      end
    end
  ensure
    clean_tempfile
  end

  def create
    @like = Like.new(like_params)
    if @like.save
      render :status => 200,
             :json => { :success => true,
                        :info => "Like Created",
                        :like => LikeSerializer.new(@like).serializable_hash
             }
      return
    else
      warden.custom_failure!
      render :status => 442,
             :json => { :success => false,
                        :info => @like.errors
             }
    end
  end

  def destroy
    @like.destroy
    if @like.errors.empty?
      render :status => 200,
             :json => { :success => true,
                        :info => "Like Deleted",
                        :like => LikeSerializer.new(@like).serializable_hash
                      }
    else
      render :status => 422,
             :json => { :success => false ,
                        :errors => @like.errors
             }
    end
  end

  def find_like
    @like = Like.find(params[:id])
    if @like.nil?
      render  :status => 404,
              :json => { :success => false,
                         :info => "The like is not registered."
              }
    end
  end

  private

  def like_params
    params.require(:like).permit(
      :user_id,
      :post_id)
  end
end
