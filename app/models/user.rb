class User < ActiveRecord::Base
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, :recoverable
  has_many :active_relationships,  class_name:  "ActiveRelationship",
                                   foreign_key: "follower_id",
                                   dependent:   :destroy
  has_many :passive_relationships, class_name:  "ActiveRelationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :post

  before_save { self.email = email.downcase }
  before_save { self.username = username.downcase }

  validates :full_name, presence: true, length: { maximum: 100 }
  validates :username, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                  format: { with: VALID_EMAIL_REGEX },
                  uniqueness: { case_sensitive: false }

  mount_base64_uploader :avatar, FileUploader

  def send_password_reset(params)
    code = rand(100000..999999)
    params[:user][:reset_password_code] = code
    self.reset_password_code = params[:user][:reset_password_code]
    self.reset_password_sent_at = Time.zone.now
    save!
    UserMailer.reset_password_email(params[:user]).deliver
  end

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

end
