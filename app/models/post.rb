class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comment
  has_many :like
  has_many :view
  has_many :feed
  has_one :post_type
  validates :file, presence: true
  validates :user_id, presence: true

  scope :following, ->(followers) { where(:user_id => followers).order("created_at DESC") }

  #mount_uploader :file, FileUploader

end
