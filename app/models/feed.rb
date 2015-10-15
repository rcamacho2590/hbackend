class Feed < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  has_one :comment
  has_one :like
  validates :user_id, presence: true
  validates :post_id, presence: true

  scope :user_feeds, ->(posts) { where(:post_id => posts).order("created_at DESC") }

end
