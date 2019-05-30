class SessionsController < ApplicationController
  skip_before_action :login_required

  layout 'sub'

  def new
  end

  def create
    if user = User.authenticate(params[:email_address], params[:password])
      self.current_user = user
      redirect_to root_path
    else
      flash.now[:alert] = "Username/password was not recognised"
      render 'new'
    end
  end

  def destroy
    auth_session.invalidate!
    redirect_to root_path
  end
end
