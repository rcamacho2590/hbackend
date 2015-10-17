class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, counter_cache: true
  has_one :feed
  validates :post_id, presence: true
  validates :user_id, presence: true
  validates :description, presence: true
  after_create :create_feed
  before_destroy :delete_feed

  default_scope { order('created_at DESC') }


  private

  def create_feed
      Feed.create(
      post_id: self.post_id,
      user_id: self.user_id,
      comment_id: self.id,
      read: false
        )
  end

  def delete_feed
    Feed.where(:comment_id => self.id).destroy_all
  end

end
