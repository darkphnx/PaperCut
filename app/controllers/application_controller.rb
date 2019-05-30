class ApplicationController < ActionController::Base
  before_action :login_required

  private

  def login_required
  end
end
