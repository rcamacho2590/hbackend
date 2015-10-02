class User < ActiveRecord::Base
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, :recoverable

  before_save { self.email = email.downcase }
  before_save { self.username = username.downcase }

  validates :full_name, presence: true, length: { maximum: 100 }
  validates :username, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                  format: { with: VALID_EMAIL_REGEX },
                  uniqueness: { case_sensitive: false }
                  

  def send_password_reset(params)
    code = rand(100000..999999)
    params[:user][:reset_password_code] = code
    self.reset_password_code = params[:user][:reset_password_code]
    self.reset_password_sent_at = Time.zone.now
    save!
    UserMailer.reset_password_email(params[:user]).deliver
  end

end
