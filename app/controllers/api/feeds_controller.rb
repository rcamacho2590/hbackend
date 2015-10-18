class Api::FeedsController < ApplicationController
  before_filter :find_feed, only: [ :update, :destroy]
  respond_to :json

  def show
    @user = User.find(params[:id])
    @feeds = paginate Feed.user_feeds(@user.post), per_page: 10
    @feeds.each do |feed|
         feed.update_attribute(:read, true)
    end
    render :status => 200,
           :json => { :success => true,
             :json => @feeds.to_json(
                            :include => [ :user ])
           }
  end


  def create
    @feed = Feed.new(feed_params)
    if @feed.save
      render :status => 200,
             :json => { :success => true,
                        :info => "Feed Created",
                        :feed => FeedSerializer.new(@feed).serializable_hash
             }
      return
    else
      warden.custom_failure!
      render :status => 442,
             :json => { :success => false,
                        :info => @feed.errors
             }
    end
  end

  def update
    @feed.update_attributes(feed_params)
    if @feed.errors.empty?
      render :status => 200,
             :json => { :success => true,
                        :info => "Feed Updated",
                        :feed => FeedSerializer.new(@feed).serializable_hash
                      }
    else
      render :status => 422,
             :json => { :success => false ,
                        :errors => @feed.errors
             }
    end
  end

  def destroy
    @feed.destroy
    if @feed.errors.empty?
      render :status => 200,
             :json => { :success => true,
                        :info => "Feed Deleted",
                        :feed => FeedSerializer.new(@feed).serializable_hash
                      }
    else
      render :status => 422,
             :json => { :success => false ,
                        :errors => @feed.errors
             }
    end
  end

  def find_feed
    @feed = Feed.find(params[:id])
  end

  private

  def feed_params
    params.require(:feed).permit(
      :user_id,
      :post_id,
      :description,
      :comment_id,
      :like_id,
      :read)
  end

end
