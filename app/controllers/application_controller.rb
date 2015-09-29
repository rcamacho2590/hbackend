class ApplicationController < ActionController::Base
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  include ActionController::MimeResponds
  respond_to :json

  acts_as_token_authentication_handler_for User
  before_filter :authenticate_user!
end
