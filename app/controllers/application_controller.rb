class ApplicationController < ActionController::Base
  include ActionController::MimeResponds
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found


  acts_as_token_authentication_handler_for User, fallback_to_devise: false
  before_filter :authenticate_user!


  def record_not_found
    render  :status => 404,
            :json => { :success => false,
                       :info => "The record is not registered."
            }
  end
end
