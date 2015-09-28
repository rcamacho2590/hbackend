class SessionsController < Devise::SessionsController

  # sign_in
  def create
   self.resource = warden.authenticate!(auth_options)
   sign_in(resource_name, resource)

   current_user.update authentication_token: nil

   respond_to do |format|
     format.json {
       render :json => {
         :user => current_user,
         :status => :ok,
         :info => "Logged in",
         :authentication_token => current_user.authentication_token
       }
     }
   end
  end

  # sign_out
  def destroy

   respond_to do |format|
     format.json {
       if current_user
         current_user.update authentication_token: nil
         signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
         render :json => {}.to_json, :info => "Logged out", :status => :ok
       else
         render :json => {}.to_json, :status => :unprocessable_entity
       end

     }
   end
  end
end
