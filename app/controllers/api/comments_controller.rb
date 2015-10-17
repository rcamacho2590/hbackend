class Api::CommentsController < ApplicationController
  before_filter :find_comment, only: [:show, :update, :destroy]
  respond_to :json

  def index
    @comments = Comment.all
    if @comments.nil?
      render  :status => 404,
              :json => { :success => false,
                         :info => "The user has no comments registered."
              }
    else
      render :status => 200,
             :json => { :success => true,
                        :comments => @comments
             }
    end
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render :status => 200,
             :json => { :success => true,
                        :info => "Comment Created",
                        :comment => CommentSerializer.new(@comment).serializable_hash
             }
      return
    else
      warden.custom_failure!
      render :status => 442,
             :json => { :success => false,
                        :info => @comment.errors
             }
    end
  end

  def update
    @comment.update_attributes(comment_params)
    if @comment.errors.empty?
      render :status => 200,
             :json => { :success => true,
                        :info => "Comment Updated",
                        :comment => CommentSerializer.new(@comment).serializable_hash
                      }
    else
      render :status => 422,
             :json => { :success => false ,
                        :errors => @comment.errors
             }
    end
  end

  def destroy
    @comment.destroy
    if @comment.errors.empty?
      render :status => 200,
             :json => { :success => true,
                        :info => "Comment Deleted",
                        :comment => CommentSerializer.new(@comment).serializable_hash
                      }
    else
      render :status => 422,
             :json => { :success => false ,
                        :errors => @comment.errors
             }
    end
  end

  def find_comment
    @comment = Comment.find(params[:id])
    if @comment.nil?
      render  :status => 404,
              :json => { :success => false,
                         :info => "The comment is not registered."
              }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(
      :user_id,
      :description,
      :post_id)
  end

end
