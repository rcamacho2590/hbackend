class Api::PostTypesController < ApplicationController
    before_filter :find_post_type, only: [:show, :update, :destroy]
    respond_to :json

    def index
      @post_types = PostType.all
      render json: @post_types
    end

    def show
      render :status => 200,
             :json => { :success => true,
                        :post => PostTypeSerializer.new(@post_type).serializable_hash
                      }
    end

    def create
      @post_type = PostType.new(post_type_params)
      if @post_type.save
        render :status => 200,
               :json => { :success => true,
                          :info => "Post Type Created",
                          :post => PostTypeSerializer.new(@post_type).serializable_hash
               }
        return
      else
        warden.custom_failure!
        render :status => 442,
               :json => { :success => false,
                          :info => @post_type.errors
               }
      end
    end

    def update
      @post_type.update_attributes(post_type_params)
      if @post_type.errors.empty?
        render :status => 200,
               :json => { :success => true,
                          :info => "Post Type Updated",
                          :post => PostTypeSerializer.new(@post_type).serializable_hash
                        }
      else
        render :status => 422,
               :json => { :success => false ,
                          :errors => @post_type.errors
               }
      end
    end

    def destroy
      @post_type.destroy
      if @post_type.errors.empty?
        render :status => 200,
               :json => { :success => true,
                          :info => "Post Type Deleted",
                          :post => PostTypeSerializer.new(@post_type).serializable_hash
                        }
      else
        render :status => 422,
               :json => { :success => false ,
                          :errors => @post_type.errors
               }
      end
    end

    def find_post_type
      @post_type = PostType.find(params[:id])
    end

    private

    def post_type_params
      params.require(:post_type).permit(
        :description)
    end
end
