class StaticPagesController < ApplicationController

  def admin
    @users = User.all
  end
end
