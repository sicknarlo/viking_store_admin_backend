class OrdersController < ApplicationController

  def index
    if User.exists?(params[:user_id])
      @orders = Order.where(:user_id => params[:user_id])
      @user = User.find(params[:user_id])
      @title = "Viking Store Orders for #{@user.full_name}"
      @show_all = false
    else
      @orders = Order.all
      @title = "Viking Store All Orders"
      @show_all = true
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @order = @user.orders.new
  end

  def create
    @order = Order.new(whitelisted_params)
    @order.user_id = params[:order][:user_id]
    if @order.save
      flash[:success] = "Order Created!"
      redirect_to edit_order_path(@order)
    else
      flash[:error] = "Failed to Create Order"
      render :new
    end
  end

  def edit
    @order = Order.find(params[:id])
    @order_contents = OrderContent.where(:order_id => @order.id)
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(whitelisted_params)
      flash[:success] = "Order Updated!"
      redirect_to order_path(@order)
    else
      flash[:error] = "Order Failed to Update!"
      render :edit
    end

  end

  private

  def whitelisted_params
    params.require(:order).permit(:checkout_date, :user_id, :shipping_id, :billing_id)
  end


end
