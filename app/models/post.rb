class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comment
  has_many :like
  has_many :feed
  has_one :post_type
  validates :post_file, presence: true
  validates :user_id, presence: true

  mount_base64_uploader :post_file, PostFileUploader

end
