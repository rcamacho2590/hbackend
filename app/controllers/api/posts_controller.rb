class Api::PostsController < ApplicationController
  before_filter :find_post, only: [:show, :update, :destroy]
  respond_to :json

  def index
    @posts = Post.all
    render json: @posts
  end

  def show
    render :status => 200,
           :json => { :success => true,
                      :post => PostSerializer.new(@post).serializable_hash
                    }
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render :status => 200,
             :json => { :success => true,
                        :info => "Post Created",
                        :post => PostSerializer.new(@post).serializable_hash
             }
      return
    else
      warden.custom_failure!
      render :status => 442,
             :json => { :success => false,
                        :info => @post.errors
             }
    end
  end

  def update
    @post.update_attributes(post_params)
    if @post.errors.empty?
      render :status => 200,
             :json => { :success => true,
                        :info => "Post Updated",
                        :post => PostSerializer.new(@post).serializable_hash
                      }
    else
      render :status => 422,
             :json => { :success => false ,
                        :errors => @post.errors
             }
    end
  end

  def destroy
    @post.destroy
    if @post.errors.empty?
      render :status => 200,
             :json => { :success => true,
                        :info => "Post Deleted",
                        :post => PostSerializer.new(@post).serializable_hash
                      }
    else
      render :status => 422,
             :json => { :success => false ,
                        :errors => @post.errors
             }
    end
  end

  def find_post
    @post = Post.find(params[:id])
    if @post.nil?
      render  :status => 404,
              :json => { :success => false,
                         :info => "The post is not registered."
              }
    end
  end

  def find_post_by_user_id
    @posts = Post.find(params[:user_id])
    if @posts.errors.empty?
      render :status => 200,
             :json => { :success => true,
                        :posts => @posts
                      }
    else
      render  :status => 404,
              :json => { :success => false,
                         :info => "The user has no posts registered."
              }
    end
  end

  def post_params
    params.require(:post).permit(
      :user_id,
      :description,
      :location,
      :views,
      :post_type_id,
      :post_file)
  end


end
