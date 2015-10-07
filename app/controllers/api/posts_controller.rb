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
  ensure
    clean_tempfile
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
    @posts = Post.find_by_user_id(params[:user_id])
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

  private

  def post_params
    the_params = params.require(:post).permit(:post_file)
    the_params[:post_file] = parse_image_data(the_params[:post_file]) if the_params[:post_file]
    the_params
  end


  def parse_image_data(base64_image)
    filename = "upload-image"
    in_content_type, encoding, string = base64_image.split(/[:;,]/)[1..3]

    @tempfile = Tempfile.new(filename)
    @tempfile.binmode
    @tempfile.write Base64.decode64(string)
    @tempfile.rewind

    # for security we want the actual content type, not just what was passed in
    content_type = `file --mime -b #{@tempfile.path}`.split(";")[0]

    # we will also add the extension ourselves based on the above
    # if it's not gif/jpeg/png, it will fail the validation in the upload model
    extension = content_type.match(/gif|jpeg|png/).to_s
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
