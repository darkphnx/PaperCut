class ApplicationController < ActionController::Base
  before_action :login_required

  rescue_from Authie::Session::ValidityError, :with => :auth_session_error

  private

  def login_required
    redirect_to root_path unless logged_in?
  end

  def auth_session_error
    redirect_to login_path, alert: "Your session was no longer valid. Please login to continue."
  end
end
