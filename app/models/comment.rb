class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, counter_cache: true
  validates :post_id, presence: true
  validates :user_id, presence: true
  validates :description, presence: true

end
