class OrdersController < ApplicationController

  def index
    if User.exists?(params[:user_id])
      @orders = Order.where(:user_id => params[:user_id])
      @user = User.find(params[:user_id])
    else
      @orders = Order.all
    end
  end

  def show
  end


end
