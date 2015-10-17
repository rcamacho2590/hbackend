class View < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, counter_cache: true
  validates :post_id, presence: true
  validates :user_id, presence: true

  default_scope { order('created_at DESC') }

end
