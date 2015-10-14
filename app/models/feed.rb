class Feed < ActiveRecord::Base
  belongs_to :post
  has_one :user
  has_one :comment
  has_one :like
  validates :user_id, presence: true
  validates :post_id, presence: true

  scope :following, ->(followers) { where(:user_id => followers).order("created_at DESC") }

end
