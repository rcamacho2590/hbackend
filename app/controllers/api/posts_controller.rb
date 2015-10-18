class Api::PostsController < ApplicationController
  before_filter :find_post, only: [:show, :update, :destroy]
  respond_to :json

  def index
    @posts = Post.all
    if @posts.nil?
      render  :status => 404,
              :json => { :success => false,
                         :info => "The user has no posts registered."
              }
    else
      render :status => 200,
             :json => { :success => true,
                        :posts => @posts
             }
    end
  ensure
    clean_tempfile
  end

  def show
    @comments = @post.comment
    @likes = @post.like
    @user = @post.user
    render :status => 200,
           :json => { :success => true,
                      :post => PostSerializer.new(@post).serializable_hash,
                      :comments => @comments,
                      :likes => @likes,
                      :user => UserSerializer.new(@user).serializable_hash
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

  private

  def post_params
    the_params = params.require(:post).permit(
      :user_id,
      :description,
      :location,
      :post_type_id,
      :file)
    the_params[:file] = parse_data(the_params[:file]) if the_params[:file]
    the_params
  end

  def parse_data(base64_file)
    filename = "file"

    content_type, encoding, string = base64_file.split(/[:;,]/)[1..3]

    @tempfile = Tempfile.new(filename)
    @tempfile.binmode
    @tempfile.write Base64.decode64(string)
    @tempfile.rewind

    extension = content_type.match(/png|gif|jpeg|jpg|mov|mp4|m4v|3gp|ogg|ogv|webm|m2v|3g2/).to_s
    filename += ".#{extension}" if extension

    ActionDispatch::Http::UploadedFile.new({
      tempfile: @tempfile,
      content_type: content_type,
      filename: filename
    })
  end

  def clean_tempfile
    if @tempfile
      @tempfile.close
      @tempfile.unlink
    end
  end

end
