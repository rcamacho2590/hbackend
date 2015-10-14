class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, counter_cache: true
  validates :post_id, presence: true
  validates :user_id, presence: true
  validates :description, presence: true
  after_create :create_feed

  private

  def create_notification
      Feed.create(
      post_id: self.post_id,
      user_id: self.user_id,
      comment_id: self.id,
      read: false
        )
  end

end
