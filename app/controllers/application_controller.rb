class ApplicationController < ActionController::Base
  include ActionController::MimeResponds
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  respond_to :json

  acts_as_token_authentication_handler_for User
  before_filter :authenticate_user!
end
