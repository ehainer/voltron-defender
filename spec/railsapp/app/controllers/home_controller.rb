class HomeController < ApplicationController

  def index
    @user = User.find(0)
    render plain: @user.name
  end

end