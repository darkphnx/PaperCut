class RegistrationController < ApplicationController
  skip_before_action :login_required

  layout 'sub'

  def new
    @user = User.new
  end

  def create
    @user = User.new(safe_user_params)

    if @user.save
      self.current_user = @user
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def safe_user_params
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
  end
end
