class User::PasswordsController < Devise::PasswordsController
  skip_before_filter :verify_signed_out_user
  before_filter :find_user_by_email
  respond_to :json

  # POST /users/password
  def create
    @user.send_password_reset(params) if @user
    render  :status => 200,
            :json => { :success => true,
                       :info => "Reset password instructions sended.",
                       :reset_password_code => @user.reset_password_code
            }
  end

  # POST /users/verify_code
  def verify_code
    if params[:user][:reset_password_code] == @user.reset_password_code
      render  :status => 200,
              :json => { :success => true,
                         :info => "Reset password code valid."
              }
    else
      render  :status => 422,
              :json => { :success => false,
                         :info => "Reset password code invalid."
              }
    end
  end

  # PUT /users/password
  def update
    if @user.reset_password_sent_at < 2.hours.ago
      render  :status => 422,
              :json => { :success => false,
                         :info => "Password reset has expired."
              }
    elsif @user.update_attributes(params.require(:user).permit(:password, :password_confirmation))
      resource=@user
      if resource.errors.empty?
        resource.unlock_access! if unlockable?(resource)
        sign_in(resource_name, resource)
        render  :status => 200,
                :json => { :success => true,
                           :info => "Password has been reset.",
                           :user => UserSerializer.new(@user).serializable_hash
                }
      end
    else
      render :status => 422,
             :json => { :success => false ,
                        :errors => @user.errors
             }
    end
  end

  # FOR ALL ACTIONS
  def find_user_by_email
    @user = User.find_by_email!(params[:user][:email])
  end

end
