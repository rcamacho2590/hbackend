class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comment
  has_many :like
  has_many :feed
  has_one :post_type
  validates :file, presence: true

  mount_base64_uploader :file, FileUploader

end
