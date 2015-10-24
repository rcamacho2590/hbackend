class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comment
#  has_many :recent_comments, -> { order('id DESC').limit(5) }, class_name: 'Comment'
  has_many :like
  has_many :view
  has_many :feed
  has_one :post_type
  validates :file, presence: true
  validates :user_id, presence: true
  before_destroy :delete_comments
  before_destroy :delete_likes

  scope :following, ->(followers) { where(:user_id => followers).order("created_at DESC") }
  scope :liked, ->{ where(:created_at => (Date.today - 7)..(Date.today)).order("likes_count DESC, created_at DESC") }
  scope :viewed, ->{ where(:created_at => (Date.today - 7)..(Date.today)).order("views_count DESC, created_at DESC") }
  scope :match_location, ->(text) { where("location LIKE ? OR description LIKE ? ", "%#{text}%", "%#{text}%") }

  mount_uploader :file, FileUploader

  def delete_comments
    Comment.where(:post_id => self.id).destroy_all
  end

  def delete_likes
    Like.where(:post_id => self.id).destroy_all
  end

end
