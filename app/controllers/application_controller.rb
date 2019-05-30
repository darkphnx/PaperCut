class ApplicationController < ActionController::Base
  before_action :login_required

  private

  def login_required
    redirect_to root_path unless logged_in?
  end
end
