class User::PasswordsController < Devise::PasswordsController
  skip_before_filter :verify_signed_out_user
  respond_to :json

  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  def create
    code = rand(100000..999999)
    params[:user][:reset_password_code] = code

    User.find_by(email: params[:user][:email]).update(reset_password_code: params[:user][:reset_password_code])

    @user = UserMailer.reset_password_email(params[:user]).deliver
    render  :status => 200,
            :json => { :success => true,
                       :info => "reset password instructions sended"
            }
  end

  #get
  def verify_code
    puts 'AAAAA'*50
    puts params
    puts 'EEEEE'*50
    @user = User.find_by(email: params[:user][:email])
    if params[:user][:reset_password_code] == @user.reset_password_code
      render  :status => 200,
              :json => { :success => true,
                         :info => "reset password code valid"
              }
    else
      render :status => 422, :json => { :success => false }
    end
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    self.resource = resource_class.find_or_initialize_with_error_by(:reset_password_token, params[:reset_password_token])
    @user = resource
  end

  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
        sign_in(resource_name, resource)
        puts resource.inspect
        render :status => 200,
               :json => { :success => true,
                          :info => "password reset",
                          :user => UserSessionSerializer.new(resource).serializable_hash
               }
    else
      puts resource.errors.inspect
      render :status => 422, :json => { :success => false, :errors => resource.errors }
    end
  end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
