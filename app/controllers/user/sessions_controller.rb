class User::SessionsController < Devise::SessionsController
 skip_before_filter :verify_signed_out_user
 respond_to :json

 def create
   self.resource = warden.authenticate!(failed_auth_options)
   sign_in(resource_name, resource)
   render :status => 200,
          :json => { :success => true,
                     :info => "Logged in",
                     :user => UserSerializer.new(current_user).serializable_hash
          }
 end

 def destroy
   signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
   render :status => 200,
          :json => { :success => true,
                     :info => "Logged out",
          }
 end

 def failure
   render :status => 401,
          :json => { :success => false,
                     :info => "Login Credentials Failed"
          }
 end

 def show_current_user
   warden.authenticate!(failed_auth_options)
   render :status => 200,
          :json => { :success => true,
                     :info => "Current User",
                     :user => UserSerializer.new(current_user).serializable_hash
          }
 end

 def failed_auth_options
   { :scope => resource_name, :recall => "#{controller_path}#failure" }
 end



# before_filter :configure_sign_in_params, only: [:create]


 # protected

 # You can put the params you want to permit in the empty array.
 # def configure_sign_in_params
 #   devise_parameter_sanitizer.for(:sign_in) << :attribute
 # end
end
