class PagesController < ApplicationController
  skip_before_action :login_required

  layout 'sub'

  def home
  end
end
