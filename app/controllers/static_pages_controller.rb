class StaticPagesController < ApplicationController

  def admin
    @users = User.all
  end

  def orders

  end
end
